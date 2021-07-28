import 'dart:ui';

import '../constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QADialog extends StatefulWidget {
  final String question, answer, text;

  const QADialog({
    Key key,
    @required this.question,
    @required this.answer,
    @required this.text,
  }) : super(key: key);

  @override
  _QADialogState createState() => _QADialogState();
}

class _QADialogState extends State<QADialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Q:",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        widget.question,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "A:",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        widget.answer,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        widget.text,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.avatarRadius)),
              child: SizedBox(
                height: 70,
                child: Image.asset(
                  "assets/images/logged_logo.png",
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
