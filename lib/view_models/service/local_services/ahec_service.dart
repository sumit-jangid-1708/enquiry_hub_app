import 'package:enquiry_hub/data/network/network_api_service.dart';
import 'package:enquiry_hub/res/app_url/app_url.dart';

class AhecService {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<Map<String, dynamic>> getAhecQuery(int pageNo) async {
    final response = await _apiServices.getApi(
      "${AppUrl.ahecQuery}?page=$pageNo",
    );
    return response;
  }

  Future<Map<String, dynamic>> getAhecRegistration(int pageNo) async {
    final response = await _apiServices.getApi(
      "${AppUrl.ahecRegistration}?page=$pageNo",
    );
    return response;
  }

  Future<Map<String, dynamic>> getAhecFlRegistration(int pageNo) async {
    final response = await _apiServices.getApi(
      "${AppUrl.ahecFlRegistration}?page=$pageNo",
    );
    return response;
  }

  Future<Map<String, dynamic>> getAhecAffiliate(int pageNo) async {
    final response = await _apiServices.getApi(
      "${AppUrl.ahecAffiliate}?page=$pageNo",
    );
    return response;
  }

  Future<Map<String, dynamic>> getAhecNewslatter(int pageNo) async {
    final response = await _apiServices.getApi(
      "${AppUrl.ahecNewsletter}?page=$pageNo",
    );
    return response;
  }
}
