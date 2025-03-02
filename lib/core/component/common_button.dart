import 'package:flutter/material.dart';
import 'package:food_hub_user/core/const/colors.dart';
import 'package:food_hub_user/core/const/text_style.dart';

class CommonButton extends StatelessWidget {
  final void Function() onPressed;
  final double? height;
  final double? width;
  final String text;
  final double? fontSize;

  const CommonButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.height,
      this.width,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            fixedSize: Size(width ?? 180, height ?? 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.w700(fontSize: fontSize ?? 18, color: AppColors.white),
          ),
        ));
  }
}
