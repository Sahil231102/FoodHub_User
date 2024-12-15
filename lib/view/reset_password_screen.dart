import 'package:flutter/material.dart';
import 'package:food_hub_user/View/login_screen.dart';
import 'package:food_hub_user/const/images.dart';
import 'package:food_hub_user/controller/send_reset_password_email.dart';
import 'package:food_hub_user/view/widget/auth_comman_button.dart';
import 'package:food_hub_user/view/widget/common_text_field.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';
import 'package:get/get.dart';

class ResetpasswordScreen extends StatefulWidget {
  const ResetpasswordScreen({super.key});

  @override
  State<ResetpasswordScreen> createState() => _ResetpasswordScreenState();
}

class _ResetpasswordScreenState extends State<ResetpasswordScreen> {
  final SendResetPasswordEmail sendResetPasswordEmail =
      Get.put(SendResetPasswordEmail());
  TextEditingController emailController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<SendResetPasswordEmail>(
          builder: (controller) {
            return Stack(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Reset Password",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        10.sizeHeight,
                        const Text(
                          "Please enter your email address to\nrequest a password reset",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "sp",
                              color: Color(0xff9796a1),
                              fontWeight: FontWeight.normal),
                        ),
                        CommonTextField(
                            hintText: "Enter Your Email",
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return "please enter email";
                              }
                            },
                            controller: emailController),
                        51.sizeHeight,
                        AuthCommanButton(
                          text: "SEND NEW PASSWORD",
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              await controller.sendResetPasswordEmail(
                                  email: emailController.text);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
