class AhecFlRegistrationModel {
  final bool? status;
  final FlRegistrationData? data;

  AhecFlRegistrationModel({
    this.status,
    this.data,
  });

  factory AhecFlRegistrationModel.fromJson(Map<String, dynamic> json) {
    return AhecFlRegistrationModel(
      status: json['status'],
      data: json['data'] != null
          ? FlRegistrationData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class FlRegistrationData {
  final int? currentPage;
  final List<FlRegistrationItem>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  FlRegistrationData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory FlRegistrationData.fromJson(Map<String, dynamic> json) {
    return FlRegistrationData(
      currentPage: json['current_page'],
      data: json['data'] != null
          ? List<FlRegistrationItem>.from(
        json['data'].map((x) => FlRegistrationItem.fromJson(x)),
      )
          : [],
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data?.map((e) => e.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

class FlRegistrationItem {
  final int? afId;
  final String? afName;
  final String? afEmail;
  final String? afMobile;
  final String? afAddress;
  final String? afFile;
  final String? bankName;
  final String? bankNo;
  final String? bankIfsc;
  final String? bankBranch;
  final String? afCrateedAt;
  final String? aadharNumber;
  final String? panNumber;
  final String? flAlternateNumber;
  final String? doc2;
  final String? countryCode;

  FlRegistrationItem({
    this.afId,
    this.afName,
    this.afEmail,
    this.afMobile,
    this.afAddress,
    this.afFile,
    this.bankName,
    this.bankNo,
    this.bankIfsc,
    this.bankBranch,
    this.afCrateedAt,
    this.aadharNumber,
    this.panNumber,
    this.flAlternateNumber,
    this.doc2,
    this.countryCode,
  });

  factory FlRegistrationItem.fromJson(Map<String, dynamic> json) {
    return FlRegistrationItem(
      afId: json['af_id'],
      afName: json['af_name'],
      afEmail: json['af_email'],
      afMobile: json['af_mobile'],
      afAddress: json['af_address'],
      afFile: json['af_file'],
      bankName: json['bank_name'],
      bankNo: json['bank_no'],
      bankIfsc: json['bank_ifsc'],
      bankBranch: json['bank_branch'],
      afCrateedAt: json['af_crateed_at'],
      aadharNumber: json['aadhar_number'],
      panNumber: json['pan_number'],
      flAlternateNumber: json['fl_alternate_number'],
      doc2: json['doc_2'],
      countryCode: json['country_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'af_id': afId,
      'af_name': afName,
      'af_email': afEmail,
      'af_mobile': afMobile,
      'af_address': afAddress,
      'af_file': afFile,
      'bank_name': bankName,
      'bank_no': bankNo,
      'bank_ifsc': bankIfsc,
      'bank_branch': bankBranch,
      'af_crateed_at': afCrateedAt,
      'aadhar_number': aadharNumber,
      'pan_number': panNumber,
      'fl_alternate_number': flAlternateNumber,
      'doc_2': doc2,
      'country_code': countryCode,
    };
  }
}