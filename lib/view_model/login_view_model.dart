import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/services/firebase_services.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  bool isLoginCircular = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> emailLogin(
      {required String email, required String password}) async {
    try {
      isLoginCircular = true;

      await FirebaseServices.firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print("Error during email login : ${e.message}");
    } finally {
      isLoginCircular = false;
    }
  }
}
