import 'dart:ui';
import 'package:go_bus_mobile/widgets/dialog_technology_card.dart';

import '../constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  const CustomDialogBox(
      {Key key, this.title, this.descriptions, this.text, this.img})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  var _flutterChecked = false;
  var _reactChecked = false;
  var _springChecked = false;

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
          padding: EdgeInsets.only(
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
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Column(
                children: [
                  DialogTechnologyCard(
                    technologyName: "Flutter",
                    image: AssetImage("assets/images/flutter_logo_icon.png"),
                    checkBoxValue: _flutterChecked,
                    onChanged: (value) {
                      setState(() {
                        _flutterChecked = value;
                      });
                    },
                  ),
                  DialogTechnologyCard(
                      technologyName: "React",
                      image: AssetImage("assets/images/react_logo.png"),
                      checkBoxValue: _reactChecked,
                      onChanged: (value) {
                        setState(() {
                          _reactChecked = value;
                        });
                      }),
                  DialogTechnologyCard(
                      technologyName: "Java Spring",
                      image: AssetImage("assets/images/spring_logo.png"),
                      checkBoxValue: _springChecked,
                      onChanged: (value) {
                        setState(() {
                          _springChecked = value;
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )),
              ),
            ],
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
