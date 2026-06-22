import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/storage/app_storage.dart';
import '../../res/routes/routes_names.dart';

class AuthController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  
  var attempts = 3.obs;
  var isError = false.obs;
  var isSuccess = false.obs;

  void verifyPin(String enteredPin) {
    String currentPin = AppStorage.pin;
    
    if (enteredPin == currentPin) {
      isSuccess.value = true;
      isError.value = false;
      
      // Navigate to Dashboard after a short delay
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(RouteName.dashboard);
      });
    } else {
      attempts.value--;
      isError.value = true;
      pinController.clear();
      
      if (attempts.value <= 0) {
        // Handle too many failed attempts
        Get.snackbar('Error', 'Too many failed attempts');
      }
    }
  }

  @override
  void onClose() {
    pinController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
