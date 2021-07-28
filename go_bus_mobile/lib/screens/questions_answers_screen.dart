import 'package:flutter/material.dart';

import '../constants.dart';

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
      child: SizedBox(
        width: double.infinity,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) => SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Q:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              "What is Flutter used for?",
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              "Flutter is an open-source UI software development kit created by Google. It is used to develop cross platform applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, and the web from a single codebase.",
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            ":A",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: Text("TEST"),
                  top: -5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
