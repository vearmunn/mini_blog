// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BlogTextFormField extends StatelessWidget {
  const BlogTextFormField({
    super.key,
    required this.hint,
    required this.controller,
  });

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(hintText: hint),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your $hint";
        }
        return null;
      },
    );
  }
}
