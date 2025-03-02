import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../const/text_style.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final Widget? leading;

  const CommonAppBar({super.key, this.text, this.leading});

  // Define the preferred size (height) for the app bar
  @override
  Size get preferredSize => const Size.fromHeight(50.0); // Standard app bar height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: leading,
      title: Text(
        text ?? "",
        style: AppTextStyle.w700(fontSize: 20, color: AppColors.white),
      ),
    );
  }
}
