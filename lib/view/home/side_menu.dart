import 'package:flutter/material.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';
import 'package:food_hub_user/services/get_storage_services.dart';
import 'package:food_hub_user/view/auth/login_screen.dart';
import 'package:get/get.dart';

import '../../core/const/colors.dart';
import '../../core/const/text_style.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final GetStorageServices getStorageServices = Get.put(GetStorageServices());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: AppColors.primary),
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
            120.sizeHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      getStorageServices.write("isLoggedIn", false);
                      Get.to(() => const LoginScreen());
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.power_settings_new,
                          color: AppColors.white,
                        ),
                        5.sizeWidth,
                        Text(
                          "LOGOUT",
                          style: AppTextStyle.w700(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
