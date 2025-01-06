import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/text_style.dart';
import 'package:food_hub_user/view/widget/common_app_bar.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(
        text: "Profile",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.black,
              minRadius: 50,
              child: Text(
                "SS",
                style: AppTextStyle.w700(
                  fontSize: 30,
                  color: AppColors.white,
                ),
              ),
            ),
            20.sizeHeight,
            Text(
              "Name",
              style: AppTextStyle.w700(fontSize: 18),
            ),
            10.sizeHeight,
            TextField(
              autofocus: false,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Sahil Sorathiya",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            10.sizeHeight,
            Text(
              "Email",
              style: AppTextStyle.w700(fontSize: 18),
            ),
            10.sizeHeight,
            TextField(
              autofocus: false,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "sorathiyasahil5656@gmail.com",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            10.sizeHeight,
            Text(
              "Mobile Number",
              style: AppTextStyle.w700(
                fontSize: 18,
              ),
            ),
            10.sizeHeight,
            TextField(
              autofocus: false,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "+919909498426",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            10.sizeHeight,
            Text(
              "Gender",
              style: AppTextStyle.w700(fontSize: 18),
            ),
            10.sizeHeight,
            TextField(
              autofocus: false,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Male",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
