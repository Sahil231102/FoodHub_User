import 'package:flutter/material.dart';
import 'package:food_hub_user/core/const/colors.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';
import 'package:food_hub_user/view/auth/login_screen.dart';
import 'package:food_hub_user/view/auth/signup_screen.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 800,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/welcome.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Column(
              children: [
                160.sizeHeight,
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: "Welcome to \n",
                      style: TextStyle(
                          fontSize: 47,
                          fontFamily: 'sp',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "FoodHub",
                      style: TextStyle(
                          fontSize: 47,
                          fontFamily: 'sp',
                          color: Color(0xffFE724C),
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
                20.sizeHeight,
                const Text(
                  "Your favourite foods delivered\nfast at your door.",
                  style: TextStyle(
                      color: AppColors.welcomeTextColor, fontSize: 18, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          30.sizeHeight,
          Column(
            children: [
              650.sizeHeight,
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, strokeAlign: 2),
                      fixedSize: const Size(315, 54),
                      backgroundColor: Colors.white30,
                    ),
                    onPressed: () {
                      Get.to(const SignupScreen());
                    },
                    child: const Text(
                      "Start with email",
                      style:
                          TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                    )),
              ),
              20.sizeHeight,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  20.sizeHeight,
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(const LoginScreen());
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.white,
                        ),
                      ))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
