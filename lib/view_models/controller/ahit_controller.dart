import 'package:enquiry_hub/model/ahit/ahit_analysis_model.dart';
import 'package:enquiry_hub/model/ahit/ahit_contact_response_model.dart';
import 'package:enquiry_hub/model/ahit/ahit_hire_model.dart';
import 'package:enquiry_hub/model/ahit/ahit_quotation_model.dart';
import 'package:enquiry_hub/view_models/controller/base_controller.dart';
import 'package:enquiry_hub/view_models/service/local_services/ahit_services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AhitController extends GetxController with BaseController {
  final AhitServices _ahitServices = AhitServices();

  final isLoading = false.obs;
  final selectedFilterIndex = 0.obs;

  final List<String> filters = [
    'Contact',
    'Quotation',
    'Hire',
    'Analysis',
  ];

  final ahitContacts = <AhitContactModel>[].obs;
  final ahitQuotations = <AhitQuotationModel>[].obs;
  final ahitHires = <AhitHireModel>[].obs;
  final ahitAnalysis = <AhitAnalysisModel>[].obs;

  void setFilterIndex(int index) {
    selectedFilterIndex.value = index;
    _loadDataForFilter(index);
  }

  Future<void> _loadDataForFilter(int index) async {
    switch (index) {
      case 0: if (ahitContacts.isEmpty) await getAhitContacts(); break;
      case 1: if (ahitQuotations.isEmpty) await getAhitQuotations(); break;
      case 2: if (ahitHires.isEmpty) await getAhitHire(); break;
      case 3: if (ahitAnalysis.isEmpty) await getAhitAnalysis(); break;
    }
  }

  Future<void> refreshAllData() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      await _loadDataForFilter(selectedFilterIndex.value);
      
      Future.microtask(() async {
        for (int i = 0; i < filters.length; i++) {
          if (i == selectedFilterIndex.value) continue;
          await Future.delayed(const Duration(milliseconds: 800));
          await _loadDataForFilter(i);
        }
      });
    } catch (e) {
      debugPrint('❌ [AhitController.refreshAllData] Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAhitContacts() async {
    try {
      final data = await _ahitServices.getAhitContacts();
      ahitContacts.value = data;
    } catch (e) {
      if (selectedFilterIndex.value == 0) handleError(e);
    }
  }

  Future<void> getAhitQuotations() async {
    try {
      final data = await _ahitServices.getAhitQuotations();
      ahitQuotations.value = data;
    } catch (e) {
      if (selectedFilterIndex.value == 1) handleError(e);
    }
  }

  Future<void> getAhitHire() async {
    try {
      final data = await _ahitServices.getAhitHire();
      ahitHires.value = data;
    } catch (e) {
      if (selectedFilterIndex.value == 2) handleError(e);
    }
  }

  Future<void> getAhitAnalysis() async {
    try {
      final data = await _ahitServices.getAhitAnalysis();
      ahitAnalysis.value = data;
    } catch (e) {
      if (selectedFilterIndex.value == 3) handleError(e);
    }
  }
}
