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
    Amount amountA,
    Amount amountB,
    bool reverse,
  });

  ExchangeLoaded refreshRate({Rate rate}) {
    return this.reset().refreshRate(rate: rate);
  }
}

class ExchangeUninitialized extends ExchangeState {
  final Amount amountA;
  final Amount amountB;
  final bool reverse;

  ExchangeUninitialized({
    Amount amountA,
    Amount amountB,
    bool reverse,
  })  : amountA = amountA == null ? Amount.zero('USD') : amountA,
        amountB = amountB == null ? Amount.zero('MXN') : amountB,
        reverse = reverse == null ? false : reverse,
        super([amountA, amountB, reverse]);

  @override
  ExchangeLoaded refreshRate({Rate rate}) {
    return ExchangeLoaded(
      rate: rate,
      amountA: this.amountA.value == 0.0
          ? Amount((b) => b
            ..value = 1.0
            ..currency = this.amountA.currency)
          : this.amountA,
      amountB: this.amountB,
      reverse: this.reverse,
    );
  }

  @override
  ExchangeState set({
    Rate rate,
    Amount amountA,
    Amount amountB,
    bool reverse,
  }) {
    if (rate != null) {
      return ExchangeLoaded(
        rate: rate,
        amountA: amountA == null ? this.amountA : amountA,
        amountB: amountB == null ? this.amountB : amountB,
        reverse: reverse == null ? this.reverse : reverse,
      );
    }

    return ExchangeUninitialized(
      amountA: amountA == null ? this.amountA : amountA,
      amountB: amountB == null ? this.amountB : amountB,
      reverse: reverse == null ? this.reverse : reverse,
    );
  }

  @override
  String toString() => 'ExchangeUninitialized';
}

class ExchangeLoaded extends ExchangeState {
  final Rate rate;
  final Amount amountA;
  final Amount amountB;
  final bool reverse;

  ExchangeLoaded({
    @required this.rate,
    @required amountA,
    @required amountB,
    @required this.reverse,
  })  : assert(reverse ? amountB.value != null : amountA.value != null),
        assert(rate.rates.keys.contains(amountA.currency)),
        assert(rate.rates.keys.contains(amountB.currency)),
        amountA = reverse
            ? _applyRate(
                rate: rate,
                from: amountB.currency,
                to: amountA.currency,
                amount: amountB.value)
            : amountA,
        amountB = reverse
            ? amountB
            : _applyRate(
                rate: rate,
                from: amountA.currency,
                to: amountB.currency,
                amount: amountA.value),
        super([amountA, amountB, reverse]);

  static Amount _applyRate({Rate rate, String from, String to, double amount}) {
    return Amount((b) => b
      ..currency = to
      ..value = (amount / rate.rates[from]) * rate.rates[to]);
  }

  @override
  ExchangeLoaded refreshRate({Rate rate}) {
    return ExchangeLoaded(
      rate: rate,
      amountA: this.amountA,
      amountB: this.amountB,
      reverse: this.reverse,
    );
  }

  @override
  ExchangeState set({
    Rate rate,
    Amount amountA,
    Amount amountB,
    bool reverse,
  }) {
    return ExchangeLoaded(
      rate: rate == null ? this.rate : rate,
      amountA: amountA == null ? this.amountA : amountA,
      amountB: amountB == null ? this.amountB : amountB,
      reverse: reverse == null ? this.reverse : reverse,
    );
  }

  @override
  String toString() => reverse
      ? 'ExchangeLoaded { from: $amountB, to: $amountA } }'
      : 'ExchangeLoaded { from: $amountA, to: $amountB } }';
}

class ExchangeError extends ExchangeState {
  final String error;

  ExchangeError({@required this.error}) : super([error]);

  @override
  ExchangeState set({
    Rate rate,
    Amount amountA,
    Amount amountB,
    bool reverse,
  }) {
    return this.reset().set(
          rate: rate,
          amountA: amountA,
          amountB: amountB,
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

class SetAmountA extends ExchangeEvent {
  final Amount amount;

  SetAmountA({@required this.amount}) : super([amount]);
}

class SetAmountB extends ExchangeEvent {
  final Amount amount;

  SetAmountB({@required this.amount}) : super([amount]);
}

class ToggleReverse extends ExchangeEvent {}

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

    if (event is SetAmountA) {
      yield currentState.set(amountA: event.amount);
      this.dispatch(RefreshRates());
    }

    if (event is SetAmountB) {
      yield currentState.set(amountB: event.amount);
      this.dispatch(RefreshRates());
    }

    if (event is ToggleReverse) {
      if (currentState is ExchangeError) {
        ExchangeUninitialized state = currentState.reset();
        yield state.set(reverse: !state.reverse);
      }

      if (currentState is ExchangeUninitialized) {
        yield currentState.set(reverse: !currentState.reverse);
      }

      if (currentState is ExchangeLoaded) {
        yield currentState.set(reverse: !currentState.reverse);
      }
    }
  }
}
