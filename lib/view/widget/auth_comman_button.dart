import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/text_style.dart';

class AuthCommanButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const AuthCommanButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          width: 248,
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(29),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF7A81BE).withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: Offset(0, 2))
              ]),
          child: Center(
            child: Text(
              text ?? "",
              style: AppTextStyle.w700(
                color: AppColors.buttonTextColor,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
