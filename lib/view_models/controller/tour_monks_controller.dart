import 'package:enquiry_hub/model/tour_monks/tour_book_model.dart';
import 'package:enquiry_hub/model/tour_monks/tour_booking_confirm_model.dart';
import 'package:enquiry_hub/model/tour_monks/tour_contact_model.dart';
import 'package:enquiry_hub/model/tour_monks/tour_customize_model.dart';
import 'package:enquiry_hub/model/tour_monks/tour_enquiry_model.dart';
import 'package:enquiry_hub/view_models/controller/base_controller.dart';
import 'package:enquiry_hub/view_models/service/local_services/tour_monk_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class TourMonksController extends GetxController with BaseController {
  final TourMonkService _tourService = TourMonkService();

  final isLoading = false.obs;
  final selectedFilterIndex = 0.obs;

  final List<String> filters = [
    'Contact',
    'Customize',
    'Book',
    'Enquiry',
    'Confirm',
  ];

  // Observables for different lists
  final tourContacts = <TourContactModel>[].obs;
  final tourCustomizes = <TourCustomizeData>[].obs;
  final tourBooks = <TourBookModel>[].obs;
  final tourEnquiries = <TourEnquiryModel>[].obs;
  final tourBookingConfirms = <TourBookingConfirmModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // refreshAllData is called from View when needed
  }

  void setFilterIndex(int index) {
    selectedFilterIndex.value = index;
    _loadDataForFilter(index);
  }

  Future<void> _loadDataForFilter(int index) async {
    switch (index) {
      case 0: if (tourContacts.isEmpty) await getTourContacts(); break;
      case 1: if (tourCustomizes.isEmpty) await getTourCustomize(); break;
      case 2: if (tourBooks.isEmpty) await getTourBook(); break;
      case 3: if (tourEnquiries.isEmpty) await getTourEnquiry(); break;
      case 4: if (tourBookingConfirms.isEmpty) await getTourBookingConfirm(); break;
    }
  }

  Future<void> refreshAllData() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      // Load current filter first
      await _loadDataForFilter(selectedFilterIndex.value);

      // Load others in background with delay to avoid 503
      Future.microtask(() async {
        for (int i = 0; i < filters.length; i++) {
          if (i == selectedFilterIndex.value) continue;
          await Future.delayed(const Duration(milliseconds: 1500)); // Increased delay
          await _loadDataForFilter(i);
        }
      });
    } catch (e) {
      debugPrint('❌ [TourMonksController.refreshAllData] Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTourContacts() async {
    debugPrint('➡️ [TourMonksController.getTourContacts] called');
    try {
      final data = await _tourService.getTourContacts();
      if (data != null) tourContacts.assignAll(data);
    } catch (e) {
      debugPrint('❌ [TourMonksController.getTourContacts] Error: $e');
      if (selectedFilterIndex.value == 0) handleError(e);
    }
  }

  Future<void> getTourCustomize() async {
    debugPrint('➡️ [TourMonksController.getTourCustomize] called');
    try {
      final data = await _tourService.getTourCustomize();
      if (data != null) tourCustomizes.assignAll(data);
    } catch (e) {
      debugPrint('❌ [TourMonksController.getTourCustomize] Error: $e');
      if (selectedFilterIndex.value == 1) handleError(e);
    }
  }

  Future<void> getTourBook() async {
    debugPrint('➡️ [TourMonksController.getTourBook] called');
    try {
      final data = await _tourService.getTourBook();
      if (data != null) tourBooks.assignAll(data);
    } catch (e) {
      debugPrint('❌ [TourMonksController.getTourBook] Error: $e');
      if (selectedFilterIndex.value == 2) handleError(e);
    }
  }

  Future<void> getTourEnquiry() async {
    debugPrint('➡️ [TourMonksController.getTourEnquiry] called');
    try {
      final data = await _tourService.getTourEnquiry();
      if (data != null) tourEnquiries.assignAll(data);
    } catch (e) {
      debugPrint('❌ [TourMonksController.getTourEnquiry] Error: $e');
      if (selectedFilterIndex.value == 3) handleError(e);
    }
  }

  Future<void> getTourBookingConfirm() async {
    debugPrint('➡️ [TourMonksController.getTourBookingConfirm] called');
    try {
      final data = await _tourService.getTourBookingConfirm();
      if (data != null) tourBookingConfirms.assignAll(data);
    } catch (e) {
      debugPrint('❌ [TourMonksController.getTourBookingConfirm] Error: $e');
      if (selectedFilterIndex.value == 4) handleError(e);
    }
  }
}
