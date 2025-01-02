import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/text_style.dart';
import 'package:food_hub_user/view/widget/common_app_bar.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        text: "Profile",
      ),
      body: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xff808080)),
              accountName: Text(
                "Sahil Sorathiya",
                style: AppTextStyle.w600(fontSize: 17, color: AppColors.white),
              ),
              accountEmail: Flexible(
                child: Text(
                  "sorathiyasahil5656@gmail.com",
                  style: AppTextStyle.w600(fontSize: 15, color: AppColors.white),
                ),
              ),
              currentAccountPicture: CircleAvatar(
                minRadius: 20,
                backgroundColor: Colors.black87,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SS",
                      style: AppTextStyle.bold(
                        fontSize: 25,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              )),
          ListTile(
            onLongPress: () {
              Get.to(() => ProfileScreen());
            },
            leading: const Icon(
              Icons.person,
            ),
            title: Text(
              'My Profile',
              style: AppTextStyle.w700(fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.food_bank),
            title: Text(
              'My Order',
              style: AppTextStyle.w700(fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text(
              'Payment Method',
              style: AppTextStyle.w700(fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(
              'Delivery Address',
              style: AppTextStyle.w700(fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.message,
            ),
            title: Text(
              "Contact Us",
              style: AppTextStyle.w700(fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: Text(
              'Settings',
              style: AppTextStyle.w700(fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.help,
            ),
            title: Text(
              'Helps',
              style: AppTextStyle.w700(fontSize: 16),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
