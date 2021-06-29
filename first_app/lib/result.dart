import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int _resultScore;
  final Function resetHandler;

  Result(this._resultScore, this.resetHandler);

  String get resultPhrase {
    var resultText = 'Game over';

    if (_resultScore <= 8) {
      resultText = "You've won less than 9 points!";
    } else if (_resultScore <= 15) {
      resultText = "You've won less than 16 points!";
    } else {
      resultText = "You've won more than 15 points!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: resetHandler,
            child: Text(
              "Restart game",
            ),
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
