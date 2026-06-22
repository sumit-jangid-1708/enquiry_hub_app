class TourBookResponseModel {
  final bool status;
  final int count;
  final List<TourBookModel> data;

  TourBookResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory TourBookResponseModel.fromJson(Map<String, dynamic> json) {
    return TourBookResponseModel(
      status: json['status'] ?? false,
      count: json['count'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => TourBookModel.fromJson(e))
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

class TourBookModel {
  final int id;
  final String name;
  final String email;
  final String? code;
  final String phone;
  final String? tourName;
  final String? tourPlanName;
  final String? travelDate;
  final String? noPersons;
  final String? message;
  final String? bdAllowcationId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TourBookModel({
    required this.id,
    required this.name,
    required this.email,
    this.code,
    required this.phone,
    this.tourName,
    this.tourPlanName,
    this.travelDate,
    this.noPersons,
    this.message,
    this.bdAllowcationId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TourBookModel.fromJson(Map<String, dynamic> json) {
    return TourBookModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      code: json['code']?.toString(),
      phone: json['phone'] ?? '',
      tourName: json['tour_name'],
      tourPlanName: json['tour_plan_name'],
      travelDate: json['travel_date'],
      noPersons: json['no_persons'],
      message: json['message'],
      bdAllowcationId: json['bd_allowcation_id']?.toString(),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "code": code,
      "phone": phone,
      "tour_name": tourName,
      "tour_plan_name": tourPlanName,
      "travel_date": travelDate,
      "no_persons": noPersons,
      "message": message,
      "bd_allowcation_id": bdAllowcationId,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
