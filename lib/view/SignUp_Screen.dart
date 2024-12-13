import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/View/login_screen.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/services/firebase_services.dart';
import 'package:food_hub_user/view/widget/common_text_field.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firebasereal = FirebaseDatabase.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> signUpData(
      {required String email, required String password}) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      await FirebaseServices.firebaseFirestore
          .doc(userCredential.user?.uid)
          .set({
        "uid": userCredential.user?.uid,
        "email": emailController.text,
        "name": nameController.text,
        "last_login_time": DateTime.now().toIso8601String(),
      });

      if (userCredential.user?.uid != null) {
        Get.to(() => const LoginScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Decorations
            Positioned(
              top: -50,
              right: -80,
              child: Container(
                height: 120,
                width: 204,
                decoration: BoxDecoration(
                    color: Color(0xffFE724C), shape: BoxShape.circle),
              ),
            ),
            Positioned(
              top: -10,
              left: -60,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    color: Color(0xffFE724C), shape: BoxShape.circle),
              ),
            ),
            Positioned(
              top: -120,
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: Color(0xffffece7),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Form Layout
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 42,
                              fontFamily: "sp",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),

                        CommonTextField(
                            labelText: "Full Name",
                            hintText: "Your Name",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Your Email Address";
                              }
                              return null;
                            },
                            controller: nameController),

                        // Email Field
                        29.sizeHeight,
                        CommonTextField(
                            labelText: "E-mail",
                            hintText: "Enter E-mail",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Your Email Address";
                              }
                              return null;
                            },
                            controller: emailController),

                        29.sizeHeight,
                        CommonTextField(
                            prefixIcon: Icon(
                              Icons.visibility,
                              color: AppColors.iconColor,
                            ),
                            labelText: "Password",
                            hintText: "Enter Password",
                            controller: passwordController),

                        // Sign Up Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFE724C),
                                  fixedSize: Size(250, 60)),
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  await signUpData(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child: Center(
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Login Redirect
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an Account?"),
                            TextButton(
                              onPressed: () {
                                Get.to(LoginScreen());
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Color(0xffFE724C),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
