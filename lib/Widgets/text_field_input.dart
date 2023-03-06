import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  const TextFieldInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    required this.textInputType,
    this.validator,
    this.autovalidateMode,
  });
  @override
  Widget build(BuildContext context) {
    final textFieldBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context, color: Colors.white),
    );
    return TextFormField(
      autovalidateMode:autovalidateMode,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: textFieldBorder,
        focusedBorder: textFieldBorder,
        enabledBorder: textFieldBorder,
      ),
      keyboardType: textInputType,
      obscureText: isPassword,
    );
  }
}
