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
              builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: (snapshot.data as List).length,
                      itemBuilder: (context, index) => TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => QADialog(
                                question: snapshot.data[index]['question'],
                                answer:
                                    snapshot.data[index]['answer'] ?? "Test",
                                text: "NAZAD"),
                          );
                        },
                        child: QuestionAnswerCard(
                          userName: snapshot.data[index]['username'],
                          question: snapshot.data[index]['question'],
                          answer: snapshot.data[index]['answer'] ?? "",
                          technologies: snapshot.data[index]['technologies'],
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
