// lib/view_models/service/other_services/notification_services.dart

import 'dart:convert';
import 'package:enquiry_hub/res/routes/routes_names.dart';
import 'package:enquiry_hub/view_models/controller/ahit_controller.dart';
import 'package:enquiry_hub/view_models/controller/bbsmit_controller.dart';
import 'package:enquiry_hub/view_models/controller/dashboard_controller.dart';
import 'package:enquiry_hub/view_models/controller/home_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../firebase_options.dart';
import 'fcm_service.dart';
import '../../../data/storage/app_storage.dart';
import '../../../model/notification_model.dart';
import '../../controller/notification_controller.dart';

// Import Models for detail navigation
import '../../../model/bbsmit/bbsmit_contact_model.dart';
import '../../../model/bbsmit/bbsmit_enquiry_model.dart';
import '../../../model/bbsmit/bbsmit_rscit_model.dart';
import '../../../model/bbsmit/bbsmit_enrollment_model.dart';
import '../../../model/bbsmit/bbsmit_faculty_model.dart';
import '../../../model/bbsmit/bbsmit_university_model.dart';
import '../../../model/ahit/ahit_contact_response_model.dart';
import '../../../model/ahit/ahit_quotation_model.dart';
import '../../../model/ahit/ahit_hire_model.dart';
import '../../../model/ahit/ahit_analysis_model.dart';
import '../../../model/tour_monks/tour_contact_model.dart';
import '../../../model/tour_monks/tour_customize_model.dart';
import '../../../model/tour_monks/tour_book_model.dart';
import '../../../model/tour_monks/tour_enquiry_model.dart';
import '../../../model/tour_monks/tour_booking_confirm_model.dart';
import '../../../model/ahec/ahec_registration_model.dart';
import '../../../model/ahec/ahec_fl_registration_model.dart';
import '../../../model/ahec/ahec_affiliate_model.dart';
import '../../../model/ahec/ahec_newsletter_model.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FcmService _fcmService = FcmService();

  static late AndroidNotificationChannel channel;
  static bool _isInitialized = false;

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await _setupLocalNotifications();
    await _saveNotification(message);
    _showFlutterNotification(message);
  }

  static Future<void> initializeNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await _setupLocalNotifications();
    await _subscribeToTopics();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _saveNotification(message);
      _showFlutterNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(jsonEncode(message.data));
    });

    RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(jsonEncode(initialMessage.data));
    }

    await _getFcmToken();
    _listenTokenRefresh();
  }

  static Future<void> _subscribeToTopics() async {
    try {
      await _firebaseMessaging.subscribeToTopic('bbsmit');
      await _firebaseMessaging.subscribeToTopic('ahitechno');
      await _firebaseMessaging.subscribeToTopic('tourmonks');
      await _firebaseMessaging.subscribeToTopic('ahecounselling');
    } catch (e) {
      debugPrint('❌ Topic subscription error: $e');
    }
  }

  static Future<void> _setupLocalNotifications() async {
    if (_isInitialized) return;

    channel = const AndroidNotificationChannel(
      'CHANNEL_ID',
      'High Importance Notifications',
      importance: Importance.max,
    );

    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

    await flutterLocalNotificationsPlugin.initialize(
      settings: const InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleNotificationTap(response.payload);
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    _isInitialized = true;
  }

  static Future<void> _saveNotification(RemoteMessage message) async {
    final notification = NotificationModel(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title:
          message.notification?.title ??
          message.data['title'] ??
          'New Notification',
      body: message.notification?.body ?? message.data['body'] ?? '',
      dateTime: DateTime.now(),
      data: message.data,
    );
    await AppStorage.addNotification(notification);
    if (Get.isRegistered<NotificationController>()) {
      Get.find<NotificationController>().loadNotifications();
    }
  }

  static void _showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  static Future<void> _getFcmToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) await _sendTokenToServer(token);
    } catch (e) {
      debugPrint('❌ FCM Token error: $e');
    }
  }

  static void _listenTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen(
      (token) => _sendTokenToServer(token, forceUpdate: true),
    );
  }

  static Future<void> _sendTokenToServer(
    String newToken, {
    bool forceUpdate = false,
  }) async {
    if (forceUpdate || AppStorage.fcmToken != newToken) {
      final response = await _fcmService.sendFcmToken(newToken);
      if (response['success'] == true) await AppStorage.saveFcmToken(newToken);
    }
  }

  static void _handleNotificationTap(String? payload) {
    if (payload == null) return;
    debugPrint("🔔 Notification tapped: $payload");

    try {
      final Map<String, dynamic> data = jsonDecode(payload);

      String venture = (data['venture'] ?? '').toString().toLowerCase();
      String type = (data['type'] ?? '').toString();
      dynamic recordData = data['record'];

      // 1. If we have specific record data, navigate to Detail View
      if (recordData != null) {
        if (recordData is String) recordData = jsonDecode(recordData);

        if (venture == 'bbsmit') {
          _navigateToBbsmitDetail(type, recordData);
          return;
        } else if (venture == 'ahit') {
          _navigateToAhitDetail(type, recordData);
          return;
        } else if (venture == 'tourmonks') {
          _navigateToTourDetail(type, recordData);
          return;
        } else if (venture == 'ahecounselling') {
          _navigateToAhecDetail(type, recordData);
          return;
        }
      }

      // 2. Fallback: Navigate to Home Tab and set Filter
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().changeIndex(0);
      }

      if (venture.isNotEmpty) {
        if (Get.isRegistered<HomeController>()) {
          final homeController = Get.find<HomeController>();
          if (venture == 'ahit')
            homeController.selectedVentureIndex.value = 1;
          else if (venture == 'bbsmit')
            homeController.selectedVentureIndex.value = 2;
          else if (venture == 'tourmonks')
            homeController.selectedVentureIndex.value = 3;
          else if (venture == 'ahecounselling')
            homeController.selectedVentureIndex.value = 4;
        }
        if (type.isNotEmpty) {
          _setFilterIndex(venture, type);
        }
      }
    } catch (e) {
      debugPrint("Error handling notification tap: $e");
    }
  }

  static void _navigateToBbsmitDetail(String type, Map<String, dynamic> data) {
    dynamic model;
    String typeLabel = type;

    if (type.toLowerCase().contains('contact')) {
      model = BbsmitContactModel.fromJson(data);
      typeLabel = 'Contact';
    } else if (type.toLowerCase().contains('enquiry')) {
      model = BbsmitEnquiryModel.fromJson(data);
      typeLabel = 'Enquiry';
    } else if (type.toLowerCase().contains('rscit')) {
      model = BbsmitRscitModel.fromJson(data);
      typeLabel = 'RSCIT';
    } else if (type.toLowerCase().contains('enrollment')) {
      model = BbsmitEnrollmentModel.fromJson(data);
      typeLabel = 'Enrollment';
    } else if (type.toLowerCase().contains('faculty')) {
      model = BbsmitFacultyModel.fromJson(data);
      typeLabel = 'Faculty';
    } else if (type.toLowerCase().contains('university')) {
      model = BbsmitUniversityModel.fromJson(data);
      typeLabel = 'University';
    }

    if (model != null) {
      Get.toNamed(
        RouteName.bbsmitDetailView,
        arguments: {'type': typeLabel, 'data': model},
      );
    }
  }

  static void _navigateToAhitDetail(String type, Map<String, dynamic> data) {
    dynamic model;
    String typeLabel = type;

    if (type.toLowerCase().contains('contact')) {
      model = AhitContactModel.fromJson(data);
      typeLabel = 'Contact';
    } else if (type.toLowerCase().contains('quotation')) {
      model = AhitQuotationModel.fromJson(data);
      typeLabel = 'Quotation';
    } else if (type.toLowerCase().contains('hire')) {
      model = AhitHireModel.fromJson(data);
      typeLabel = 'Hire';
    } else if (type.toLowerCase().contains('analysis')) {
      model = AhitAnalysisModel.fromJson(data);
      typeLabel = 'Analysis';
    }

    if (model != null) {
      Get.toNamed(
        RouteName.ahitDetailView,
        arguments: {'type': typeLabel, 'data': model},
      );
    }
  }

  static void _navigateToTourDetail(String type, Map<String, dynamic> data) {
    dynamic model;
    String typeLabel = type;

    if (type.toLowerCase().contains('contact')) {
      model = TourContactModel.fromJson(data);
      typeLabel = 'Contact';
    } else if (type.toLowerCase().contains('customize')) {
      model = TourCustomizeData.fromJson(data);
      typeLabel = 'Customize';
    } else if (type.toLowerCase().contains('book')) {
      model = TourBookModel.fromJson(data);
      typeLabel = 'Book';
    } else if (type.toLowerCase().contains('enquiry')) {
      model = TourEnquiryModel.fromJson(data);
      typeLabel = 'Enquiry';
    } else if (type.toLowerCase().contains('confirm')) {
      model = TourBookingConfirmModel.fromJson(data);
      typeLabel = 'Confirm';
    }

    if (model != null) {
      Get.toNamed(
        RouteName.tourDetailView,
        arguments: {'type': typeLabel, 'data': model},
      );
    }
  }

  static void _navigateToAhecDetail(String type, Map<String, dynamic> data) {
    dynamic model;
    String typeLabel = type;

    if (type.toLowerCase().contains('registration')) {
      if (type.toLowerCase().contains('fl')) {
        model = FlRegistrationItem.fromJson(data);
        typeLabel = 'FL Registration';
      } else {
        model = AhecRegistrationUser.fromJson(data);
        typeLabel = 'Registration';
      }
    } else if (type.toLowerCase().contains('affiliate')) {
      model = AhecAffiliateModel.fromJson(data);
      typeLabel = 'Affiliate';
    } else if (type.toLowerCase().contains('newsletter')) {
      model = AhecNewsletterModel.fromJson(data);
      typeLabel = 'Newsletter';
    }

    if (model != null) {
      Get.toNamed(
        RouteName.ahecDetailView,
        arguments: {'type': typeLabel, 'data': model},
      );
    }
  }

  static void _setFilterIndex(String venture, String type) {
    type = type.toLowerCase();
    if (venture == 'ahit' && Get.isRegistered<AhitController>()) {
      final controller = Get.find<AhitController>();
      if (type.contains('contact')) {
        controller.setFilterIndex(0);
      } else if (type.contains('quotation'))
        controller.setFilterIndex(1);
      else if (type.contains('hire'))
        controller.setFilterIndex(2);
      else if (type.contains('analysis'))
        controller.setFilterIndex(3);
    } else if (venture == 'bbsmit' && Get.isRegistered<BbsmitController>()) {
      final controller = Get.find<BbsmitController>();
      if (type.contains('contact')) {
        controller.setFilterIndex(0);
      } else if (type.contains('enquiry'))
        controller.setFilterIndex(1);
      else if (type.contains('rscit'))
        controller.setFilterIndex(2);
      else if (type.contains('enrollment'))
        controller.setFilterIndex(3);
      else if (type.contains('faculty'))
        controller.setFilterIndex(4);
      else if (type.contains('university'))
        controller.setFilterIndex(5);
    }
  }
}
