class BbsmitRscitResponseModel {
  final bool status;
  final int count;
  final List<BbsmitRscitModel> data;

  BbsmitRscitResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory BbsmitRscitResponseModel.fromJson(Map<String, dynamic> json) {
    return BbsmitRscitResponseModel(
      status: json['status'] ?? false,
      count: json['count'] is int ? json['count'] : int.tryParse(json['count']?.toString() ?? '0') ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => BbsmitRscitModel.fromJson(e))
          .toList(),
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

class BbsmitRscitModel {
  final int id;
  final String name;
  final String email;
  final String? number;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  BbsmitRscitModel({
    required this.id,
    required this.name,
    required this.email,
    this.number,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BbsmitRscitModel.fromJson(Map<String, dynamic> json) {
    return BbsmitRscitModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      number: json['number']?.toString(),
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
      'number': number,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
