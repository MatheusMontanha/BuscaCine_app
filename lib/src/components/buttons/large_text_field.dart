import 'package:flutter/material.dart';

class LargeTextField extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final int maxLength;
  LargeTextField(
      {@required this.textController,
      @required this.labelText,
      @required this.maxLength});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      maxLength: 50,
      maxLengthEnforced: true,
      //initialValue: "eve.holt@reqres.in",
      validator: EmailFieldValidator.validate,
      controller: textController,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      style: TextStyle(fontSize: 20),
    );
  }
}

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "O campo de email deve ser preenchido." : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "O campo de senha deve ser preenchido." : null;
  }
}
