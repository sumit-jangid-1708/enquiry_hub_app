class AhitQuotationResponseModel {
  final bool status;
  final int count;
  final List<AhitQuotationModel> data;

  AhitQuotationResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory AhitQuotationResponseModel.fromJson(
      Map<String, dynamic> json) {
    return AhitQuotationResponseModel(
      status: json['status'] ?? false,
      count: json['count'] is int
          ? json['count']
          : int.tryParse(json['count'].toString()) ?? 0,
      data: json['data'] != null
          ? List<AhitQuotationModel>.from(
        (json['data'] as List)
            .map((e) => AhitQuotationModel.fromJson(e)),
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

class AhitQuotationModel {
  final int id;
  final String fname;
  final String lname;
  final String email;
  final String code;
  final String phone;
  final String service;
  final String? priority;
  final String mainservice;
  final String webAddress;
  final String? duration;
  final String? endduration;
  final String description;
  final String? image;
  final String? totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? servicePrice;
  final String? priorityPrice;

  AhitQuotationModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.code,
    required this.phone,
    required this.service,
    this.priority,
    required this.mainservice,
    required this.webAddress,
    this.duration,
    this.endduration,
    required this.description,
    this.image,
    this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    this.servicePrice,
    this.priorityPrice,
  });

  factory AhitQuotationModel.fromJson(
      Map<String, dynamic> json) {
    return AhitQuotationModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      fname: json['fname']?.toString() ?? '',
      lname: json['lname']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      service: json['service']?.toString() ?? '',
      priority: json['priority']?.toString(),
      mainservice: json['mainservice']?.toString() ?? '',
      webAddress: json['web_address']?.toString() ?? '',
      duration: json['duration']?.toString(),
      endduration: json['endduration']?.toString(),
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString(),
      totalPrice: json['total_price']?.toString(),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ?? DateTime.now(),
      servicePrice: json['service_price']?.toString(),
      priorityPrice: json['priority_price']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'email': email,
      'code': code,
      'phone': phone,
      'service': service,
      'priority': priority,
      'mainservice': mainservice,
      'web_address': webAddress,
      'duration': duration,
      'endduration': endduration,
      'description': description,
      'image': image,
      'total_price': totalPrice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'service_price': servicePrice,
      'priority_price': priorityPrice,
    };
  }
}