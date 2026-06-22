import 'package:enquiry_hub/data/network/network_api_service.dart';
import 'package:enquiry_hub/model/tour_monks/tour_book_model.dart';
import 'package:enquiry_hub/model/tour_monks/tour_contact_model.dart';
import 'package:enquiry_hub/model/tour_monks/tour_customize_model.dart';
import 'package:enquiry_hub/model/tour_monks/tour_booking_confirm_model.dart';
import 'package:enquiry_hub/model/tour_monks/tour_enquiry_model.dart';
import 'package:enquiry_hub/res/app_url/app_url.dart';

class TourMonkService {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<TourContactModel>?> getTourContacts() async {
    final response = await _apiServices.getApi(AppUrl.tourmonksContact);
    final data = TourContactResponseModel.fromJson(response);
    return data.data;
  }

  Future<List<TourCustomizeData>?> getTourCustomize() async {
    final response = await _apiServices.getApi(AppUrl.tourmonksCustomize);
    final data = TourCustomizeModel.fromJson(response);
    return data.data;
  }

  Future<List<TourBookModel>?> getTourBook() async {
    final response = await _apiServices.getApi(AppUrl.tourmonksbook);
    final data = TourBookResponseModel.fromJson(response);
    return data.data;
  }

  Future<List<TourEnquiryModel>?> getTourEnquiry() async {
    final response = await _apiServices.getApi(AppUrl.tourmonksEnquiry);
    final data = TourEnquiryResponseModel.fromJson(response);
    return data.data;
  }

  Future<List<TourBookingConfirmModel>?> getTourBookingConfirm() async {
    final response = await _apiServices.getApi(AppUrl.tourmonksBookingConfirm);
    final data = TourBookingConfirmResponseModel.fromJson(response);
    return data.data;
  }
}
