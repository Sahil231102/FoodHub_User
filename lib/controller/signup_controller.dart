import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/const/Icons.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/services/firebase_services.dart';
import 'package:food_hub_user/view/auth/login_screen.dart';
import 'package:food_hub_user/view/widget/app_snackbar.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signUpData(
      {required String email, required String password, required String name}) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await FirebaseServices.useFirestore.doc(userCredential.user?.uid).set({
          "uid": userCredential.user?.uid,
          "password": password,
          "email": email,
          "name": name,
          "last_login_time": DateTime.now().toIso8601String(),
        });

        if (userCredential.user?.uid != null) {
          Get.to(() => const LoginScreen());
          AppSnackbar.showError(
              message: "Welcome! You have successfully signed up.", title: "Sign Up Successful");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {
          AppSnackbar.showError(
            message: "The email address is already in use by another account.",
            title: "Sign Up Filed",
          );
        } else if (e.code == "weak-password") {
          AppSnackbar.showError(
            message: "The password is too weak.",
            title: "Sign Up Filed",
          );
        } else if (e.code == "invalid-email") {
          AppSnackbar.showError(
            message: "The email address is not valid.",
            title: "Sign Up Filed",
          );
        }
      }
    }
  }
}
