import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:currency/widgets/exchange.dart';

typedef void AmountSelectedCallback(double value);

class InputAmountValue extends StatefulWidget {
  final Color backgroundColor;
  final Color valueColor;
  final Color textColor;
  final Color buttonBackgroundColor;
  final Color submitButtonBackgroundColor;
  final Color submitButtonColor;
  final AmountSelectedCallback onAmountSelected;

  InputAmountValue(
      {Key key,
      this.backgroundColor,
      this.valueColor,
      this.textColor,
      this.buttonBackgroundColor,
      this.submitButtonBackgroundColor,
      this.submitButtonColor,
      this.onAmountSelected})
      : super(key: key);

  @override
  _InputAmountValueState createState() => _InputAmountValueState();
}

class _InputAmountValueState extends State<InputAmountValue> {
  String currInput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 25.0),
            InkWell(
              onTap: () {
                setState(() {
                  currInput = '';
                });
              },
              child: Text(
                'tap to delete',
                style: TextStyle(
                    color: Color(0xFFF1ABAB),
                    fontSize: 17.0,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: AutoSizeText(
                currInput,
                maxLines: 1,
                style: TextStyle(
                    color: widget.valueColor,
                    fontSize: 100.0,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 25.0),
            numberRow(1, 2, 3),
            SizedBox(height: 25.0),
            numberRow(4, 5, 6),
            SizedBox(height: 25.0),
            numberRow(7, 8, 9),
            SizedBox(height: 25.0),
            finalRow()
          ],
        ),
      ),
    );
  }

  Widget valueButton(dynamic n) {
    return button(
        child: Text(
          n.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          calculateNumber(n);
        });
  }

  Widget button({Widget child, VoidCallback onPressed, Color backgroundColor}) {
    Color c = backgroundColor == null
        ? widget.buttonBackgroundColor
        : backgroundColor;

    return SizedBox(
      width: 80.0,
      height: 80.0,
      child: RaisedButton(
        child: child,
        onPressed: onPressed,
        color: c,
        elevation: 0.0,
        highlightElevation: 0.0,
        disabledElevation: 0.0,
        clipBehavior: Clip.none,
        shape: CircleBorder(),
      ),
    );
  }

  Widget numberRow(number1, number2, number3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        valueButton(number1),
        valueButton(number2),
        valueButton(number3),
      ],
    );
  }

  Widget finalRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        valueButton('.'),
        valueButton(0),
        button(
            child: Center(
                child: Icon(
              Icons.check,
              color: widget.submitButtonColor,
              size: 35.0,
            )),
            backgroundColor: widget.submitButtonBackgroundColor,
            onPressed: () {
              double val;

              try {
                val = double.parse(currInput);
              } catch (e) {
                val = 1.0;
              }

              widget.onAmountSelected(val);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Exchange(),
                ),
              );
            }),
      ],
    );
  }

  calculateNumber(dynamic next) {
    if (next is String) {
      setState(() {
        currInput = (next == '.' && currInput.contains('.'))
            ? currInput
            : '$currInput${next.toString()}';
      });
    } else {
      if (currInput == null ||
          currInput == '' ||
          double.parse(currInput) == 0.0) {
        setState(() {
          currInput = next.toString();
        });
      } else {
        setState(() {
          currInput = '$currInput${next.toString()}';
        });
      }
    }
  }
}
