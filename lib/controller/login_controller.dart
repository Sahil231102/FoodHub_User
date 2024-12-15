import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/View/home_screen.dart';
import 'package:food_hub_user/const/Icons.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/services/firebase_services.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool isLoginCircular = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> emailLogin(
      {required String email, required String password}) async {
    try {
      isLoginCircular = true;
      update();

      await FirebaseServices.firebaseAuth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (value) => Get.to(HomeScreen()),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Get.snackbar(
          "Login Failed", // title
          "No user found with this email.", // message
          snackPosition: SnackPosition.TOP, // position of Snackbar
          backgroundColor: AppColors.errorColor, // background color
          colorText: Colors.white, // text color
          borderRadius: 10.0, // rounded corners
          margin: EdgeInsets.all(15), // margin
          duration: Duration(seconds: 3), // duration of Snackbar
          icon: Icon(AppIcons.cancel, color: Colors.white), // success icon
        );
      } else if (e.code == "wrong-password") {
        Get.snackbar(
          "Login Failed", // title
          "No user found with this email.", // message
          snackPosition: SnackPosition.TOP, // position of Snackbar
          backgroundColor: AppColors.errorColor, // background color
          colorText: Colors.white, // text color
          borderRadius: 10.0, // rounded corners
          margin: EdgeInsets.all(15), // margin
          duration: Duration(seconds: 3), // duration of Snackbar
          icon: Icon(AppIcons.cancel, color: Colors.white), // success icon
        );
      }
    } finally {
      isLoginCircular = false;
      update();
    }
  }
}
