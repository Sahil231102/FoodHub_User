import 'package:flutter/material.dart';
import 'package:food_hub_user/const/Icons.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/images.dart';
import 'package:food_hub_user/controller/login_controller.dart';
import 'package:food_hub_user/services/validator.dart';
import 'package:food_hub_user/view/auth/reset_password_screen.dart';
import 'package:food_hub_user/view/auth/signup_screen.dart';
import 'package:food_hub_user/view/widget/auth_comman_button.dart';
import 'package:food_hub_user/view/widget/auth_comman_title_text.dart';
import 'package:food_hub_user/view/widget/common_text_field.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.put(LoginController());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LoginController>(
        builder: (controller) {
          return SafeArea(
            child: Stack(
              children: [
                const Positioned(child: Image(image: AssetImage(AppImages.Circle1))),
                const Positioned(child: Image(image: AssetImage(AppImages.Circle2))),
                const Positioned(right: 0, child: Image(image: AssetImage(AppImages.Circle3))),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            const AuthCommanTitleText(
                              text: "Login",
                            ),
                            31.sizeHeight,
                            CommonTextField(
                              labelText: "E-mail",
                              hintText: "Your email",
                              controller: emailController,
                              validator: (value) => AppValidator.validateEmail(value),
                            ),
                            31.sizeHeight,
                            Obx(
                              () {
                                return CommonTextField(
                                  obscureText: _loginController.isPasswordVisible.value,
                                  hintText: "Password",
                                  controller: passwordController,
                                  labelText: "Password",
                                  suffixIcon: Icon(
                                    _loginController.isPasswordVisible.value
                                        ? AppIcons.visibility_on
                                        : AppIcons.visibility_off,
                                    color: AppColors.iconColor,
                                  ),
                                  onTap: _loginController.togglePasswordVisibility,
                                  validator: (value) => AppValidator.validatePassword(value),
                                );
                              },
                            ),
                            32.sizeHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => const ResetPasswordScreen());
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Color(0xffFE724C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            32.sizeHeight,
                            AuthCommanButton(
                              onTap: () async {
                                if (_formKey.currentState?.validate() ?? false) {
                                  await controller.emailLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: "LOGIN",
                              isLoading: controller.isLoginCircular,
                            ),
                            const SizedBox(height: 16),
                            32.sizeHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't Have an Account?"),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(const SignupScreen());
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(0), // Sets margin to 0
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
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
          );
        },
      ),
    );
  }
}
