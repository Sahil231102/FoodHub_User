import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/controller/get_user_info_controller.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';
import 'package:food_hub_user/view/auth/login_screen.dart';
import 'package:get/get.dart';

import '../../core/component/common_app_bar.dart';
import '../../core/component/common_button.dart';
import '../../core/const/colors.dart';
import '../../core/const/images.dart';
import '../../core/const/text_style.dart';
import '../../services/get_storage_services.dart' show GetStorageServices;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GetUserInfoController getUserInfoController = Get.put(GetUserInfoController());
  final GetStorageServices _getStorageServices = Get.put(GetStorageServices());

  @override
  void initState() {
    super.initState();
    getUserInfoController.fetchData(); // Fetch user data on screen load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(text: "Profile"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (getUserInfoController.isLoading.value) {
            // Show loading indicator while fetching data
            return const Center(child: CircularProgressIndicator());
          }

          var userData = getUserInfoController.userData;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.black,
                minRadius: 50,
                child: Image.asset(
                  height: 85,
                  width: 85,
                  userData["gender"] == "Male" ? AppImages.male : AppImages.female,
                  fit: BoxFit.cover,
                ),
              ),
              20.sizeHeight,
              buildProfileField("Name", userData["name"] ?? "N/A"),
              buildProfileField("Email", userData["email"] ?? "N/A"),
              buildProfileField("Mobile Number", userData["mobile_number"] ?? "N/A"),
              buildProfileField("Gender", userData["gender"] ?? "N/A"),
              20.sizeHeight,
              Center(
                child: CommonButton(
                  onPressed: () {
                    showLogoutDialog(context);
                  },
                  text: "Logout",
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.w700(fontSize: 18)),
        10.sizeHeight,
        TextField(
          autofocus: false,
          readOnly: true,
          decoration: InputDecoration(
            hintText: value,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        10.sizeHeight,
      ],
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Are you sure you want to log out?",
            style: AppTextStyle.w700(fontSize: 18),
          ),
          actions: [
            CommonButton(
              height: 30,
              width: 80,
              onPressed: () async {
                _getStorageServices.write('isLoggedIn', false);
                await FirebaseAuth.instance.signOut();
                Get.offAll(() => const LoginScreen()); // Navigate to login screen
              },
              text: "Yes",
            ),
            CommonButton(
              height: 30,
              width: 80,
              text: "No",
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
