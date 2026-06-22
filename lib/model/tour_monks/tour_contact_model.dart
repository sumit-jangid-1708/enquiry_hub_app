class TourContactResponseModel {
  final bool status;
  final int count;
  final List<TourContactModel> data;

  TourContactResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory TourContactResponseModel.fromJson(Map<String, dynamic> json) {
    return TourContactResponseModel(
      status: json['status'] ?? false,
      count: json['count'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => TourContactModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "count": count,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class TourContactModel {
  final int id;
  final String name;
  final String email;
  final String? code;
  final String phone;
  final String? preferredDate;
  final String? groupSize;
  final String? destination;
  final String? subject;
  final String? message;
  final DateTime createdAt;
  final DateTime updatedAt;

  TourContactModel({
    required this.id,
    required this.name,
    required this.email,
    this.code,
    required this.phone,
    this.preferredDate,
    this.groupSize,
    this.destination,
    this.subject,
    this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TourContactModel.fromJson(Map<String, dynamic> json) {
    return TourContactModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      code: json['code']?.toString(),
      phone: json['phone']?.toString() ?? '',
      preferredDate: json['preferred_date']?.toString(),
      groupSize: json['group_size']?.toString(),
      destination: json['destination']?.toString(),
      subject: json['subject']?.toString(),
      message: json['message']?.toString(),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "code": code,
      "phone": phone,
      "preferred_date": preferredDate,
      "group_size": groupSize,
      "destination": destination,
      "subject": subject,
      "message": message,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
