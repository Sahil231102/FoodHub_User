import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/images.dart';
import 'package:food_hub_user/controller/get_storege_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GetStorageController _getStorageController = Get.put(GetStorageController());

  @override
  void initState() {
    super.initState();

    _getStorageController.checkUserData();
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
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(
            color: AppColors.white,
          )
        ],
      ),
    );
  }
}
