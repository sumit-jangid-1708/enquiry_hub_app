import 'package:enquiry_hub/model/bbsmit/bbsmit_contact_model.dart';
import 'package:enquiry_hub/model/bbsmit/bbsmit_enquiry_model.dart';
import 'package:enquiry_hub/model/bbsmit/bbsmit_rscit_model.dart';
import 'package:enquiry_hub/model/bbsmit/bbsmit_enrollment_model.dart';
import 'package:enquiry_hub/model/bbsmit/bbsmit_faculty_model.dart';
import 'package:enquiry_hub/model/bbsmit/bbsmit_university_model.dart';
import 'package:enquiry_hub/view_models/controller/base_controller.dart';
import 'package:enquiry_hub/view_models/service/local_services/bbsmit_services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BbsmitController extends GetxController with BaseController {
  final BbsmitServices _bbsmitServices = BbsmitServices();

  final isLoading = false.obs;
  final selectedFilterIndex = 0.obs;

  final List<String> filters = [
    'Contact',
    'Enquiry',
    'RSCIT',
    'Enrollment',
    'Faculty',
    'University'
  ];

  final bbsmitContacts = <BbsmitContactModel>[].obs;
  final bbsmitEnquiries = <BbsmitEnquiryModel>[].obs;
  final bbsmitRscits = <BbsmitRscitModel>[].obs;
  final bbsmitEnrollments = <BbsmitEnrollmentModel>[].obs;
  final bbsmitFaculties = <BbsmitFacultyModel>[].obs;
  final bbsmitUniversities = <BbsmitUniversityModel>[].obs;

  void setFilterIndex(int index) {
    selectedFilterIndex.value = index;
    _loadDataForFilter(index);
  }

  Future<void> _loadDataForFilter(int index) async {
    switch (index) {
      case 0: if (bbsmitContacts.isEmpty) await getBbsmitContact(); break;
      case 1: if (bbsmitEnquiries.isEmpty) await getBbsmitEnquiry(); break;
      case 2: if (bbsmitRscits.isEmpty) await getBbsmitRscit(); break;
      case 3: if (bbsmitEnrollments.isEmpty) await getBbsmitEnrollment(); break;
      case 4: if (bbsmitFaculties.isEmpty) await getBbsmitFaculty(); break;
      case 5: if (bbsmitUniversities.isEmpty) await getBbsmitUniversity(); break;
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
      debugPrint('❌ [BbsmitController.refreshAllData] Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getBbsmitContact() async {
    try {
      final response = await _bbsmitServices.getBbsmitContact();
      final List<dynamic> data = response['data'] ?? [];
      bbsmitContacts.value = data.map((e) => BbsmitContactModel.fromJson(e)).toList();
    } catch (e) {
      if (selectedFilterIndex.value == 0) handleError(e);
    }
  }

  Future<void> getBbsmitEnquiry() async {
    try {
      final response = await _bbsmitServices.getBbsmitEnquiry();
      final List<dynamic> data = response['data'] ?? [];
      bbsmitEnquiries.value = data.map((e) => BbsmitEnquiryModel.fromJson(e)).toList();
    } catch (e) {
      if (selectedFilterIndex.value == 1) handleError(e);
    }
  }

  Future<void> getBbsmitRscit() async {
    try {
      final response = await _bbsmitServices.getBbsmitRscit();
      final List<dynamic> data = response['data'] ?? [];
      bbsmitRscits.value = data.map((e) => BbsmitRscitModel.fromJson(e)).toList();
    } catch (e) {
      if (selectedFilterIndex.value == 2) handleError(e);
    }
  }

  Future<void> getBbsmitEnrollment() async {
    try {
      final response = await _bbsmitServices.getBbsmitEnrollment();
      final List<dynamic> data = response['data'] ?? [];
      bbsmitEnrollments.value = data.map((e) => BbsmitEnrollmentModel.fromJson(e)).toList();
    } catch (e) {
      if (selectedFilterIndex.value == 3) handleError(e);
    }
  }

  Future<void> getBbsmitFaculty() async {
    try {
      final response = await _bbsmitServices.getBbsmitFaculty();
      final List<dynamic> data = response['data'] ?? [];
      bbsmitFaculties.value = data.map((e) => BbsmitFacultyModel.fromJson(e)).toList();
    } catch (e) {
      if (selectedFilterIndex.value == 4) handleError(e);
    }
  }

  Future<void> getBbsmitUniversity() async {
    try {
      final response = await _bbsmitServices.getBbsmitUniversity();
      final List<dynamic> data = response['data'] ?? [];
      bbsmitUniversities.value = data.map((e) => BbsmitUniversityModel.fromJson(e)).toList();
    } catch (e) {
      if (selectedFilterIndex.value == 5) handleError(e);
    }
  }
}
