import 'package:flutter/material.dart';
import 'package:food_hub_user/View/Login_Screen.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

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

                        Text(
                          "Full Name",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "sp",
                              color: Color(0xff9796a1),
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Your Full Name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Enter Your Full Name",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Email Field
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "sp",
                              color: Color(0xff9796a1),
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Your Email Address";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "Enter Your Email Address",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Password Field
                        Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "sp",
                              color: Color(0xff9796a1),
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Your Password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Enter Password",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        // Sign Up Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFE724C),
                                  fixedSize: Size(250, 60)),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  );
                                  nameController.clear();
                                  emailController.clear();
                                  passwordController.clear();
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
