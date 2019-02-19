import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:currency/blocs/blocs.dart';
import 'package:currency/models/models.dart';
import 'package:currency/widgets/exchange.dart';

typedef void CurrencySelectedCallback(String symbol);

class CurrencyList extends StatefulWidget {
  final CurrencySelectedCallback onCurrencySelected;

  CurrencyList({Key key, @required this.onCurrencySelected})
      : assert(onCurrencySelected != null),
        super(key: key);

  @override
  CurrencyListState createState() {
    return new CurrencyListState();
  }
}

class CurrencyListState extends State<CurrencyList> {
  @override
  Widget build(BuildContext context) {
    ExchangeBloc bloc = BlocProvider.of<ExchangeBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xFFEC5759),
      appBar: AppBar(
        backgroundColor: Color(0xFFEC5759),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, ExchangeState state) {
          if (state is ExchangeLoaded) {
            return ListView.builder(
              padding: EdgeInsets.only(left: 25.0),
              itemExtent: 40.0,
              itemCount: state.rate.rates.length,
              itemBuilder: (BuildContext context, int index) {
                final String symbol = state.rate.rates.keys.elementAt(index);
                return _buildCurrencyItem(context, Currency.lookup(symbol));
              },
            );
          }

          bloc.dispatch(RefreshRates());
          return Container();
        },
      ),
    );
  }

  Widget _buildCurrencyItem(BuildContext context, Currency currency) {
    return InkWell(
      onTap: () {
        widget.onCurrencySelected(currency.symbol);

        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => Exchange(),
          ),
        );
      },
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * .25,
            child: Text(
              currency.symbol,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            currency.name,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
