import 'package:flutter/material.dart';

class QuestionAnswerCard extends StatefulWidget {
  final String userName;
  final String question;
  final String answer;
  final String technologies;

  QuestionAnswerCard({
    @required this.userName,
    @required this.question,
    @required this.answer,
    @required this.technologies,
  });

  @override
  _QuestionAnswerCardState createState() => _QuestionAnswerCardState();
}

class _QuestionAnswerCardState extends State<QuestionAnswerCard> {
  String _technologies;
  @override
  void initState() {
    _technologies = widget.technologies.replaceAll("]", "");
    _technologies = _technologies.replaceAll("[", "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Card(
              elevation: 5,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Q:",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          widget.question,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          widget.answer,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        ":A",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _technologies,
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              top: -8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Theme.of(context).accentColor,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      widget.userName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
