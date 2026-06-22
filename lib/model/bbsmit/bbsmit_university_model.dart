class BbsmitUniversityResponseModel {
  final bool status;
  final int count;
  final List<BbsmitUniversityModel> data;

  BbsmitUniversityResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory BbsmitUniversityResponseModel.fromJson(Map<String, dynamic> json) {
    return BbsmitUniversityResponseModel(
      status: json['status'] ?? false,
      count: json['count'] is int ? json['count'] : int.tryParse(json['count']?.toString() ?? '0') ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => BbsmitUniversityModel.fromJson(e))
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

class BbsmitUniversityModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String countryCode;
  final String markseet1;
  final String markseet2;
  final String markseet3;
  final String university;
  final String subject;
  final String course;
  final String scholarship;
  final String countrysName;
  final String statesName;
  final String citiesName;
  final String address;
  final String address1;
  final String? counsellingSlot;
  final String time;
  final String date;
  final String payment;
  final String? paymentScreenshort;
  final String? transactionId;
  final DateTime createdAt;
  final DateTime updatedAt;

  BbsmitUniversityModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.markseet1,
    required this.markseet2,
    required this.markseet3,
    required this.university,
    required this.subject,
    required this.course,
    required this.scholarship,
    required this.countrysName,
    required this.statesName,
    required this.citiesName,
    required this.address,
    required this.address1,
    this.counsellingSlot,
    required this.time,
    required this.date,
    required this.payment,
    this.paymentScreenshort,
    this.transactionId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BbsmitUniversityModel.fromJson(Map<String, dynamic> json) {
    return BbsmitUniversityModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      countryCode: json['country_code']?.toString() ?? '',
      markseet1: json['markseet_1']?.toString() ?? '',
      markseet2: json['markseet_2']?.toString() ?? '',
      markseet3: json['markseet_3']?.toString() ?? '',
      university: json['university']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      course: json['course']?.toString() ?? '',
      scholarship: json['scholarship']?.toString() ?? '',
      countrysName: json['countrys_name']?.toString() ?? '',
      statesName: json['states_name']?.toString() ?? '',
      citiesName: json['cities_name']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      address1: json['address_1']?.toString() ?? '',
      counsellingSlot: json['counselling_slot']?.toString(),
      time: json['time']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      payment: json['payment']?.toString() ?? '',
      paymentScreenshort: json['payment_screenshort']?.toString(),
      transactionId: json['transaction_id']?.toString(),
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
      'markseet_1': markseet1,
      'markseet_2': markseet2,
      'markseet_3': markseet3,
      'university': university,
      'subject': subject,
      'course': course,
      'scholarship': scholarship,
      'countrys_name': countrysName,
      'states_name': statesName,
      'cities_name': citiesName,
      'address': address,
      'address_1': address1,
      'counselling_slot': counsellingSlot,
      'time': time,
      'date': date,
      'payment': payment,
      'payment_screenshort': paymentScreenshort,
      'transaction_id': transactionId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
