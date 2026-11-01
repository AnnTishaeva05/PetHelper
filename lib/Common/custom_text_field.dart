import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String defaultValue;
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final double borderRadius;
  final TextStyle? labelStyle;
  final Color? fillColor;

  const CustomTextField({
    Key? key,
    required this.defaultValue,
    this.hintText = '',
    this.labelText = '',
    this.controller,
    this.borderRadius = 15.0,
    this.labelStyle,
    this.fillColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = controller ?? TextEditingController(text: defaultValue);

    return TextField(
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Color(0xFFFFB761), width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Color(0xFFFFB761), width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Color(0xFFFFB761), width: 2.0),
        ),
        labelText: labelText.isNotEmpty ? labelText : null,
        labelStyle: labelStyle ?? TextStyle(
          color: Color(0xFF8A4D05),
        ),
        hintText: hintText.isNotEmpty ? hintText : null,
        contentPadding: EdgeInsets.all(16.0),
      ),
    );
  }
}