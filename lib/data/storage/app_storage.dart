import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../model/notification_model.dart';

class AppStorage {
  static final GetStorage _storage = GetStorage();

  static const String fcmTokenKey = 'fcm_token';
  static const String notificationsKey = 'notifications';
  static const String authPinKey = 'auth_pin';

  /// Save FCM token to local storage
  static Future<void> saveFcmToken(String token) async {
    await _storage.write(fcmTokenKey, token);
  }

  /// Read FCM token from local storage
  static String? get fcmToken {
    return _storage.read(fcmTokenKey);
  }

  /// Remove FCM token from local storage
  static Future<void> removeFcmToken() async {
    await _storage.remove(fcmTokenKey);
  }

  /// Check if FCM token exists
  static bool get hasFcmToken {
    return _storage.hasData(fcmTokenKey);
  }

  /// Save notifications list
  static Future<void> saveNotifications(List<NotificationModel> notifications) async {
    List<String> data = notifications.map((e) => e.toJson()).toList();
    await _storage.write(notificationsKey, data);
  }

  /// Get notifications list
  static List<NotificationModel> getNotifications() {
    List<dynamic>? data = _storage.read(notificationsKey);
    if (data == null) return [];
    return data.map((e) => NotificationModel.fromJson(e.toString())).toList();
  }

  /// Add a single notification
  static Future<void> addNotification(NotificationModel notification) async {
    List<NotificationModel> current = getNotifications();
    current.insert(0, notification); // Add to top
    await saveNotifications(current);
  }

  /// Clear all notifications
  static Future<void> clearNotifications() async {
    await _storage.remove(notificationsKey);
  }

  /// Save Auth PIN
  static Future<void> savePin(String pin) async {
    await _storage.write(authPinKey, pin);
  }

  /// Get Auth PIN
  static String get pin {
    return _storage.read(authPinKey) ?? '000000';
  }
}
