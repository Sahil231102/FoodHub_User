import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/view/widget/app_snackbar.dart';
import 'package:get/get.dart';

class SendResetPasswordEmail extends GetxController {
  Future<void> sendResetPasswordEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      AppSnackbar.showSuccess(
          message: "A password reset link has been sent to $email.", title: "Email Sent");
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == "invalid-email") {
        errorMessage = "The email address is not valid.";
      } else if (e.code == "user-not-found") {
        errorMessage = "No user found with that email address.";
      } else {
        errorMessage = "An error occurred: ${e.message}";
      }

      AppSnackbar.showError(message: "Error");
    }
  }
}
