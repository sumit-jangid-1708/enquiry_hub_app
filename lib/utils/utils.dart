import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/color/app_color.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus,
      ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static bool isEmailValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email.trim());
  }

  static void toastMessage(String message) {
    Get.rawSnackbar(
      message: message,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.kColorPrimary.withOpacity(0.8),
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
    );
  }

  static void snackBar(
      String title,
      String message, {
        bool isError = false,
      }) {
    Get.closeAllSnackbars();

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      backgroundColor:
      isError ? AppColor.errorColor : AppColor.kColorPrimary,
      colorText: AppColor.whiteColor,
      icon: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: AppColor.whiteColor,
      ),
      duration: const Duration(seconds: 3),
    );
  }
}
