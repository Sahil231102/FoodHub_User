import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  // Private constructor to prevent instantiation
  AppSnackbar._();

  /// Shows a success snackbar
  static void showSuccess({required String message, String? title}) {
    _showSnackbar(
      message: message,
      title: title ?? 'Success',
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  /// Shows an error snackbar
  static void showError({required String message, String? title}) {
    _showSnackbar(
      message: message,
      title: title ?? 'Error',
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  /// Private method to configure and show the snackbar
  static void _showSnackbar({
    required String message,
    required String title,
    required Color backgroundColor,
    required IconData icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      borderRadius: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
