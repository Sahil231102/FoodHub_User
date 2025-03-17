import 'package:flutter/material.dart';
import 'package:food_hub_user/core/utils/sized_box.dart';

import '../const/colors.dart';
import '../const/text_style.dart';

class CommonTextField extends StatelessWidget {
  final bool? readOnly;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool obscureText;
  final Widget? prefixIcon;
  final int? maxLength;

  final void Function()? onTap;

  const CommonTextField(
      {super.key,
      this.controller,
      this.suffixIcon,
      this.validator,
      this.hintText,
      this.labelText,
      this.obscureText = false,
      this.onTap,
      this.prefixIcon,
      this.readOnly,
      this.keyboardType,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText ?? "",
            style: AppTextStyle.w600(
              fontSize: 16,
              color: AppColors.labelTextColor,
            )),
        12.sizeHeight,
        TextFormField(
          keyboardType: keyboardType ?? TextInputType.text,
          readOnly: readOnly ?? false,
          onTap: onTap,
          maxLength: maxLength,
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
            counterText: "",
            contentPadding: const EdgeInsets.all(20),
            hintText: hintText,
            hintStyle:
                AppTextStyle.w400(color: AppColors.hintTextColor, fontSize: 17),
            suffixIcon: suffixIcon,
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
