import 'package:flutter/material.dart';
import 'package:food_hub_user/View/login_screen.dart';
import 'package:food_hub_user/const/Icons.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/images.dart';
import 'package:food_hub_user/controller/signup_controller.dart';
import 'package:food_hub_user/view/widget/auth_comman_button.dart';
import 'package:food_hub_user/view/widget/common_text_field.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController _signupController = Get.put(SignupController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                const Positioned(
                  child: Image(
                    image: AssetImage(AppImages.Circle1),
                  ),
                ),
                const Positioned(
                  child: Image(
                    image: AssetImage(AppImages.Circle2),
                  ),
                ),
                const Positioned(
                  right: 0,
                  child: Image(
                    image: AssetImage(AppImages.Circle3),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            32.sizeHeight,
                            const Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 42,
                                  fontFamily: "sp",
                                  fontWeight: FontWeight.bold),
                            ),
                            31.sizeHeight,
                            CommonTextField(
                              labelText: "Full Name",
                              hintText: "Enter Name",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your name";
                                }
                                return null;
                              },
                              controller: nameController,
                            ),
                            29.sizeHeight,
                            CommonTextField(
                              labelText: "E-mail",
                              hintText: "Enter E-mail",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                              controller: emailController,
                            ),
                            29.sizeHeight,
                            Obx(() {
                              return CommonTextField(
                                labelText: "Password",
                                hintText: "Enter Password",
                                obscureText:
                                    !_signupController.isPasswordVisible.value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _signupController.isPasswordVisible.value
                                          ? AppIcons.visibility_on
                                          : AppIcons.visibility_off,
                                    ),
                                    color: AppColors.iconColor,
                                    onPressed: _signupController
                                        .togglePasswordVisibility),
                              );
                            }),
                            33.sizeHeight,
                            AuthCommanButton(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await _signupController.signUpData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                  );
                                }
                              },
                              text: "SIGN UP",
                            ),
                            20.sizeHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an Account?"),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const LoginScreen());
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Color(0xffFE724C),
                                      fontWeight: FontWeight.bold,
                                    ),
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
      },
    );
  }
}
