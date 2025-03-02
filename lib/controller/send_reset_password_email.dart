import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_hub_user/core/utils/app_snackbar.dart';
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
        debugPrint(errorMessage);
      } else if (e.code == "user-not-found") {
        errorMessage = "No user found with that email address.";
        debugPrint(errorMessage);
      } else {
        errorMessage = "An error occurred: ${e.message}";
        debugPrint(errorMessage);
      }

      AppSnackbar.showError(message: "Error");
    }
  }
}
