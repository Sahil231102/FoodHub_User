import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/images.dart';
import 'package:food_hub_user/const/text_style.dart';
import 'package:food_hub_user/controller/location_controller.dart';
import 'package:food_hub_user/view/widget/auth_comman_button.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../widget/auth_comman_title_text.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final LocationController _locationController = Get.put(LocationController());
  final TextEditingController mobile = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _selectedGender = "";
  String? _country = "";
  String _countryPhone = "";
  String? _state = "";
  String? _city = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<LocationController>(
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
                              text: "Personal Information",
                              fontSize: 30,
                            ),
                            31.sizeHeight,
                            CSCPicker(
                              onCountryChanged: (value) {
                                controller.countryPhone = value;
                                controller.country = value;
                              },
                              onStateChanged: (value) {
                                controller.state = value ?? "";
                                print("================>>${controller.state}<<<<=============");
                              },
                              onCityChanged: (value) {
                                controller.city = value ?? "";
                                print("================>>${controller.city}<<<<=============");
                              },
                            ),
                            31.sizeHeight,
                            Text("Mobile Number",
                                style: AppTextStyle.w300(
                                    fontSize: 16, color: AppColors.labelTextColor)),
                            12.sizeHeight,
                            IntlPhoneField(
                              dropdownTextStyle: AppTextStyle.w600(
                                fontSize: 17,
                                color: const Color(0xff111719),
                              ),
                              style: AppTextStyle.w600(
                                fontSize: 17,
                                color: const Color(0xff111719),
                              ),
                              // Set the phone code here
                              onTap: () {},
                              initialValue: controller.countryPhone,

                              decoration: InputDecoration(
                                  counterText: "",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: AppColors.borderColor),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: AppColors.errorColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: AppColors.errorColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                    ),
                                  )),
                            ),
                            31.sizeHeight,
                            Text("Select Gender",
                                style: AppTextStyle.w300(
                                    fontSize: 16, color: AppColors.labelTextColor)),
                            12.sizeHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    activeColor: AppColors.primary,
                                    title: Text("Male"),
                                    value: "Male",
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    activeColor: AppColors.primary,
                                    title: Text("Female"),
                                    value: "Female",
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            31.sizeHeight,
                            AuthCommanButton(
                              onTap: () async {
                                if (_formKey.currentState?.validate() ?? false) {
                                  // Process form
                                }
                              },
                              text: "LOGIN",
                            ),
                            32.sizeHeight,
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
