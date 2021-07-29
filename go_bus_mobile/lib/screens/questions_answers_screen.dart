import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/question_answer_card.dart';
import '../widgets/qa_dialog.dart';
import '../providers/QA_provider.dart';

class QuestionsAnswersScreen extends StatefulWidget {
  static const routeName = "/home-screen";

  @override
  _QuestionsAnswersScreen createState() => _QuestionsAnswersScreen();
}

class _QuestionsAnswersScreen extends State<QuestionsAnswersScreen> {
  var flutter = false;
  var react = false;
  var spring = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height - 380;

    final authProvider = Provider.of<QAProvider>(context, listen: false);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Checkbox(
                    fillColor: MaterialStateProperty.all(
                      Theme.of(context).buttonColor,
                    ),
                    value: flutter,
                    onChanged: (value) {
                      setState(() {
                        if (!flutter) {
                          flutter = true;
                          react = false;
                          spring = false;
                        } else {
                          flutter = false;
                        }
                      });
                    },
                  ),
                  Text(
                    "Flutter",
                  ),
                ],
              ),
              Column(
                children: [
                  Checkbox(
                    fillColor: MaterialStateProperty.all(
                      Theme.of(context).buttonColor,
                    ),
                    value: react,
                    onChanged: (value) {
                      setState(() {
                        if (!react) {
                          react = true;
                          flutter = false;
                          spring = false;
                        } else {
                          react = false;
                        }
                      });
                    },
                  ),
                  Text(
                    "React",
                  ),
                ],
              ),
              Column(
                children: [
                  Checkbox(
                    fillColor: MaterialStateProperty.all(
                      Theme.of(context).buttonColor,
                    ),
                    value: spring,
                    onChanged: (value) {
                      setState(() {
                        if (!spring) {
                          spring = true;
                          react = false;
                          flutter = false;
                        } else {
                          spring = false;
                        }
                      });
                    },
                  ),
                  Text(
                    "Spring",
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: height,
            child: FutureBuilder(
              future: authProvider.fetchQuestions(flutter, react, spring),
              builder: (context, questionsSnapshot) => questionsSnapshot
                          .connectionState ==
                      ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: (questionsSnapshot.data as List).length,
                      itemBuilder: (context, index) => TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => QADialog(
                                question: questionsSnapshot.data[index]
                                    ['question'],
                                answer: questionsSnapshot.data[index]
                                        ['answer'] ??
                                    "Test",
                                text: "NAZAD"),
                          );
                        },
                        child: FutureBuilder(
                          future: authProvider.getUserId(),
                          builder: (context, userIdSnapshot) =>
                              QuestionAnswerCard(
                            myQuestion: userIdSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? false
                                : userIdSnapshot.data ==
                                    questionsSnapshot.data[index]['userId'],
                            userName: questionsSnapshot.data[index]['username'],
                            question: questionsSnapshot.data[index]['question'],
                            answer:
                                questionsSnapshot.data[index]['answer'] ?? "",
                            technologies: questionsSnapshot.data[index]
                                ['technologies'],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
