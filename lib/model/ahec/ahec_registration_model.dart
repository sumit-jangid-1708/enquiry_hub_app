class AhecRegistrationModel {
  final bool status;
  final AhecRegistrationData data;

  AhecRegistrationModel({
    required this.status,
    required this.data,
  });

  factory AhecRegistrationModel.fromJson(Map<String, dynamic> json) {
    return AhecRegistrationModel(
      status: json['status'] ?? false,
      data: AhecRegistrationData.fromJson(json['data'] ?? {}),
    );
  }
}

class AhecRegistrationData {
  final int currentPage;
  final List<AhecRegistrationUser> data;
  final String? firstPageUrl;
  final int from;
  final int lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  AhecRegistrationData({
    required this.currentPage,
    required this.data,
    this.firstPageUrl,
    required this.from,
    required this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory AhecRegistrationData.fromJson(Map<String, dynamic> json) {
    return AhecRegistrationData(
      currentPage: json['current_page'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => AhecRegistrationUser.fromJson(e))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: int.tryParse(json['per_page'].toString()) ?? 0,
      prevPageUrl: json['prev_page_url'],
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}

class AhecRegistrationUser {
  final int userId;
  final String? userName;
  final String? profile;
  final String? userEmail;
  final String? userPassword;
  final String? userStatus;
  final String? userCreatedAt;
  final String? rmId;
  final String? mobile;
  final String? phoneCode;
  final String? univercityName;
  final String? tokenId;
  final String? isMultipal;
  final String? isApproved;
  final String? rmIdsList;
  final String? chnagePasswordCount;
  final String? otp;

  AhecRegistrationUser({
    required this.userId,
    this.userName,
    this.profile,
    this.userEmail,
    this.userPassword,
    this.userStatus,
    this.userCreatedAt,
    this.rmId,
    this.mobile,
    this.phoneCode,
    this.univercityName,
    this.tokenId,
    this.isMultipal,
    this.isApproved,
    this.rmIdsList,
    this.chnagePasswordCount,
    this.otp,
  });

  factory AhecRegistrationUser.fromJson(Map<String, dynamic> json) {
    return AhecRegistrationUser(
      userId: json['user_id'] ?? 0,
      userName: json['user_name'],
      profile: json['profile'],
      userEmail: json['user_email'],
      userPassword: json['user_password'],
      userStatus: json['user_status']?.toString(),
      userCreatedAt: json['user_created_at'],
      rmId: json['rm_id']?.toString(),
      mobile: json['mobile'],
      phoneCode: json['phone_code'],
      univercityName: json['univercity_name'],
      tokenId: json['_token_id'],
      isMultipal: json['is_multipal']?.toString(),
      isApproved: json['is_approved']?.toString(),
      rmIdsList: json['rm_ids_list'],
      chnagePasswordCount:
      json['chnage_password_count']?.toString(),
      otp: json['otp'],
    );
  }
}