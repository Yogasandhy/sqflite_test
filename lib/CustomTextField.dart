import 'package:flutter/material.dart';

enum TextFieldType { normal, password, confirmPassword, email }

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextFieldType type;
  final TextEditingController? passwordController;

  CustomTextField({
    required this.controller,
    required this.hintText,
    this.type = TextFieldType.normal,
    this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: type == TextFieldType.password ||
          type == TextFieldType.confirmPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field ini harus diisi';
        } else if (type == TextFieldType.email && !value.contains('@')) {
          return 'Email harus mengandung @';
        } else if (type == TextFieldType.password && value.length < 8) {
          return 'Password minimal 8 karakter';
        } else if (type == TextFieldType.confirmPassword &&
            value != passwordController!.text) {
          return 'Password harus sesuai';
        }
        return null;
      },
    );
  }
}
