import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PasswordInputField extends StatefulWidget {
  final String Function(String) validate;
  final Function(String) onChanged;
  final String placeholder;
  final textInputAction;

  const PasswordInputField({
    @required this.validate,
    @required this.placeholder,
    @required this.onChanged,
    @required this.textInputAction,
  });

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  var showPassword = false;
  _toggleObscureText() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: widget.placeholder,
            ),
            textInputAction: widget.textInputAction,
            validator: widget.validate,
            onChanged: widget.onChanged,
            obscureText: !showPassword,
          ),
        ),
        IconButton(
          onPressed: _toggleObscureText,
          icon: Icon(
            showPassword
                ? Icons.remove_red_eye_sharp
                : Icons.remove_red_eye_outlined,
          ),
        )
      ],
    );
  }
}
