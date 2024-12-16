import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/images.dart';
import 'package:food_hub_user/view/auth/welcome_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 5),
      () => Get.to(() => WelcomeScreen()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image(image: AssetImage(AppImages.appLogo)),
          )
        ],
      ),
    );
  }
}
