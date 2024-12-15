import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/text_style.dart';

class AuthCommanTitleText extends StatelessWidget {
  final String text;
  const AuthCommanTitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: AppTextStyle.w700(
        color: AppColors.authTitleColor,
        fontSize: 42,
      ),
    );
  }
}
