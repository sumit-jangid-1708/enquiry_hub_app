import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../res/color/app_color.dart';
import '../../view_models/controller/notification_controller.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: AppColor.kColorBackground,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColor.kColorPrimary,
        foregroundColor: AppColor.whiteColor,
        actions: [
          Obx(() => controller.notifications.isNotEmpty
              ? IconButton(
                  onPressed: () => _showClearDialog(context, controller),
                  icon: const Icon(Icons.delete_sweep_outlined),
                  tooltip: 'Clear All',
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications_off_outlined, size: 64, color: AppColor.kColorTextSecondary.withOpacity(0.5)),
                const SizedBox(height: 16),
                Text(
                  'No notifications yet',
                  style: TextStyle(color: AppColor.kColorTextSecondary, fontSize: 16),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              elevation: 0,
              color: AppColor.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColor.cardBorderColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColor.kColorTextPrimary,
                            ),
                          ),
                        ),
                        Text(
                          DateFormat('hh:mm a').format(notification.dateTime),
                          style: const TextStyle(fontSize: 12, color: AppColor.kColorTextSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification.body,
                      style: const TextStyle(fontSize: 14, color: AppColor.kColorTextSecondary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('dd MMM yyyy').format(notification.dateTime),
                      style: TextStyle(fontSize: 11, color: AppColor.kColorTextSecondary.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showClearDialog(BuildContext context, NotificationController controller) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 32),
              ),
              const SizedBox(height: 20),
              const Text(
                'Clear Notifications?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.kColorPrimary,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Are you sure you want to delete all notifications? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.kColorTextSecondary, fontSize: 14),
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
                      onPressed: () {
                        controller.clearAll();
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: AppColor.whiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Clear All',
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
}
