import 'package:enquiry_hub/data/network/network_api_service.dart';
import 'package:enquiry_hub/res/app_url/app_url.dart';

class BbsmitServices {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<Map<String, dynamic>> getBbsmitContact() async{
    final response = await _apiServices.getApi(AppUrl.bbsmitContact);
    return response;
  }

  Future<Map<String, dynamic>> getBbsmitEnquiry() async{
    final response = await _apiServices.getApi(AppUrl.bbsmitEnquiry);
    return response;
  }

  Future<Map<String, dynamic>> getBbsmitRscit() async{
    final response = await _apiServices.getApi(AppUrl.bbsmaitRscit);
    return response;
  }

  Future<Map<String, dynamic>> getBbsmitEnrollment() async{
    final response = await _apiServices.getApi(AppUrl.bbsmitEnrollment);
    return response;
  }

  Future<Map<String, dynamic>> getBbsmitFaculty() async{
    final response = await _apiServices.getApi(AppUrl.bbsmitFaculty);
    return response;
  }

  Future<Map<String, dynamic>> getBbsmitUniversity() async{
    final response = await _apiServices.getApi(AppUrl.bbsmitUniversity);
    return response;
  }

}

