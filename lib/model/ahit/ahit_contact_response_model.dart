class AhitContactResponseModel {
  final bool status;
  final int count;
  final List<AhitContactModel> data;

  AhitContactResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory AhitContactResponseModel.fromJson(Map<String, dynamic> json) {
    return AhitContactResponseModel(
      status: json['status'] ?? false,
      count: json['count'] is int
          ? json['count']
          : int.tryParse(json['count'].toString()) ?? 0,
      data: json['data'] != null
          ? List<AhitContactModel>.from(
              (json['data'] as List).map((e) => AhitContactModel.fromJson(e)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'count': count,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class AhitContactModel {
  final int id;
  final String name;
  final String phone;
  final String? countryCode;
  final String? company;
  final String email;
  final String? message;
  final DateTime createdAt;
  final DateTime updatedAt;

  AhitContactModel({
    required this.id,
    required this.name,
    required this.phone,
    this.countryCode,
    this.company,
    required this.email,
    this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AhitContactModel.fromJson(Map<String, dynamic> json) {
    return AhitContactModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      countryCode: json['countryCode']?.toString(),
      company: json['company']?.toString(),
      email: json['email']?.toString() ?? '',
      message: json['message']?.toString(),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'countryCode': countryCode,
      'company': company,
      'email': email,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
