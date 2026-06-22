class AhecQueryModel {
  final bool status;
  final int count;
  final int totalRecord;
  final int currentPage;
  final int lastPage;
  final List<AhecQueryData> data;

  AhecQueryModel({
    required this.status,
    required this.count,
    required this.totalRecord,
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });

  factory AhecQueryModel.fromJson(Map<String, dynamic> json) {
    return AhecQueryModel(
      status: json['status'] ?? false,
      count: json['count'] ?? 0,
      totalRecord: json['total_record'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => AhecQueryData.fromJson(e))
          .toList(),
    );
  }
}

class AhecQueryData {
  final int enId;
  final String? enFirstName;
  final String? enLastName;
  final String? enEmail;
  final String? phoneCode;
  final String? enMobile;
  final String? enService;
  final String? enSubject;
  final String? enSubjectName;
  final String? enUniversityName;
  final String? enStream;
  final String? enWordcount;
  final String? enPrice;
  final String? enQuery;
  final String? enAttachment;
  final String? enAttachment2;
  final String? enAttachment3;
  final String? enCreatedAt;
  final String? screenshot;
  final String? rmId;
  final String? userType;
  final String? orderType;
  final String? orderNumber;
  final String? paymentType;
  final String? emailStatus;
  final String? moduleName;
  final String? deadline;
  final String? paymentTime;
  final String? wordCount;
  final String? tranxid;
  final String? assignmentType;
  final String? currencyType;
  final String? clientAmount;
  final String? inrAmount;
  final String? audAmount;
  final String? univercityName;
  final String? workAllocation;
  final String? transactionId;

  AhecQueryData({
    required this.enId,
    this.enFirstName,
    this.enLastName,
    this.enEmail,
    this.phoneCode,
    this.enMobile,
    this.enService,
    this.enSubject,
    this.enSubjectName,
    this.enUniversityName,
    this.enStream,
    this.enWordcount,
    this.enPrice,
    this.enQuery,
    this.enAttachment,
    this.enAttachment2,
    this.enAttachment3,
    this.enCreatedAt,
    this.screenshot,
    this.rmId,
    this.userType,
    this.orderType,
    this.orderNumber,
    this.paymentType,
    this.emailStatus,
    this.moduleName,
    this.deadline,
    this.paymentTime,
    this.wordCount,
    this.tranxid,
    this.assignmentType,
    this.currencyType,
    this.clientAmount,
    this.inrAmount,
    this.audAmount,
    this.univercityName,
    this.workAllocation,
    this.transactionId,
  });

  factory AhecQueryData.fromJson(Map<String, dynamic> json) {
    return AhecQueryData(
      enId: json['en_id'] ?? 0,
      enFirstName: json['en_first_name'],
      enLastName: json['en_last_name'],
      enEmail: json['en_email'],
      phoneCode: json['phone_code'],
      enMobile: json['en_mobile'],
      enService: json['en_service']?.toString(),
      enSubject: json['en_subject'],
      enSubjectName: json['en_subject_name'],
      enUniversityName: json['en_university_name'],
      enStream: json['en_stream'],
      enWordcount: json['en_wordcount']?.toString(),
      enPrice: json['en_price']?.toString(),
      enQuery: json['en_query'],
      enAttachment: json['en_attachment'],
      enAttachment2: json['en_attachment_2']?.toString(),
      enAttachment3: json['en_attachment_3']?.toString(),
      enCreatedAt: json['en_created_at'],
      screenshot: json['Screenshot'],
      rmId: json['rm_id']?.toString(),
      userType: json['user_type']?.toString(),
      orderType: json['order_type']?.toString(),
      orderNumber: json['order_number']?.toString(),
      paymentType: json['payment_type'],
      emailStatus: json['email_status']?.toString(),
      moduleName: json['module_name'],
      deadline: json['deadline'],
      paymentTime: json['payment_time']?.toString(),
      wordCount: json['word_count']?.toString(),
      tranxid: json['tranxid'],
      assignmentType: json['assignment_type'],
      currencyType: json['currency_type']?.toString(),
      clientAmount: json['client_amount']?.toString(),
      inrAmount: json['inr_amount']?.toString(),
      audAmount: json['aud_amount']?.toString(),
      univercityName: json['univercity_name'],
      workAllocation: json['work_allocation']?.toString(),
      transactionId: json['transaction_id'],
    );
  }

  String get fullName =>
      "${enFirstName ?? ''} ${enLastName ?? ''}".trim();
}