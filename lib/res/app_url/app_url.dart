// lib/res/app_url/app_url.dart
class AppUrl {
  static const String baseUrl = 'https://www.bbsmituni.com/api';
  static const String baseUrl2 = 'https://www.ahitechno.com/api/ahit/notify';
  static const String baseUrl3 = 'https://www.tourmonks.com/api/tour/notify';
  static const String baseUrl4 = 'https://www.ahecounselling.com/api/ahec/notify';
  // FCM Token save karne ka endpoint - added trailing slash to fix 301 redirect
  static const String fcmToken = '$baseUrl/save-device-token';
  static const String bbsmitContact = '$baseUrl/notify/contact';
  static const String bbsmitEnquiry = '$baseUrl/notify/enquiry';
  static const String bbsmaitRscit = '$baseUrl/notify/rscit';
  static const String bbsmitEnrollment = '$baseUrl/notify/enrollment';
  static const String bbsmitFaculty = '$baseUrl/notify/faculty';
  static const String bbsmitUniversity = '$baseUrl/notify/university';

static const String ahitContact = '$baseUrl2/contact';
static const String ahitQuotation = '$baseUrl2/quotation';
static const String ahitHire = '$baseUrl2/hire';
static const String ahitAnalysis = '$baseUrl2/analysis';

static const String tourmonksContact = '$baseUrl3/contact';
static const String tourmonksCustomize = '$baseUrl3/customize';
static const String tourmonksbook = '$baseUrl3/book';
static const String tourmonksEnquiry = '$baseUrl3/tour-enquiry';
static const String tourmonksBookingConfirm = '$baseUrl3/booking-confirm';

static const String ahecQuery = '$baseUrl4/query';
static const String ahecRegistration = '$baseUrl4/registration';
static const String ahecFlRegistration = '$baseUrl4/fl-registration';
static const String ahecAffiliate = '$baseUrl4/affiliate';
static const String ahecNewsletter = '$baseUrl4/newsletter';
}