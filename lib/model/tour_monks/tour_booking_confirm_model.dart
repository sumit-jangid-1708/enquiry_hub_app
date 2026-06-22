import 'dart:convert';

class TourBookingConfirmResponseModel {
  final bool status;
  final int count;
  final List<TourBookingConfirmModel> data;

  TourBookingConfirmResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory TourBookingConfirmResponseModel.fromJson(Map<String, dynamic> json) {
    return TourBookingConfirmResponseModel(
      status: json['status'] ?? false,
      count: json['count'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => TourBookingConfirmModel.fromJson(e))
          .toList(),
    );
  }
}

class TourBookingConfirmModel {
  final int id;
  final String name;
  final String email;
  final String phoneNo;
  final String? tourPlanName;
  final String? totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  TourBookingConfirmModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
    this.tourPlanName,
    this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TourBookingConfirmModel.fromJson(Map<String, dynamic> json) {
    return TourBookingConfirmModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      tourPlanName: json['tour_plan_name'],
      totalPrice: json['total_price'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}
