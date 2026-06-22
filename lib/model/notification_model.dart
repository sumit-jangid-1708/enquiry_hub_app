import 'dart:convert';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime dateTime;
  final Map<String, dynamic>? data;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.dateTime,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'dateTime': dateTime.toIso8601String(),
      'data': data,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      dateTime: DateTime.tryParse(map['dateTime'] ?? '') ?? DateTime.now(),
      data: map['data'] != null ? Map<String, dynamic>.from(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source));
}
