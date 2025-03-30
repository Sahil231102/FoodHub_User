import 'package:flutter/material.dart';
import 'package:food_hub_user/controller/online_payment_controller.dart';
import 'package:food_hub_user/core/const/colors.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../core/component/common_app_bar.dart';
import '../../core/component/common_button.dart';
import '../../core/component/common_text_field.dart';

class AddressScreen extends StatefulWidget {
  final String payment;
  final String mobileNumber;

  const AddressScreen(
      {super.key, required this.payment, required this.mobileNumber});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final OnlinePaymentController onlinePaymentController =
      Get.put(OnlinePaymentController());
  final TextEditingController flatNumberController = TextEditingController();
  final TextEditingController homeAddressController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectPaymentMethod = "";

  void _submitOrder() async {
    if (_formKey.currentState?.validate() ?? false) {
      onlinePaymentController.setUserAddress(
        flatNumber: flatNumberController.text,
        homeAddress: homeAddressController.text,
        landmark: landmarkController.text,
        city: cityController.text,
        pinCode: pinCodeController.text,
      );

      context.loaderOverlay.show(); // Show loader before starting

      try {
        if (_selectPaymentMethod == "ONLINE") {
          await onlinePaymentController.openCheckout(
            payment: widget.payment.toString(),
            mobileNumber: widget.mobileNumber,
          );
        } else if (_selectPaymentMethod == "CASH") {
          await onlinePaymentController
              .placeCashOrder(widget.payment.toString());
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      } finally {
        context.loaderOverlay.hide(); // Hide loader after completion
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete the form.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        text: "Address Details",
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 20, top: 20, left: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextField(
                  validator: (p0) => p0 == null || p0.isEmpty
                      ? "Please Enter Flat Number"
                      : null,
                  labelText: "Flat No",
                  hintText: "Flat Number",
                  controller: flatNumberController,
                ),
                10.sizeHeight,
                CommonTextField(
                  validator: (p0) =>
                      p0 == null || p0.isEmpty ? "Please Enter Address" : null,
                  labelText: "Address",
                  hintText: "Address",
                  controller: homeAddressController,
                ),
                10.sizeHeight,
                CommonTextField(
                  validator: (p0) =>
                      p0 == null || p0.isEmpty ? "Please Enter Landmark" : null,
                  labelText: "Near By",
                  hintText: "Landmark",
                  controller: landmarkController,
                ),
                10.sizeHeight,
                CommonTextField(
                  validator: (p0) =>
                      p0 == null || p0.isEmpty ? "Please Enter City" : null,
                  labelText: "City",
                  hintText: "City",
                  controller: cityController,
                ),
                10.sizeHeight,
                CommonTextField(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) return "Please Enter Pincode";
                    if (p0.length != 6) return "Enter a 6 Digit Pincode";
                    return null;
                  },
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  labelText: "Pincode",
                  hintText: "Pincode",
                  controller: pinCodeController,
                ),
                10.sizeHeight,
                const Text("Payment Method"),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: const Text("CASH"),
                        value: "CASH",
                        groupValue: _selectPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectPaymentMethod = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text("ONLINE"),
                        value: "ONLINE",
                        groupValue: _selectPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectPaymentMethod = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                20.sizeHeight,
                Center(
                  child: _selectPaymentMethod == "ONLINE"
                      ? CommonButton(
                          width: 200,
                          text: "Pay With Online",
                          onPressed: _submitOrder,
                        )
                      : CommonButton(
                          text: "Pay with Cash",
                          onPressed: _submitOrder,
                        ),
                ),
                20.sizeHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
