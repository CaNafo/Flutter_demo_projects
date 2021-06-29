import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final _qustions = const [
    {
      "questionText": "What's your farovrite color?",
      "answers": [
        {"text": "Red", "score": 10},
        {"text": "Blue", "score": 5},
        {"text": "Orange", "score": 3},
        {"text": "Yellow", "score": 1},
      ]
    },
    {
      "questionText": "What's your favorite animal?",
      "answers": [
        {"text": "Pig", "score": 10},
        {"text": "Cat", "score": 5},
        {"text": "Dog", "score": 3},
        {"text": "Horse", "score": 1},
      ]
    },
    {
      "questionText": "Who is your favroite Apostol?",
      "answers": [
        {"text": "Jovan", "score": 1},
        {"text": "Ilija", "score": 5},
        {"text": "Georgije", "score": 13},
        {"text": "Svetozar", "score": 1},
      ]
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My first app'),
        ),
        body: _questionIndex < _qustions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: this._questionIndex,
                questions: _qustions,
              )
            : Result(this._totalScore, _resetQuiz),
      ),
    );
  }
}
