import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.inputType,
      required this.errorMessage,
      this.isEnabled = true});

  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final String errorMessage;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      }),
      controller: controller,
      enabled: isEnabled,
      keyboardType: inputType,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300)),
          hintText: hintText),
    );
  }
}
