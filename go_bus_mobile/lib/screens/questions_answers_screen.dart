import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/question_answer_card.dart';

class QuestionsAnswersScreen extends StatefulWidget {
  static const routeName = "/home-screen";

  @override
  _QuestionsAnswersScreen createState() => _QuestionsAnswersScreen();
}

class _QuestionsAnswersScreen extends State<QuestionsAnswersScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: Constants.padding),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Image(
              image: AssetImage("assets/images/qa_logo.png"),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) => QuestionAnswerCard(
                userName: "Marko",
                question:
                    "Negative margin is generally not needed but there are situations where it’s really useful. For example: why use negative margins?",
                answer:
                    "Тo answer this question you first have to define what negative margins, or really margins in general, really are. In CSS, margins have various meanings in the various layout models, most commonly, they are one of several values that contribute to computing the offset that the block layout model uses to place subsequent children; a negative total margin in this case merely means the next child is placed above the bottom of the previous child instead of after it.",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
