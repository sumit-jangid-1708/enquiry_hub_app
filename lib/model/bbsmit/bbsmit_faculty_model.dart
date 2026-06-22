class BbsmitFacultyResponseModel {
  final bool status;
  final int count;
  final List<BbsmitFacultyModel> data;

  BbsmitFacultyResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory BbsmitFacultyResponseModel.fromJson(Map<String, dynamic> json) {
    return BbsmitFacultyResponseModel(
      status: json['status'] ?? false,
      count: json['count'] is int ? json['count'] : int.tryParse(json['count']?.toString() ?? '0') ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => BbsmitFacultyModel.fromJson(e))
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

class BbsmitFacultyModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String countryCode;
  final String education;
  final String cv;
  final String jobRole;
  final String countrysName;
  final String statesName;
  final String citiesName;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;

  BbsmitFacultyModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.education,
    required this.cv,
    required this.jobRole,
    required this.countrysName,
    required this.statesName,
    required this.citiesName,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BbsmitFacultyModel.fromJson(Map<String, dynamic> json) {
    return BbsmitFacultyModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      countryCode: json['country_code']?.toString() ?? '',
      education: json['education']?.toString() ?? '',
      cv: json['cv']?.toString() ?? '',
      jobRole: json['job_role']?.toString() ?? '',
      countrysName: json['countrys_name']?.toString() ?? '',
      statesName: json['states_name']?.toString() ?? '',
      citiesName: json['cities_name']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
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
      'country_code': countryCode,
      'education': education,
      'cv': cv,
      'job_role': jobRole,
      'countrys_name': countrysName,
      'states_name': statesName,
      'cities_name': citiesName,
      'address': address,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
