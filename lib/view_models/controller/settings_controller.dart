import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/storage/app_storage.dart';

class SettingsController extends GetxController {
  var isNotificationEnabled = true.obs;

  final oldPinController = TextEditingController();
  final newPinController = TextEditingController();
  final confirmPinController = TextEditingController();

  void toggleNotifications(bool value) {
    isNotificationEnabled.value = value;
  }

  void changePin() async {
    String currentPin = AppStorage.pin;
    
    if (oldPinController.text != currentPin) {
      Get.snackbar('Error', 'Old PIN is incorrect', 
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
      return;
    }

    if (newPinController.text.length != 6) {
      Get.snackbar('Error', 'New PIN must be 6 digits',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
      return;
    }

    if (newPinController.text != confirmPinController.text) {
      Get.snackbar('Error', 'New PIN and Confirm PIN do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
      return;
    }

    await AppStorage.savePin(newPinController.text);
    Get.back(); // Close dialog
    _clearControllers();
    
    Get.snackbar('Success', 'PIN changed successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white
    );
  }

  void _clearControllers() {
    oldPinController.clear();
    newPinController.clear();
    confirmPinController.clear();
  }

  @override
  void onClose() {
    oldPinController.dispose();
    newPinController.dispose();
    confirmPinController.dispose();
    super.onClose();
  }
}
