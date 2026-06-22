class BbsmitEnrollmentResponseModel {
  final bool status;
  final int count;
  final List<BbsmitEnrollmentModel> data;

  BbsmitEnrollmentResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory BbsmitEnrollmentResponseModel.fromJson(Map<String, dynamic> json) {
    return BbsmitEnrollmentResponseModel(
      status: json['status'] ?? false,
      count: json['count'] is int ? json['count'] : int.tryParse(json['count']?.toString() ?? '0') ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => BbsmitEnrollmentModel.fromJson(e))
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

class BbsmitEnrollmentModel {
  final int id;
  final String name;
  final String email;
  final String number;
  final String subject;
  final String? courseId;
  final String? country;
  final String? image;
  final String? countrysName;
  final String? statesName;
  final String? citiesName;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  BbsmitEnrollmentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.number,
    required this.subject,
    this.courseId,
    this.country,
    this.image,
    this.countrysName,
    this.statesName,
    this.citiesName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BbsmitEnrollmentModel.fromJson(Map<String, dynamic> json) {
    return BbsmitEnrollmentModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      number: json['number']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      courseId: json['course_id']?.toString(),
      country: json['country']?.toString(),
      image: json['image']?.toString(),
      countrysName: json['countrys_name']?.toString(),
      statesName: json['states_name']?.toString(),
      citiesName: json['cities_name']?.toString(),
      status: json['status']?.toString() ?? '0',
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
      'subject': subject,
      'course_id': courseId,
      'country': country,
      'image': image,
      'countrys_name': countrysName,
      'states_name': statesName,
      'cities_name': citiesName,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  bool get isRead => status == "1";
  bool get isUnread => status == "0";
}
