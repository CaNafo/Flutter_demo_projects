import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput({this.onSelectImage});

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();

    final imageFile = await imagePicker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) return;

    final convertedImage = File(imageFile.path);

    setState(() {
      _storedImage = convertedImage;
    });

    final appDirectory = await sysPath.getApplicationDocumentsDirectory();
    final imageName = path.basename(imageFile.path);

    final savedImage =
        await convertedImage.copy("${appDirectory.path}/$imageName");
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  "No image taken",
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: FlatButton.icon(
          onPressed: _takePicture,
          icon: Icon(Icons.camera),
          label: Text(
            "Take picture",
          ),
          textColor: Theme.of(context).primaryColor,
        ))
      ],
    );
  }
}
