class TourCustomizeModel {
  final bool status;
  final int count;
  final List<TourCustomizeData> data;

  TourCustomizeModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory TourCustomizeModel.fromJson(Map<String, dynamic> json) {
    return TourCustomizeModel(
      status: json['status'] ?? false,
      count: json['count'] ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => TourCustomizeData.fromJson(e))
          .toList(),
    );
  }
}

class TourCustomizeData {
  final int id;
  final String name;
  final String email;
  final String destination;
  final String date;
  final String adultsNum;
  final String childrenNum;
  final String country;
  final String? code;
  final String phone;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  TourCustomizeData({
    required this.id,
    required this.name,
    required this.email,
    required this.destination,
    required this.date,
    required this.adultsNum,
    required this.childrenNum,
    required this.country,
    this.code,
    required this.phone,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TourCustomizeData.fromJson(Map<String, dynamic> json) {
    return TourCustomizeData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      destination: json['destination'] ?? '',
      date: json['date'] ?? '',
      adultsNum: json['adults_num'] ?? '',
      childrenNum: json['children_num'] ?? '',
      country: json['country'] ?? '',
      code: json['code'],
      phone: json['phone'] ?? '',
      message: json['message'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'destination': destination,
      'date': date,
      'adults_num': adultsNum,
      'children_num': childrenNum,
      'country': country,
      'code': code,
      'phone': phone,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}