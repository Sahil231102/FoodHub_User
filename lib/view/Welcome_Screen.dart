import 'package:flutter/material.dart';
import 'package:food_hub_user/View/login_screen.dart';
import 'package:food_hub_user/View/SignUp_Screen.dart';
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/welcome.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 130,
                  left: 28,
                ),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Welcome To \n",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'sp',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "Foodhub",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'sp',
                          color: Color(0xffFE724C),
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
              ),
              Text(
                "Your favourite foods delivered\nfast at your door.",
              ),
            ],
          )),
          Column(
            children: [
              SizedBox(
                height: 650,
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.white, strokeAlign: 2),
                      fixedSize: Size(300, 50),
                      backgroundColor: Colors.white30,
                    ),
                    onPressed: () {
                      Get.to(SignupScreen());
                    },
                    child: Text(
                      "Start With Email",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(LoginScreen());
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
