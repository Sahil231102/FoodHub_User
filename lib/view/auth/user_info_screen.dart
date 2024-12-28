import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/images.dart';
import 'package:food_hub_user/const/text_style.dart';
import 'package:food_hub_user/controller/location_controller.dart';
import 'package:food_hub_user/controller/user_info_controller.dart';
import 'package:food_hub_user/view/widget/auth_comman_button.dart';
import 'package:food_hub_user/view/widget/auth_comman_title_text.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
  final LocationController _locationController = Get.put(LocationController());
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  final TextEditingController mobile = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? selectedGender = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<LocationController>(builder: (locationController) {
        return GetBuilder<UserInfoController>(
          builder: (userInfoController) {
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
                              20.sizeHeight,
                              AuthCommanTitleText(
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
                                  if (p0 == null || p0.number.isEmpty) {
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
                                onTap: () {
                                  print("===========>${locationController.country}");
                                },
                                initialCountryCode: "IN",
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
                                  ),
                                ),
                              ),
                              20.sizeHeight,
                              Text("Select CSC",
                                  style: AppTextStyle.w300(
                                      fontSize: 16, color: AppColors.labelTextColor)),
                              12.sizeHeight,
                              CSCPicker(
                                dropdownItemStyle: AppTextStyle.w600(
                                  fontSize: 17,
                                  color: const Color(
                                    0xff111719,
                                  ),
                                ),
                                cityDropdownLabel: "Select City",
                                stateDropdownLabel: "Select State",
                                disabledDropdownDecoration: BoxDecoration(color: Colors.white),
                                layout: Layout.horizontal,
                                searchBarRadius: 10,
                                countryDropdownLabel: "Select Country",
                                citySearchPlaceholder: "Select City",
                                onCountryChanged: (value) {
                                  locationController.country = value;
                                  locationController.countryPhone = value;
                                  locationController.country.removeAllWhitespace.toString();
                                },
                                onStateChanged: (value) {
                                  locationController.state = value ?? "";
                                },
                                onCityChanged: (value) {
                                  locationController.city = value ?? "";
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
                                      groupValue: selectedGender,
                                      title: Text("Male"),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                      value: "Female",
                                      groupValue: selectedGender,
                                      title: Text("Female"),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = value;
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
                                    if (mobile.text == null) {
                                      Get.snackbar(
                                          "Error", "Please select your country, state, and city",
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white);
                                      return;
                                    }
                                    if (locationController.country.isEmpty ||
                                        locationController.state.isEmpty ||
                                        locationController.city.isEmpty) {
                                      // Show error if any location field is empty
                                      Get.snackbar(
                                          "Error", "Please select your country, state, and city",
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white);
                                      return;
                                    }
                                    if (selectedGender == null || selectedGender!.isEmpty) {
                                      // Show error if gender is not selected
                                      Get.snackbar("Error", "Please select your gender",
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white);
                                      return;
                                    }

                                    // Proceed to save user information if all validations pass
                                    userInfoController.userInformationData(
                                        uid: widget.uid,
                                        city: locationController.city,
                                        country: locationController.country,
                                        state: locationController.state,
                                        gender: selectedGender!,
                                        mobileNumber: mobile.text);
                                  }
                                },
                                isLoading: userInfoController.isUpdate,
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
        );
      }),
    );
  }
}
