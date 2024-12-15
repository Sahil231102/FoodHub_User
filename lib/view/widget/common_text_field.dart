import 'package:flutter/material.dart';
import 'package:food_hub_user/const/colors.dart';
import 'package:food_hub_user/const/text_style.dart';
import 'package:food_hub_user/view/widget/sized_box.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool obscureText;

  final void Function()? onTap;

  const CommonTextField(
      {super.key,
      required this.controller,
      this.suffixIcon,
      this.validator,
      this.hintText,
      this.labelText,
      this.obscureText = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText ?? "",
            style: AppTextStyle.w300(
                fontSize: 16, color: AppColors.labelTextColor)),
        12.sizeHeight,
        TextFormField(
          onTap: onTap,
          obscureText: obscureText,
          controller: controller,
          validator: validator,
          style: AppTextStyle.w600(
            fontSize: 17,
            color: const Color(
              0xff111719,
            ),
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            hintText: hintText,
            hintStyle:
                AppTextStyle.w400(color: AppColors.hintTextColor, fontSize: 17),
            suffixIcon: suffixIcon,
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
