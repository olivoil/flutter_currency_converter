import 'package:currency/blocs/blocs.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:currency/repositories/repositories.dart';
import 'package:currency/widgets/widgets.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}

void main() {
  final RatesRepository rateRepository = RatesRepository(
      rateApiClient: RatesApiClient(
    httpClient: http.Client(),
  ));

  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(
    rateRepository: rateRepository,
  ));
}

class App extends StatefulWidget {
  final RatesRepository rateRepository;

  App({
    Key key,
    @required this.rateRepository,
  })  : assert(rateRepository != null),
        super(key: key);

  @override
  AppState createState() {
    return new AppState();
  }
}

class AppState extends State<App> {
  ExchangeBloc _exchangeBloc;

  @override
  void initState() {
    super.initState();
    _exchangeBloc = ExchangeBloc(ratesRepository: widget.rateRepository);
    _exchangeBloc.dispatch(RefreshRates());
  }

  @override
  void dispose() {
    _exchangeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _exchangeBloc,
      // TODO(@olivoil): use material color theme to define colors throughout the app
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Color(0xFFEC5759),
        ),
        home: Scaffold(
          body: Exchange(),
        ),
      ),
    );
  }
}
