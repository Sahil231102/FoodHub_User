import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/controller/user_info_controller.dart';
import 'package:food_hub_user/core/const/colors.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../core/component/auth_comman_button.dart';
import '../../core/component/auth_comman_title_text.dart';
import '../../core/const/images.dart';
import '../../core/const/text_style.dart';

class UserInfoScreen extends StatefulWidget {
  final String? uid;

  const UserInfoScreen({
    super.key,
    this.uid,
  });

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final UserInfoController userInfoController = Get.put(UserInfoController());
  final TextEditingController mobile = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String dbCountryCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<UserInfoController>(
        builder: (controller) {
          return SafeArea(
            child: Stack(
              children: [
                const Positioned(child: Image(image: AssetImage(AppImages.circle1))),
                const Positioned(child: Image(image: AssetImage(AppImages.circle2))),
                const Positioned(right: 0, child: Image(image: AssetImage(AppImages.circle3))),
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
                            20.sizeHeight,
                            const AuthCommanTitleText(
                              text: "Sign Up Information",
                              fontSize: 30,
                            ),
                            31.sizeHeight,
                            Text("Mobile Number",
                                style: AppTextStyle.w300(
                                    fontSize: 16, color: AppColors.labelTextColor)),
                            12.sizeHeight,
                            IntlPhoneField(
                              validator: (p0) {
                                if (p0 == null || mobile.text.isEmpty) {
                                  return 'Phone number is required';
                                }
                                // Validate the phone number format using your custom validator

                                return null; // Return null if validation passes
                              },
                              controller: mobile,
                              initialValue: "",
                              dropdownTextStyle: AppTextStyle.w600(
                                fontSize: 17,
                                color: const Color(0xff111719),
                              ),
                              style: AppTextStyle.w600(
                                fontSize: 17,
                                color: const Color(0xff111719),
                              ),
                              onChanged: (value) {
                                dbCountryCode = value.countryCode;
                              },
                              initialCountryCode: "IN",
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: AppColors.borderColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: AppColors.errorColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: AppColors.errorColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            20.sizeHeight,
                            Text("Select Location",
                                style: AppTextStyle.w300(
                                    fontSize: 16, color: AppColors.labelTextColor)),
                            12.sizeHeight,
                            CSCPickerPlus(
                              dropdownItemStyle: AppTextStyle.w600(
                                fontSize: 17,
                                color: const Color(
                                  0xff111719,
                                ),
                              ),
                              cityDropdownLabel: "Select City",
                              stateDropdownLabel: "Select State",
                              disabledDropdownDecoration: const BoxDecoration(color: Colors.white),
                              layout: Layout.horizontal,
                              searchBarRadius: 10,
                              countryDropdownLabel: "Select Country",
                              citySearchPlaceholder: "Select City",
                              onCountryChanged: (value) {
                                List<String> countryDetails = value.split(" ");
                                String countryName = countryDetails.last
                                    .replaceAll(RegExp(r'[()]'), ''); // Extract country code
                                String countryCode = countryDetails.first;
                                controller.countryCode = countryCode.toLowerCase();
                                controller.countryName = countryName.toString();
                              },
                              onStateChanged: (value) {
                                controller.state = value ?? "";
                              },
                              onCityChanged: (value) {
                                controller.city = value ?? "";
                              },
                            ),
                            31.sizeHeight,
                            Text("Select Gender",
                                style: AppTextStyle.w300(
                                    fontSize: 16, color: AppColors.labelTextColor)),
                            12.sizeHeight,
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    value: "Male",
                                    groupValue: controller.selectedGender,
                                    title: const Text("Male"),
                                    onChanged: (value) {
                                      controller.updateGender(value!);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    value: "Female",
                                    groupValue: controller.selectedGender,
                                    title: const Text("Female"),
                                    onChanged: (value) {
                                      controller.updateGender(value!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            31.sizeHeight,
                            AuthCommanButton(
                              onTap: () async {
                                // Check if all fields are valid
                                if (!_formKey.currentState!.validate()) {}

                                if (mobile.text.isEmpty) {
                                  Get.snackbar(
                                    "Error",
                                    "Mobile Number is required.",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                  return;
                                }

                                if (controller.countryName.isEmpty) {
                                  Get.snackbar(
                                    "Error",
                                    "Country is required. Please select your country.",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                  return;
                                }

                                if (controller.state.isEmpty) {
                                  Get.snackbar(
                                    "Error",
                                    "State is required. Please select your state.",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                  return;
                                }

                                if (controller.city.isEmpty) {
                                  Get.snackbar(
                                    "Error",
                                    "City is required. Please select your city.",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                  return;
                                }

                                if (controller.selectedGender.isEmpty) {
                                  Get.snackbar(
                                    "Error",
                                    "Gender is required. Please select your gender.",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                  return;
                                }

                                // If all validations pass, proceed with saving the information
                                await controller.userInformationData(
                                  uid: widget.uid,
                                  city: controller.city,
                                  countryName: controller.countryName,
                                  countryCode: controller.countryCode,
                                  state: controller.state,
                                  gender: controller.selectedGender,
                                  mobileNumber: dbCountryCode + mobile.text,
                                );
                              },
                              isLoading: controller.isUpdate,
                              text: "SAVE",
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
