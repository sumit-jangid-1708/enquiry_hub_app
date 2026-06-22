import 'package:enquiry_hub/data/network/network_api_service.dart';
import 'package:enquiry_hub/model/ahit/ahit_analysis_model.dart';
import 'package:enquiry_hub/model/ahit/ahit_hire_model.dart';

import '../../../model/ahit/ahit_contact_response_model.dart';
import '../../../model/ahit/ahit_quotation_model.dart';
import '../../../res/app_url/app_url.dart';

class AhitServices {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<AhitContactModel>> getAhitContacts() async {
    final response = await _apiServices.getApi(AppUrl.ahitContact);
    final data = AhitContactResponseModel.fromJson(response);
    return data.data;
  }

  Future<List<AhitQuotationModel>> getAhitQuotations() async {
    final response = await _apiServices.getApi(AppUrl.ahitQuotation);
    final data = AhitQuotationResponseModel.fromJson(response);
    return data.data;
  }

  Future<List<AhitHireModel>> getAhitHire() async {
    final response = await _apiServices.getApi(AppUrl.ahitHire);
    final data = AhitHireResponseModel.fromJson(response);
    return data.data;
  }

  Future<List<AhitAnalysisModel>> getAhitAnalysis() async {
    final response = await _apiServices.getApi(AppUrl.ahitAnalysis);
    final data = AhitAnalysisResponseModel.fromJson(response);
    return data.data;
  }
}
