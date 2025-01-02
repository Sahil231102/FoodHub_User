import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/text_style.dart';

// Modify the CommonAppBar class to implement PreferredSizeWidget
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? text;

  const CommonAppBar({super.key, this.text});

  // Define the preferred size (height) for the app bar
  @override
  Size get preferredSize => const Size.fromHeight(50.0); // Standard app bar height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(
        text ?? "",
        style: AppTextStyle.w700(fontSize: 20, color: AppColors.white),
      ),
    );
  }
}
