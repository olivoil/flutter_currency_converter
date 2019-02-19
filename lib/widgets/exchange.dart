import 'package:currency/widgets/currency_list.dart';
import 'package:currency/widgets/input_amount_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:currency/blocs/blocs.dart';
import 'package:currency/models/models.dart';

class Exchange extends StatelessWidget {
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
                          SizedBox(height: 20.0),
                          InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => InputAmountValue(
                                              backgroundColor:
                                                  Color(0xFFEC5759),
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
                                            )));
                              },
                              child: Text(
                                state.amountA.value.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 120.0,
                                    fontFamily: 'Quicksand'),
                              )),
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
