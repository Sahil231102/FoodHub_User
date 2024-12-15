import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/View/login_screen.dart';
import 'package:food_hub_user/const/Icons.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/services/firebase_services.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signUpData(
      {required String email,
      required String password,
      required String name}) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await FirebaseServices.firebaseFirestore
            .doc(userCredential.user?.uid)
            .set({
          "uid": userCredential.user?.uid,
          "password": password,
          "email": email,
          "name": name,
          "last_login_time": DateTime.now().toIso8601String(),
        });

        if (userCredential.user?.uid != null) {
          Get.to(() => const LoginScreen());
          Get.snackbar(
            "Sign Up Successful", // title
            "Welcome! You have successfully signed up.", // message
            snackPosition: SnackPosition.TOP, // position of Snackbar
            backgroundColor: Colors.green, // background color
            colorText: Colors.white, // text color
            borderRadius: 10.0, // rounded corners
            margin: EdgeInsets.all(15), // margin
            duration: Duration(seconds: 3), // duration of Snackbar
            icon: Icon(Icons.check_circle, color: Colors.white), // success icon
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {
          Get.snackbar(
            "Sign Up Filed", // title
            "The email address is already in use by another account.", // message
            snackPosition: SnackPosition.TOP, // position of Snackbar
            backgroundColor: Colors.red, // background color
            colorText: AppColors.white, // text color
            borderRadius: 10.0, // rounded corners
            margin: EdgeInsets.all(15), // margin
            duration: Duration(seconds: 3), // duration of Snackbar
            icon: Icon(Icons.cancel, color: Colors.white), // success icon
          );
        } else if (e.code == "weak-password") {
          Get.snackbar(
            "Sign Up Filed", // title
            "The password is too weak.", // message
            snackPosition: SnackPosition.TOP, // position of Snackbar
            backgroundColor: Colors.redAccent, // background color
            colorText: Colors.white, // text color
            borderRadius: 10.0, // rounded corners
            margin: EdgeInsets.all(15), // margin
            duration: Duration(seconds: 3), // duration of Snackbar
            icon: Icon(AppIcons.cancel, color: Colors.white), // success icon
          );
        } else if (e.code == "invalid-email") {
          Get.snackbar(
            "Sign Up Filed", // title
            "The email address is not valid.", // message
            snackPosition: SnackPosition.TOP, // position of Snackbar
            backgroundColor: AppColors.red, // background color
            colorText: Colors.white, // text color
            borderRadius: 10.0, // rounded corners
            margin: EdgeInsets.all(15), // margin
            duration: Duration(seconds: 3), // duration of Snackbar
            icon: Icon(AppIcons.cancel, color: Colors.white), // success icon
          );
        } else if (e.code == "operation-not-allowed") {
          Get.snackbar(
            "Sign Up Filed", // title
            "Email/password accounts are not enabled.", // message
            snackPosition: SnackPosition.TOP, // position of Snackbar
            backgroundColor: AppColors.red, // background color
            colorText: Colors.white, // text color
            borderRadius: 10.0, // rounded corners
            margin: EdgeInsets.all(15), // margin
            duration: Duration(seconds: 3), // duration of Snackbar
            icon: Icon(AppIcons.cancel, color: Colors.white), // success icon
          );
        }
      }
    }
  }
}
