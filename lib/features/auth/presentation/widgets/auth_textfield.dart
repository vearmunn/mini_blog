// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.obscure = false,
  });

  final String hint;
  final TextEditingController controller;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hint is missing';
        }
        return null;
      },
    );
  }
}
