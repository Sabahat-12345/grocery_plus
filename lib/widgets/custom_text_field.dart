import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final int? maxLines;
  final Function()? onTap;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: obscureText ? 1 : maxLines, // Password should be single line
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
