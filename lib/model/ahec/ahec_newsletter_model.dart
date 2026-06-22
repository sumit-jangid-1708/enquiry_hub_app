class AhecNewsletterModel {
  final bool? status;
  final NewsletterData? data;

  AhecNewsletterModel({
    this.status,
    this.data,
  });

  factory AhecNewsletterModel.fromJson(Map<String, dynamic> json) {
    return AhecNewsletterModel(
      status: json['status'],
      data: json['data'] != null
          ? NewsletterData.fromJson(json['data'])
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

class NewsletterData {
  final int? currentPage;
  final List<NewsletterItem>? data;
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

  NewsletterData({
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

  factory NewsletterData.fromJson(Map<String, dynamic> json) {
    return NewsletterData(
      currentPage: json['current_page'],
      data: json['data'] != null
          ? List<NewsletterItem>.from(
        json['data'].map((x) => NewsletterItem.fromJson(x)),
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

class NewsletterItem {
  final int? id;
  final String? qName;
  final String? qEmail;
  final String? qNumber;
  final String? qMessage;
  final String? createdAt;
  final String? updatedAt;

  NewsletterItem({
    this.id,
    this.qName,
    this.qEmail,
    this.qNumber,
    this.qMessage,
    this.createdAt,
    this.updatedAt,
  });

  factory NewsletterItem.fromJson(Map<String, dynamic> json) {
    return NewsletterItem(
      id: json['id'],
      qName: json['q_name'],
      qEmail: json['q_email'],
      qNumber: json['q_number'],
      qMessage: json['q_message'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'q_name': qName,
      'q_email': qEmail,
      'q_number': qNumber,
      'q_message': qMessage,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}