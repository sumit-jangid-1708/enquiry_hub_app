class AhitAnalysisResponseModel {
  final bool status;
  final int count;
  final List<AhitAnalysisModel> data;

  AhitAnalysisResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory AhitAnalysisResponseModel.fromJson(Map<String, dynamic> json) {
    return AhitAnalysisResponseModel(
      status: json['status'] ?? false,
      count: json['count'] is int
          ? json['count']
          : int.tryParse(json['count'].toString()) ?? 0,
      data: json['data'] != null
          ? List<AhitAnalysisModel>.from(
        (json['data'] as List)
            .map((e) => AhitAnalysisModel.fromJson(e)),
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

class AhitAnalysisModel {
  final int id;
  final String username;
  final String website;
  final String email;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  AhitAnalysisModel({
    required this.id,
    required this.username,
    required this.website,
    required this.email,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AhitAnalysisModel.fromJson(Map<String, dynamic> json) {
    return AhitAnalysisModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      username: json['username']?.toString() ?? '',
      website: json['website']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'website': website,
      'email': email,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}