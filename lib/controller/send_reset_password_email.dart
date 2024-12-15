import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendResetPasswordEmail extends GetxController {
  Future<void> sendResetPasswordEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Email Sent",
        "A password reset link has been sent to $email.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        borderRadius: 10.0,
        margin: const EdgeInsets.all(15),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == "invalid-email") {
        errorMessage = "The email address is not valid.";
      } else if (e.code == "user-not-found") {
        errorMessage = "No user found with that email address.";
      } else {
        errorMessage = "An error occurred: ${e.message}";
      }

      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10.0,
        margin: const EdgeInsets.all(15),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.white),
      );
    }
  }
}
