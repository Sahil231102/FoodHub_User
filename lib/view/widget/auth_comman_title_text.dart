import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';

class AuthCommanTitleText extends StatelessWidget {
  final String text;
  final double fontSize;

  const AuthCommanTitleText({
    super.key,
    required this.text,
    this.fontSize = 42.0, // Default font size
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700, // Directly setting the fontWeight
        color: AppColors.authTitleColor,
        fontSize: fontSize, // The font size provided or default
      ),
    );
  }
}
