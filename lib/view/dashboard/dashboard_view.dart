import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color/app_color.dart';
import '../../view_models/controller/dashboard_controller.dart';
import '../home/home_view.dart';
import '../notifications/notifications_view.dart';
import '../settings/settings_view.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final controller = Get.put(DashboardController());

  final List<Widget> _screens = [
    const HomeView(),
    const NotificationsView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(_getTitle(controller.currentIndex.value).tr);
        }),
        backgroundColor: AppColor.kColorPrimary,
        foregroundColor: AppColor.whiteColor,
        centerTitle: true,
      ),
      body: Obx(() => _screens[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
          selectedItemColor: AppColor.kColorAccent,
          unselectedItemColor: AppColor.kColorTextSecondary,
          backgroundColor: AppColor.whiteColor,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications_outlined),
              activeIcon: const Icon(Icons.notifications),
              label: 'notifications'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings),
              label: 'settings'.tr,
            ),
          ],
        );
      }),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'home';
      case 1:
        return 'notifications';
      case 2:
        return 'settings';
      default:
        return 'app_name';
    }
  }
}
