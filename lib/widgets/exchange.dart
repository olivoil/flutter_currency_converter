import 'package:currency/widgets/currency_list.dart';
import 'package:currency/widgets/input_amount_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:currency/blocs/blocs.dart';
import 'package:currency/models/models.dart';

class Exchange extends StatelessWidget {
  String formatNumber(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  @override
  Widget build(BuildContext context) {
    ExchangeBloc bloc = BlocProvider.of<ExchangeBloc>(context);

    return Material(
      child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, ExchangeState state) {
            if (state is ExchangeLoaded) {
              return Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xFFEC5759),
                  ),
                  Positioned(
                    height: 125.0,
                    width: 125.0,
                    top: MediaQuery.of(context).size.height / 2 - (125.0 / 2),
                    left: MediaQuery.of(context).size.width / 2 - (125.0 / 2),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(62.5),
                        color: Colors.white,
                        border: Border.all(
                            color: Color(0xFFEC5759),
                            style: BorderStyle.solid,
                            width: 5.0),
                      ),
                      child: Center(
                        child: state.reverse
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
                  ),
                  SafeArea(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => CurrencyList(
                                        onCurrencySelected: (String symbol) {
                                          bloc.dispatch(SetAmountA(
                                              amount: Amount((b) => b
                                                ..value = state.amountA.value
                                                ..currency = symbol)));
                                        },
                                      ),
                                ),
                              );
                            },
                            child: Text(
                              Currency.lookup(state.amountA.currency).name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontFamily: 'Quicksand'),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => InputAmountValue(
                                      backgroundColor: Color(0xFFEC5759),
                                      valueColor: Colors.white,
                                      textColor: Color(0xFFF1ABAB),
                                      onAmountSelected: (double value) {
                                        bloc.dispatch(SetAmountA(
                                          amount: Amount((b) => b
                                            ..value = value
                                            ..currency =
                                                state.amountA.currency),
                                        ));
                                      },
                                    ),
                              ));
                            },
                            child: Text(
                              formatNumber(state.amountA.value),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 120.0,
                                  fontFamily: 'Quicksand'),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            state.amountA.currency,
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
                  ),
                ],
              );
            }

            return Container();
          }),
    );
  }
}
