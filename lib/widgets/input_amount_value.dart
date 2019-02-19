import 'package:flutter/material.dart';
import 'package:currency/widgets/exchange.dart';

typedef void AmountSelectedCallback(double value);

class InputAmountValue extends StatefulWidget {
  final Color backgroundColor;
  final Color valueColor;
  final Color textColor;
  final AmountSelectedCallback onAmountSelected;

  InputAmountValue(
      {this.backgroundColor,
      this.valueColor,
      this.textColor,
      this.onAmountSelected});

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
              child: Text(
                currInput,
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

  Widget numberRow(number1, number2, number3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            calculateNumber(number1);
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Color(0xFFB73434)),
            child: Center(
              child: Text(
                number1.toString(),
                style: TextStyle(
                    color: widget.valueColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            calculateNumber(number2);
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Color(0xFFB73434)),
            child: Center(
              child: Text(
                number2.toString(),
                style: TextStyle(
                    color: widget.valueColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            calculateNumber(number3);
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Color(0xFFB73434)),
            child: Center(
              child: Text(
                number3.toString(),
                style: TextStyle(
                    color: widget.valueColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget finalRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            calculateNumber('.');
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Color(0xFFB73434)),
            child: Center(
              child: Text(
                '.',
                style: TextStyle(
                    color: widget.valueColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            calculateNumber(0);
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Color(0xFFB73434)),
            child: Center(
              child: Text(
                0.toString(),
                style: TextStyle(
                    color: widget.valueColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
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
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0), color: Colors.white),
            child: Center(
                child: Icon(
              Icons.check,
              color: Color(0xFFFC1514),
              size: 25.0,
            )),
          ),
        )
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
