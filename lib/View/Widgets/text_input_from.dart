import 'package:flutter/material.dart';
import 'package:news_proved/constant.dart';

class TextInputForm extends StatelessWidget {
  final Widget labelText;
  final Widget icon;

  final bool obscureText;
  final TextEditingController controller;

  const TextInputForm({
    super.key,
    required this.labelText,
    required this.icon,
    
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: labelText,
        prefixIcon: icon,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
