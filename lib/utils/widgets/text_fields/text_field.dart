import 'package:flutter/material.dart';
import '/theme/colors.dart';
import '/theme/typography.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(
          color: Colors.black, // Change this to your desired color
          fontSize: 18, // You can also adjust the font size here
        ),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Color(0xFFEE4F4E),  // Hex color EE4F4E for the border
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Color(0xFFEE4F4E),  // Same color for the focused border
            width: 2.0,
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,  // Adjust the font size for hint text
        ),
      ),
      style: TextStyle(
        color: Colors.black,  // Text color black
        fontSize: 18,  // Adjust the font size for the input text
      ),
    );
  }
}
