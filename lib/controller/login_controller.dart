import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/services/firebase_services.dart';
import 'package:food_hub_user/view/home/home_screen.dart';
import 'package:food_hub_user/view/widget/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/get_storage_services.dart';

class LoginController extends GetxController {
  final GetStorageServices _getStorageServices = Get.put(GetStorageServices());

  final box = GetStorage();
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

      final userData =
          await FirebaseServices.firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userData.user?.uid != null) {
        await _getStorageServices.write("email", emailController);
        await _getStorageServices.write("password", passwordController.text);

        await FirebaseServices.useFirestore.doc(userData.user?.uid).update({
          "last_login_time": DateTime.now().toIso8601String(),
        });

        Get.to(() => HomeScreen());
        AppSnackbar.showSuccess(message: 'Operation completed successfully.');
      }
    } on FirebaseAuthException catch (e) {
      String getErrorMessage(FirebaseAuthException e) {
        print("Error Code: ${e.code}");
        switch (e.code) {
          case 'invalid-email':
            return "The email address is not valid.";
          case 'user-disabled':
            return "This user has been disabled.";
          case 'user-not-found':
            return "No user found for this email.";
          case 'wrong-password':
            return "Incorrect password. Please try again.";
          case 'email-already-in-use':
            return "This email address is already in use.";
          case 'operation-not-allowed':
            return "This operation is not allowed. Please contact support.";
          case 'weak-password':
            return "The password is too weak. Please choose a stronger password.";
          case 'requires-recent-login':
            return "Please log in again to perform this operation.";
          case 'account-exists-with-different-credential':
            return "An account already exists with a different sign-in method.";
          case 'credential-already-in-use':
            return "This credential is already associated with another account.";
          case 'invalid-credential':
            return "The provided credential is not valid.";
          case 'network-request-failed':
            return "Network error. Please check your connection.";
          case 'too-many-requests':
            return "Too many attempts. Please try again later.";
          case 'provider-already-linked':
            return "This account is already linked with the provider.";
          case 'no-such-provider':
            return "This provider is not available for this user.";
          case 'invalid-verification-code':
            return "The verification code is incorrect.";
          case 'invalid-verification-id':
            return "The verification ID is not valid.";
          case 'session-expired':
            return "The session has expired. Please try again.";
          case 'missing-email':
            return "Please provide an email address.";
          default:
            return "An unknown error occurred. Please try again.";
        }
      }

      AppSnackbar.showError(message: getErrorMessage(e));
    } finally {
      isLoginCircular = false;
      update();
    }
  }
}
