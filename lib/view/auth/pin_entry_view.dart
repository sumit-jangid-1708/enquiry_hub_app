import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../res/color/app_color.dart';
import '../../view_models/controller/auth_controller.dart';

class PinEntryView extends StatelessWidget {
  PinEntryView({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              const SizedBox(height: 60),
              // Lock Icon
              _buildLockIcon(),
              const SizedBox(height: 24),
              // Title and Subtitle
              _buildHeader(),
              const SizedBox(height: 40),
              // PIN Input
              _buildPinInput(),
              const SizedBox(height: 10),
              // Status Message
              _buildStatusMessage(),
              const Spacer(),
              // Custom Keyboard
              _buildKeyboard(),
              const SizedBox(height: 20),
              // Biometrics
              // _buildBiometricsButton(),
              const SizedBox(height: 20),
              if (controller.isSuccess.value) _buildSuccessButton(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLockIcon() {
    Color iconColor = AppColor.kColorPrimary;
    Color bgColor = AppColor.kColorPrimary.withOpacity(0.1);

    if (controller.isError.value) {
      iconColor = AppColor.errorColor;
      bgColor = AppColor.errorColor.withOpacity(0.1);
    } else if (controller.isSuccess.value) {
      iconColor = AppColor.successColor;
      bgColor = AppColor.successColor.withOpacity(0.1);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        controller.isSuccess.value ? Icons.lock_open_rounded : Icons.lock_outline_rounded,
        color: iconColor,
        size: 32,
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          controller.isSuccess.value ? 'access_granted'.tr : 'app_name'.tr,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.kColorTextPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          controller.isSuccess.value 
              ? 'dashboard_khul_raha'.tr 
              : controller.isError.value 
                  ? 'galat_pin_attempts'.trParams({'attempts': controller.attempts.value.toString()})
                  : 'enter_pin'.tr + '\n' + 'to_access_dashboard'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: controller.isError.value ? AppColor.errorColor : AppColor.kColorTextSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildPinInput() {
    final defaultPinTheme = PinTheme(
      width: 20,
      height: 20,
      textStyle: const TextStyle(fontSize: 20, color: AppColor.kColorPrimary),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.cardBorderColor, width: 2),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColor.kColorAccent),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: controller.isError.value 
            ? AppColor.errorColor 
            : controller.isSuccess.value 
                ? AppColor.successColor 
                : AppColor.kColorAccent,
        border: Border.all(
          color: controller.isError.value 
              ? AppColor.errorColor 
              : controller.isSuccess.value 
                  ? AppColor.successColor 
                  : AppColor.kColorAccent,
        ),
      ),
    );

    return Pinput(
      length: 6,
      controller: controller.pinController,
      focusNode: controller.focusNode,
      obscureText: true,
      obscuringWidget: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: controller.isError.value 
              ? AppColor.errorColor 
              : controller.isSuccess.value 
                  ? AppColor.successColor 
                  : AppColor.kColorAccent,
          shape: BoxShape.circle,
        ),
      ),
      useNativeKeyboard: false,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      onCompleted: (pin) => controller.verifyPin(pin),
    );
  }

  Widget _buildStatusMessage() {
    if (!controller.isError.value) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        'incorrect_pin'.tr,
        style: const TextStyle(color: AppColor.errorColor, fontSize: 12),
      ),
    );
  }

  Widget _buildKeyboard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          _buildKeyboardRow(['1', '2', '3']),
          const SizedBox(height: 20),
          _buildKeyboardRow(['4', '5', '6']),
          const SizedBox(height: 20),
          _buildKeyboardRow(['7', '8', '9']),
          const SizedBox(height: 20),
          _buildKeyboardRow([null, '0', 'backspace']),
        ],
      ),
    );
  }

  Widget _buildKeyboardRow(List<String?> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: keys.map((key) {
        if (key == null) return const SizedBox(width: 60);
        if (key == 'backspace') {
          return _buildKeyboardKey(
            child: const Icon(Icons.backspace_outlined, color: AppColor.kColorTextPrimary),
            onTap: () {
              if (controller.pinController.text.isNotEmpty) {
                controller.pinController.text = controller.pinController.text.substring(0, controller.pinController.text.length - 1);
              }
            },
          );
        }
        return _buildKeyboardKey(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                key,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColor.kColorTextPrimary),
              ),
              if (key != '0')
                Text(
                  _getSubText(key),
                  style: const TextStyle(fontSize: 10, color: AppColor.kColorTextSecondary),
                ),
            ],
          ),
          onTap: () {
            if (controller.pinController.text.length < 6) {
              controller.pinController.text += key;
              if (controller.pinController.text.length == 6) {
                controller.verifyPin(controller.pinController.text);
              }
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildKeyboardKey({required Widget child, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.cardBorderColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  String _getSubText(String key) {
    switch (key) {
      case '2': return 'ABC';
      case '3': return 'DEF';
      case '4': return 'GHI';
      case '5': return 'JKL';
      case '6': return 'MNO';
      case '7': return 'PQRS';
      case '8': return 'TUV';
      case '9': return 'WXYZ';
      default: return '';
    }
  }

  // Widget _buildBiometricsButton() {
  //   return TextButton.icon(
  //     onPressed: () {},
  //     icon: const Icon(Icons.fingerprint, size: 20, color: AppColor.kColorTextSecondary),
  //     label: Text(
  //       'use_biometrics'.tr,
  //       style: const TextStyle(color: AppColor.kColorTextSecondary),
  //     ),
  //   );
  // }

  Widget _buildSuccessButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          'opening_dashboard'.tr,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
