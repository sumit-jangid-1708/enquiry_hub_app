class TourEnquiryResponseModel {
  final bool status;
  final int count;
  final List<TourEnquiryModel> data;

  TourEnquiryResponseModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory TourEnquiryResponseModel.fromJson(Map<String, dynamic> json) {
    return TourEnquiryResponseModel(
      status: json['status'] ?? false,
      count: json['count'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => TourEnquiryModel.fromJson(e))
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

class TourEnquiryModel {
  final int id;
  final String? enquiryId;
  final String? tourId;
  final String? tourName;
  final String? people;
  final String? selectedPlan;
  final String? totalPrice;
  final String? couponCode;
  final String? couponDiscount;
  final String name;
  final String email;
  final String? code;
  final String phone;
  final String? travelDate;
  final String? country;
  final String? city;
  final String? message;
  final DateTime createdAt;
  final DateTime updatedAt;

  TourEnquiryModel({
    required this.id,
    this.enquiryId,
    this.tourId,
    this.tourName,
    this.people,
    this.selectedPlan,
    this.totalPrice,
    this.couponCode,
    this.couponDiscount,
    required this.name,
    required this.email,
    this.code,
    required this.phone,
    this.travelDate,
    this.country,
    this.city,
    this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TourEnquiryModel.fromJson(Map<String, dynamic> json) {
    return TourEnquiryModel(
      id: json['id'] ?? 0,
      enquiryId: json['enquiry_id'],
      tourId: json['tour_id']?.toString(),
      tourName: json['tour_name'],
      people: json['people'],
      selectedPlan: json['selected_plan'],
      totalPrice: json['total_price'],
      couponCode: json['coupon_code'],
      couponDiscount: json['coupon_discount'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      code: json['code'],
      phone: json['phone'] ?? '',
      travelDate: json['travel_date'],
      country: json['country'],
      city: json['city'],
      message: json['message'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "enquiry_id": enquiryId,
      "tour_id": tourId,
      "tour_name": tourName,
      "people": people,
      "selected_plan": selectedPlan,
      "total_price": totalPrice,
      "coupon_code": couponCode,
      "coupon_discount": couponDiscount,
      "name": name,
      "email": email,
      "code": code,
      "phone": phone,
      "travel_date": travelDate,
      "country": country,
      "city": city,
      "message": message,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
