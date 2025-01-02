import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/services/get_storage_services.dart';
import 'package:food_hub_user/view/auth/login_screen.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';
import 'package:get/get.dart';

import '../../const/text_style.dart';
import '../widget/common_app_bar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GetStorageServices _GetStorageServices = Get.put(GetStorageServices());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          text: "Account",
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
                      _GetStorageServices.write("isLoggedIn", false);
                      Get.to(() => LoginScreen());
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
        ));
  }
}
