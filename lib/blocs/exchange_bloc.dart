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
    String currencyA,
    String currencyB,
    double amountA,
    double amountB,
    bool reverse,
  });

  ExchangeLoaded refreshRate({Rate rate}) {
    return this.reset().refreshRate(rate: rate);
  }
}

class ExchangeUninitialized extends ExchangeState {
  final String currencyA;
  final String currencyB;
  final double amountA;
  final double amountB;
  final bool reverse;

  ExchangeUninitialized({
    this.currencyA = 'USD',
    this.currencyB = 'MXN',
    this.amountA = 0.0,
    this.amountB = 0.0,
    this.reverse = false,
  }) : super([currencyA, currencyB, amountA, amountB, reverse]);

  @override
  ExchangeLoaded refreshRate({Rate rate}) {
    return ExchangeLoaded(
      rate: rate,
      currencyA: this.currencyA,
      currencyB: this.currencyB,
      amountA: this.amountA,
      amountB: this.amountB,
      reverse: this.reverse,
    );
  }

  @override
  ExchangeState set({
    Rate rate,
    String currencyA,
    String currencyB,
    double amountA,
    double amountB,
    bool reverse,
  }) {
    if (rate != null) {
      return ExchangeLoaded(
        rate: rate,
        currencyA: currencyA == null ? this.currencyA : currencyA,
        currencyB: currencyB == null ? this.currencyB : currencyB,
        amountA: amountA == null ? this.amountA : amountA,
        amountB: amountB == null ? this.amountB : amountB,
        reverse: reverse == null ? this.reverse : reverse,
      );
    }

    return ExchangeUninitialized(
      currencyA: currencyA == null ? this.currencyA : currencyA,
      currencyB: currencyB == null ? this.currencyB : currencyB,
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
  final String currencyA;
  final String currencyB;
  final double amountA;
  final double amountB;
  final bool reverse;

  ExchangeLoaded({
    @required this.rate,
    @required this.currencyA,
    @required this.currencyB,
    amountA,
    amountB,
    @required this.reverse,
  })  : assert(reverse ? amountB != null : amountA != null),
        assert(rate.rates.keys.contains(currencyA)),
        assert(rate.rates.keys.contains(currencyB)),
        amountA = reverse
            ? _applyRate(
                rate: rate, from: currencyB, to: currencyA, amount: amountB)
            : amountA,
        amountB = reverse
            ? amountB
            : _applyRate(
                rate: rate, from: currencyA, to: currencyB, amount: amountA),
        super([currencyA, currencyB, amountA, amountB, reverse]);

  static double _applyRate({Rate rate, String from, String to, double amount}) {
    return (amount / rate.rates[from]) * rate.rates[to];
  }

  @override
  ExchangeLoaded refreshRate({Rate rate}) {
    return ExchangeLoaded(
      rate: rate,
      currencyA: this.currencyA,
      currencyB: this.currencyB,
      amountA: this.amountA,
      amountB: this.amountB,
      reverse: this.reverse,
    );
  }

  @override
  ExchangeState set({
    Rate rate,
    String currencyA,
    String currencyB,
    double amountA,
    double amountB,
    bool reverse,
  }) {
    return ExchangeLoaded(
      rate: rate == null ? this.rate : rate,
      currencyA: currencyA == null ? this.currencyA : currencyA,
      currencyB: currencyB == null ? this.currencyB : currencyB,
      amountA: amountA == null ? this.amountA : amountA,
      amountB: amountB == null ? this.amountB : amountB,
      reverse: reverse == null ? this.reverse : reverse,
    );
  }

  @override
  String toString() => reverse
      ? 'ExchangeLoaded { from: { curreny: $currencyB, amount: $amountB }, to: { currency: $currencyA, amount: $amountA } }'
      : 'ExchangeLoaded { from: { curreny: $currencyA, amount: $amountA }, to: { currency: $currencyB, amount: $amountB } }';
}

class ExchangeError extends ExchangeState {
  final String error;

  ExchangeError({@required this.error}) : super([error]);

  @override
  ExchangeState set({
    Rate rate,
    String currencyA,
    String currencyB,
    double amountA,
    double amountB,
    bool reverse,
  }) {
    return this.reset().set(
          rate: rate,
          currencyA: currencyA,
          currencyB: currencyB,
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

class SetCurrencyA extends ExchangeEvent {
  final String symbol;

  SetCurrencyA({@required this.symbol}) : super([symbol]);
}

class SetCurrencyB extends ExchangeEvent {
  final String symbol;

  SetCurrencyB({@required this.symbol}) : super([symbol]);
}

class SetAmountA extends ExchangeEvent {
  final double amount;

  SetAmountA({@required this.amount}) : super([amount]);
}

class SetAmountB extends ExchangeEvent {
  final double amount;

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

    if (event is SetCurrencyA) {
      yield currentState.set(currencyA: event.symbol);
      this.dispatch(RefreshRates());
    }

    if (event is SetCurrencyB) {
      yield currentState.set(currencyB: event.symbol);
      this.dispatch(RefreshRates());
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
