import 'package:credit_card_form/credit_card_form.dart';
import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/view/widget/auth_comman_button.dart';
import 'package:food_hub_user/view/widget/common_app_bar.dart';
import 'package:food_hub_user/view/widget/common_text_field.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatNumberController = TextEditingController();
  final TextEditingController homeAddressController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  String? cardNumberController = "";
  String? expiryDateController = "";
  String? expiryYearController = "";
  String? cardType = "";
  String? cardHolderNameController = "";
  String? cvvController = "";

  String? _selectPaymentMethod = "";

  final _formKey = GlobalKey<FormState>(); // Form key for validation

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
            // Wrapping the form inside a Form widget
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextField(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "Please Enter Flat Number";
                    }
                    return null;
                  },
                  labelText: "Flat No",
                  hintText: "Flat Number",
                  controller: flatNumberController,
                ),
                10.sizeHeight,
                CommonTextField(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "Please Enter Address";
                    }
                    return null;
                  },
                  labelText: "Address",
                  hintText: "Address",
                  controller: homeAddressController,
                ),
                10.sizeHeight,
                CommonTextField(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "Please Enter Landmark";
                    }
                    return null;
                  },
                  labelText: "Near By",
                  hintText: "Landmark",
                  controller: landmarkController,
                ),
                10.sizeHeight,
                CommonTextField(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "Please Enter City";
                    }
                    return null;
                  },
                  labelText: "City",
                  hintText: "City",
                  controller: cityController,
                ),
                10.sizeHeight,
                CommonTextField(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "Please Enter Pincode";
                    } else if (p0.length != 6) {
                      return "Enter a 6 Digit Pincode";
                    }
                    return null;
                  },
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
                        title: const Text("CARD"),
                        value: "CARD",
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
                if (_selectPaymentMethod == "CARD") ...[
                  CreditCardForm(
                    cvcLength: 3,
                    theme: CreditCardLightTheme(),
                    onChanged: (CreditCardResult result) {
                      cardNumberController = result.cardNumber;
                      cardHolderNameController = result.cardHolderName;
                      expiryDateController = result.expirationMonth;
                      expiryYearController = result.expirationYear;
                      cardType = result.cardType as String?;
                      cvvController = result.cvc;
                    },
                  ),
                  20.sizeHeight,
                  AuthCommanButton(
                    text: "Pay With Card",
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Processing Card Payment...")),
                        );
                      } else {
                        // Show error message if validation fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please complete the form.")),
                        );
                      }
                    },
                  ),
                  20.sizeHeight,
                ] else if (_selectPaymentMethod == "CASH") ...[
                  20.sizeHeight,
                  AuthCommanButton(
                    text: "Submit",
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Processing Cash Payment...")),
                        );
                      } else {
                        // Show error message if validation fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please complete the form.")),
                        );
                      }
                    },
                  ),
                  20.sizeHeight,
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
