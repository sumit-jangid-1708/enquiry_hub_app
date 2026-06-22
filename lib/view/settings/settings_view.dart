import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color/app_color.dart';
import '../../view_models/controller/settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: AppColor.kColorBackground,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          // Notifications Toggle
          Obx(() => ListTile(
                leading: const Icon(Icons.notifications_outlined, color: AppColor.kColorPrimary),
                title: const Text(
                  'Notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.kColorTextPrimary,
                  ),
                ),
                trailing: Switch.adaptive(
                  value: controller.isNotificationEnabled.value,
                  activeColor: AppColor.kColorAccent,
                  onChanged: (value) => controller.toggleNotifications(value),
                ),
              )),
          
          const Divider(height: 1, indent: 20, endIndent: 20, color: AppColor.dividerColor),

          // Change PIN
          ListTile(
            leading: const Icon(Icons.lock_outline, color: AppColor.kColorPrimary),
            title: const Text(
              'Change Auth PIN',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.kColorTextPrimary,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.kColorTextSecondary),
            onTap: () => _showChangePinDialog(context, controller),
          ),

          const Divider(height: 1, indent: 20, endIndent: 20, color: AppColor.dividerColor),

          // About App
          ListTile(
            leading: const Icon(Icons.info_outline, color: AppColor.kColorPrimary),
            title: const Text(
              'About App',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.kColorTextPrimary,
              ),
            ),
            onTap: () {
              // Handle About App tap
            },
          ),

          const Divider(height: 1, indent: 20, endIndent: 20, color: AppColor.dividerColor),

          // Version
          ListTile(
            leading: const Icon(Icons.phone_android_outlined, color: AppColor.kColorPrimary),
            title: const Text(
              'Version',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.kColorTextPrimary,
              ),
            ),
            subtitle: const Text(
              '1.0.0',
              style: TextStyle(color: AppColor.kColorTextSecondary),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePinDialog(BuildContext context, SettingsController controller) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change Auth PIN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.kColorPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please enter your current and new 6-digit PIN.',
                style: TextStyle(color: AppColor.kColorTextSecondary, fontSize: 14),
              ),
              const SizedBox(height: 24),
              _buildPinTextField(
                controller: controller.oldPinController,
                label: 'Old PIN',
                icon: Icons.lock_open_rounded,
              ),
              const SizedBox(height: 16),
              _buildPinTextField(
                controller: controller.newPinController,
                label: 'New PIN',
                icon: Icons.lock_outline_rounded,
              ),
              const SizedBox(height: 16),
              _buildPinTextField(
                controller: controller.confirmPinController,
                label: 'Confirm New PIN',
                icon: Icons.check_circle_outline_rounded,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: AppColor.cardBorderColor),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: AppColor.kColorTextSecondary, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => controller.changePin(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.kColorPrimary,
                        foregroundColor: AppColor.whiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Update PIN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColor.kColorTextSecondary,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 6,
          decoration: InputDecoration(
            counterText: "",
            prefixIcon: Icon(icon, size: 20, color: AppColor.kColorPrimary.withOpacity(0.6)),
            hintText: '● ● ● ● ● ●',
            hintStyle: TextStyle(color: AppColor.kColorTextSecondary.withOpacity(0.3), letterSpacing: 2),
            filled: true,
            fillColor: AppColor.kColorBackground,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.kColorPrimary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
