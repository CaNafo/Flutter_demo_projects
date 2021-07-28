import 'package:flutter/material.dart';

class DialogTechnologyCard extends StatelessWidget {
  final String technologyName;
  final AssetImage image;
  final bool checkBoxValue;
  final Function onChanged;

  DialogTechnologyCard({
    @required this.technologyName,
    @required this.image,
    @required this.checkBoxValue,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: TextButton(
        onPressed: () => onChanged(!checkBoxValue),
        child: Card(
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 30,
                    child: Image(
                      image: image,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    technologyName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.all(
                  Theme.of(context).buttonColor,
                ),
                value: checkBoxValue,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
