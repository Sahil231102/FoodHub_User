import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/text_style.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? labelText;
  const CommonTextField(
      {super.key,
      required this.controller,
      this.prefixIcon,
      this.validator,
      this.hintText,
      this.labelText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText ?? "",
            style: AppTextStyle.w400(
                fontSize: 16, color: AppColors.labelTextColor)),
        12.sizeHeight,
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            hintText: hintText,
            hintStyle:
                AppTextStyle.w400(color: AppColors.hintTextColor, fontSize: 17),
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: AppColors.textFormFieldFillColor,
            focusedBorder: _border(),
            enabledBorder: _border(color: AppColors.borderColor),
            errorBorder: _border(color: AppColors.errorColor),
            focusedErrorBorder: _border(
              color: AppColors.errorColor,
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border({Color color = AppColors.primary}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color));
  }
}
