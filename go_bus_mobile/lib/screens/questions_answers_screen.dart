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
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height - 300;

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
          Container(
            height: height,
            child: FutureBuilder(
              future: authProvider.fetchQuestions(),
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
