import 'package:flutter/material.dart';

const _data = "sp";

class AppTextStyle {
  static TextStyle w400({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      color: color ?? Colors.black,
      fontSize: fontSize ?? 12,
      fontFamily: _data,
    );
  }

  static TextStyle w500({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: color ?? Colors.black,
      fontSize: 12,
      fontFamily: _data,
    );
  }

  static TextStyle w600({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      color: color ?? Colors.black,
      fontSize: fontSize ?? 12,
      fontFamily: _data,
    );
  }

  static TextStyle w700({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.w700,
      color: color ?? Colors.black,
      fontSize: fontSize ?? 12,
      fontFamily: _data,
    );
  }
}
