class AhecAffiliateModel {
  final bool? status;
  final AffiliateData? data;

  AhecAffiliateModel({
    this.status,
    this.data,
  });

  factory AhecAffiliateModel.fromJson(Map<String, dynamic> json) {
    return AhecAffiliateModel(
      status: json['status'],
      data: json['data'] != null
          ? AffiliateData.fromJson(json['data'])
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

class AffiliateData {
  final int? currentPage;
  final List<AffiliateItem>? data;
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

  AffiliateData({
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

  factory AffiliateData.fromJson(Map<String, dynamic> json) {
    return AffiliateData(
      currentPage: json['current_page'],
      data: json['data'] != null
          ? List<AffiliateItem>.from(
        json['data'].map((x) => AffiliateItem.fromJson(x)),
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

class AffiliateItem {
  final int? afId;
  final String? afName;
  final String? afEmail;
  final String? afMobile;
  final String? afAddress;
  final String? afFile;
  final String? afCrateedAt;
  final String? folderPath;
  final String? countryCode;

  AffiliateItem({
    this.afId,
    this.afName,
    this.afEmail,
    this.afMobile,
    this.afAddress,
    this.afFile,
    this.afCrateedAt,
    this.folderPath,
    this.countryCode,
  });

  factory AffiliateItem.fromJson(Map<String, dynamic> json) {
    return AffiliateItem(
      afId: json['af_id'],
      afName: json['af_name'],
      afEmail: json['af_email'],
      afMobile: json['af_mobile'],
      afAddress: json['af_address'],
      afFile: json['af_file'],
      afCrateedAt: json['af_crateed_at'],
      folderPath: json['folder_path'],
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
      'af_crateed_at': afCrateedAt,
      'folder_path': folderPath,
      'country_code': countryCode,
    };
  }
}