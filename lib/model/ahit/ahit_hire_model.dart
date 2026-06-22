class AhitHireResponseModel {
  final bool status;
  final int count;
  final List<AhitHireModel> data;

  AhitHireResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory AhitHireResponseModel.fromJson(Map<String, dynamic> json) {
    return AhitHireResponseModel(
      status: json['status'] ?? false,
      count: json['count'] is int
          ? json['count']
          : int.tryParse(json['count'].toString()) ?? 0,
      data: json['data'] != null
          ? List<AhitHireModel>.from(
        (json['data'] as List)
            .map((e) => AhitHireModel.fromJson(e)),
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

class AhitHireModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String code;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  AhitHireModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.code,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AhitHireModel.fromJson(Map<String, dynamic> json) {
    return AhitHireModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'code': code,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}