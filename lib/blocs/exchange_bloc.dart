import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:currency/repositories/repositories.dart';
import 'package:currency/models/models.dart';

abstract class ExchangeState extends Equatable {
  ExchangeState([List props = const []]) : super(props);

  ExchangeUninitialized reset() {
    return ExchangeUninitialized();
  }

  ExchangeState set({
    Rate rate,
    Value valueA,
    Value valueB,
    bool reverse,
  });

  ExchangeLoaded refreshRate({Rate rate}) {
    return this.reset().refreshRate(rate: rate);
  }
}

class ExchangeUninitialized extends ExchangeState {
  final Value valueA;
  final Value valueB;
  final bool reverse;

  ExchangeUninitialized({
    Value valueA,
    Value valueB,
    bool reverse,
  })  : valueA = valueA == null ? Value.zero('USD') : valueA,
        valueB = valueB == null ? Value.zero('MXN') : valueB,
        reverse = reverse == null ? false : reverse,
        super([valueA, valueB, reverse]);

  @override
  ExchangeLoaded refreshRate({Rate rate}) {
    return ExchangeLoaded(
      rate: rate,
      valueA: this.valueA.amount == 0.0
          ? Value((b) => b
            ..amount = 1.0
            ..currency = this.valueA.currency)
          : this.valueA,
      valueB: this.valueB,
      reverse: this.reverse,
    );
  }

  @override
  ExchangeState set({
    Rate rate,
    Value valueA,
    Value valueB,
    bool reverse,
  }) {
    if (rate != null) {
      return ExchangeLoaded(
        rate: rate,
        valueA: valueA == null ? this.valueA : valueA,
        valueB: valueB == null ? this.valueB : valueB,
        reverse: reverse == null ? this.reverse : reverse,
      );
    }

    return ExchangeUninitialized(
      valueA: valueA == null ? this.valueA : valueA,
      valueB: valueB == null ? this.valueB : valueB,
      reverse: reverse == null ? this.reverse : reverse,
    );
  }

  @override
  String toString() => 'ExchangeUninitialized';
}

class ExchangeLoaded extends ExchangeState {
  final Rate rate;
  final Value valueA;
  final Value valueB;
  final bool reverse;

  ExchangeLoaded({
    @required this.rate,
    @required valueA,
    @required valueB,
    @required this.reverse,
  })  : assert(reverse ? valueB.amount != null : valueA.amount != null),
        assert(rate.rates.keys.contains(valueA.currency)),
        assert(rate.rates.keys.contains(valueB.currency)),
        valueA = reverse
            ? _applyRate(
                rate: rate,
                from: valueB.currency,
                to: valueA.currency,
                amount: valueB.amount)
            : valueA,
        valueB = reverse
            ? valueB
            : _applyRate(
                rate: rate,
                from: valueA.currency,
                to: valueB.currency,
                amount: valueA.amount),
        super([valueA, valueB, reverse]);

  static Value _applyRate({Rate rate, String from, String to, double amount}) {
    return Value((b) => b
      ..currency = to
      ..amount = (amount / rate.rates[from]) * rate.rates[to]);
  }

  @override
  ExchangeLoaded refreshRate({Rate rate}) {
    return ExchangeLoaded(
      rate: rate,
      valueA: this.valueA,
      valueB: this.valueB,
      reverse: this.reverse,
    );
  }

  @override
  ExchangeState set({
    Rate rate,
    Value valueA,
    Value valueB,
    bool reverse,
  }) {
    return ExchangeLoaded(
      rate: rate == null ? this.rate : rate,
      valueA: valueA == null ? this.valueA : valueA,
      valueB: valueB == null ? this.valueB : valueB,
      reverse: reverse == null ? this.reverse : reverse,
    );
  }

  @override
  String toString() => reverse
      ? 'ExchangeLoaded { from: $valueB, to: $valueA } }'
      : 'ExchangeLoaded { from: $valueA, to: $valueB } }';
}

class ExchangeError extends ExchangeState {
  final String error;

  ExchangeError({@required this.error}) : super([error]);

  @override
  ExchangeState set({
    Rate rate,
    Value valueA,
    Value valueB,
    bool reverse,
  }) {
    return this.reset().set(
          rate: rate,
          valueA: valueA,
          valueB: valueB,
          reverse: reverse,
        );
  }

  @override
  String toString() => 'ExchangeError { error: $error }';
}

abstract class ExchangeEvent extends Equatable {
  ExchangeEvent([List props = const []]) : super(props);
}

class RefreshRates extends ExchangeEvent {}

class SetValueA extends ExchangeEvent {
  final Value value;

  SetValueA({@required this.value}) : super([value]);
}

class SetValueB extends ExchangeEvent {
  final Value value;

  SetValueB({@required this.value}) : super([value]);
}

// class ToggleReverse extends ExchangeEvent {}

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  final RatesRepository ratesRepository;

  ExchangeBloc({@required this.ratesRepository})
      : assert(ratesRepository != null);

  @override
  ExchangeState get initialState => ExchangeUninitialized();

  @override
  Stream<ExchangeState> mapEventToState(
    ExchangeState currentState,
    ExchangeEvent event,
  ) async* {
    if (event is RefreshRates) {
      try {
        final Rate rate = await ratesRepository.fetchLatestRates();
        yield currentState.refreshRate(rate: rate);
      } catch (e) {
        yield ExchangeError(error: e.toString());
      }
    }

    if (event is SetValueA) {
      yield currentState.set(valueA: event.value);
      this.dispatch(RefreshRates());
    }

    if (event is SetValueB) {
      yield currentState.set(valueB: event.value);
      this.dispatch(RefreshRates());
    }

    // if (event is ToggleReverse) {
    //   if (currentState is ExchangeError) {
    //     ExchangeUninitialized state = currentState.reset();
    //     yield state.set(reverse: !state.reverse);
    //   }

    //   if (currentState is ExchangeUninitialized) {
    //     yield currentState.set(reverse: !currentState.reverse);
    //   }

    //   if (currentState is ExchangeLoaded) {
    //     yield currentState.set(reverse: !currentState.reverse);
    //   }
    // }
  }
}
