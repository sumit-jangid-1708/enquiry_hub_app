import 'package:get/get.dart';
import '../../data/storage/app_storage.dart';
import '../../model/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.value = AppStorage.getNotifications();
  }

  void clearAll() async {
    await AppStorage.clearNotifications();
    notifications.clear();
  }

  void addNotification(NotificationModel notification) async {
    await AppStorage.addNotification(notification);
    notifications.insert(0, notification);
  }
}
