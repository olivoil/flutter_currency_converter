import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:currency/blocs/blocs.dart';
import 'package:currency/models/models.dart';
import 'package:currency/widgets/currency_list.dart';
import 'package:currency/widgets/input_amount_value.dart';

class Exchange extends StatelessWidget {
  String formatNumber(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  Widget _renderBackground(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFFEC5759),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _renderArrow(
      BuildContext context, ExchangeBloc bloc, ExchangeState state) {
    return Positioned(
      height: 125.0,
      width: 125.0,
      top: MediaQuery.of(context).size.height / 2 - (125.0 / 2),
      left: MediaQuery.of(context).size.width / 2 - (125.0 / 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(62.5),
          color: Colors.white,
          border: Border.all(
              color: Color(0xFFEC5759), style: BorderStyle.solid, width: 5.0),
        ),
        child: Center(
          child: (state is ExchangeLoaded && state.reverse)
              ? Icon(
                  Icons.arrow_upward,
                  size: 60.0,
                  color: Color(0xFFEC5759),
                )
              : Icon(
                  Icons.arrow_downward,
                  size: 60.0,
                  color: Color(0xFFEC5759),
                ),
        ),
      ),
    );
  }

  Widget _renderContent(
      BuildContext context, ExchangeBloc bloc, ExchangeState state) {
    switch (state.runtimeType) {
      case ExchangeLoaded:
        return _renderContentLoaded(context, bloc, state);
      default:
        return Container();
    }
  }

  Widget _renderContentLoaded(
    BuildContext context,
    ExchangeBloc bloc,
    ExchangeLoaded state,
  ) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0),
              height: MediaQuery.of(context).size.height / 2 - (125.0 / 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => CurrencyList(
                                onCurrencySelected: (String symbol) {
                                  bloc.dispatch(SetValueA(
                                      value: Value((b) => b
                                        ..amount = state.valueA.amount
                                        ..currency = symbol)));
                                },
                              ),
                        ),
                      );
                    },
                    child: Text(
                      Currency.lookup(state.valueA.currency).name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontFamily: 'Quicksand'),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => InputAmountValue(
                              backgroundColor: Color(0xFFEC5759),
                              textColor: Color(0xFFF1ABAB),
                              valueColor: Colors.white,
                              buttonBackgroundColor: Color(0xFFB73434),
                              submitButtonBackgroundColor: Colors.white,
                              submitButtonColor: Color(0xFFEC5759),
                              onAmountSelected: (double amount) {
                                bloc.dispatch(SetValueA(
                                  value: Value((b) => b
                                    ..amount = amount
                                    ..currency = state.valueA.currency),
                                ));
                              },
                            ),
                      ));
                    },
                    child: AutoSizeText(
                      formatNumber(state.valueA.amount),
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 120.0,
                          fontFamily: 'Quicksand'),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    state.valueA.currency,
                    style: TextStyle(
                        color: Color(0xFFFFB6B6),
                        fontSize: 17.0,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25.0),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              height: MediaQuery.of(context).size.height / 2 - (125.0 / 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => CurrencyList(
                                onCurrencySelected: (String symbol) {
                                  bloc.dispatch(SetValueB(
                                    value: Value((b) => b
                                      ..amount = state.valueB.amount
                                      ..currency = symbol),
                                  ));
                                },
                              ),
                        ),
                      );
                    },
                    child: Text(
                      state.valueB.currency,
                      style: TextStyle(
                          color: Color(0xFFFFB6B6),
                          fontSize: 17.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => InputAmountValue(
                              backgroundColor: Colors.white,
                              valueColor: Color(0xFFEC5759),
                              textColor: Color(0xFFFFB6B6),
                              buttonBackgroundColor: Color(0xFFFFB6B6),
                              submitButtonBackgroundColor: Color(0xFFFC1514),
                              submitButtonColor: Colors.white,
                              onAmountSelected: (double amount) {
                                bloc.dispatch(SetValueB(
                                  value: Value((b) => b
                                    ..amount = amount
                                    ..currency = state.valueB.currency),
                                ));
                              },
                            ),
                      ));
                    },
                    child: AutoSizeText(
                      formatNumber(state.valueB.amount),
                      maxLines: 1,
                      style: TextStyle(
                          color: Color(0xFFEC5759),
                          fontSize: 120.0,
                          fontFamily: 'Quicksand'),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    Currency.lookup(state.valueB.currency).name,
                    style: TextStyle(
                        color: Color(0xFFEC5759),
                        fontSize: 22.0,
                        fontFamily: 'Quicksand'),
                  ),
                  SizedBox(height: 25.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ExchangeBloc bloc = BlocProvider.of<ExchangeBloc>(context);

    return Material(
      child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, ExchangeState state) {
            return Stack(
              children: <Widget>[
                _renderBackground(context),
                _renderArrow(context, bloc, state),
                _renderContent(context, bloc, state),
              ],
            );
          }),
    );
  }
}
