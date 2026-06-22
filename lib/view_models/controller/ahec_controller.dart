import 'package:enquiry_hub/model/ahec/ahec_affiliate_model.dart';
import 'package:enquiry_hub/model/ahec/ahec_fl_registration_model.dart';
import 'package:enquiry_hub/model/ahec/ahec_newsletter_model.dart';
import 'package:enquiry_hub/model/ahec/ahec_query_model.dart';
import 'package:enquiry_hub/model/ahec/ahec_registration_model.dart';
import 'package:enquiry_hub/view_models/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/local_services/ahec_service.dart';

class AhecController extends GetxController with BaseController {
  final AhecService _ahecService = AhecService();

  final isLoading = false.obs;
  final isMoreLoading = false.obs;
  final selectedFilterIndex = 0.obs;

  final List<String> filters = [
    'Queries',
    'Registration',
    'FL Registration',
    'Affiliate',
    'Newsletter',
  ];

  // Observables for data lists
  final ahecQueries = <AhecQueryData>[].obs;
  final ahecRegistrations = <AhecRegistrationUser>[].obs;
  final ahecFlRegistrations = <FlRegistrationItem>[].obs;
  final ahecAffiliates = <AffiliateItem>[].obs;
  final ahecNewsletters = <NewsletterItem>[].obs;

  // Pagination states
  int _queryPage = 1;
  bool _queryHasMore = true;

  int _regPage = 1;
  bool _regHasMore = true;

  int _flRegPage = 1;
  bool _flRegHasMore = true;

  int _affiliatePage = 1;
  bool _affiliateHasMore = true;

  int _newsletterPage = 1;
  bool _newsletterHasMore = true;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    // Removed auto-refresh to prevent 503 errors on app start
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreData();
    }
  }

  void setFilterIndex(int index) {
    selectedFilterIndex.value = index;
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    }
    _loadDataForFilter(index);
  }

  Future<void> _loadDataForFilter(int index) async {
    switch (index) {
      case 0:
        if (ahecQueries.isEmpty) await getAhecQuery(isRefresh: true);
        break;
      case 1:
        if (ahecRegistrations.isEmpty) await getAhecRegistration(isRefresh: true);
        break;
      case 2:
        if (ahecFlRegistrations.isEmpty) await getAhecFlRegistration(isRefresh: true);
        break;
      case 3:
        if (ahecAffiliates.isEmpty) await getAhecAffiliate(isRefresh: true);
        break;
      case 4:
        if (ahecNewsletters.isEmpty) await getAhecNewsletter(isRefresh: true);
        break;
    }
  }

  Future<void> refreshAllData() async {
    if (isLoading.value) return;
    isLoading.value = true;
    _resetPagination();
    try {
      // Load only the current filter first
      await _loadDataForFilter(selectedFilterIndex.value);
      
      // Load others with a delay to prevent 503
      Future.microtask(() async {
        for (int i = 0; i < filters.length; i++) {
          if (i == selectedFilterIndex.value) continue;
          await Future.delayed(const Duration(milliseconds: 1000));
          await _loadDataForFilter(i);
        }
      });
    } catch (e, s) {
      debugPrint('❌ [AhecController.refreshAllData] Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _resetPagination() {
    _queryPage = 1;
    _queryHasMore = true;
    _regPage = 1;
    _regHasMore = true;
    _flRegPage = 1;
    _flRegHasMore = true;
    _affiliatePage = 1;
    _affiliateHasMore = true;
    _newsletterPage = 1;
    _newsletterHasMore = true;
  }

  Future<void> loadMoreData() async {
    if (isMoreLoading.value || isLoading.value) return;

    switch (selectedFilterIndex.value) {
      case 0:
        if (_queryHasMore) await getAhecQuery();
        break;
      case 1:
        if (_regHasMore) await getAhecRegistration();
        break;
      case 2:
        if (_flRegHasMore) await getAhecFlRegistration();
        break;
      case 3:
        if (_affiliateHasMore) await getAhecAffiliate();
        break;
      case 4:
        if (_newsletterHasMore) await getAhecNewsletter();
        break;
    }
  }

  // 1. Query API Method (GET)
  Future<void> getAhecQuery({bool isRefresh = false}) async {
    if (isRefresh) {
      _queryPage = 1;
      _queryHasMore = true;
    }
    if (!_queryHasMore) return;

    if (!isRefresh) isMoreLoading.value = true;
    try {
      final response = await _ahecService.getAhecQuery(_queryPage);
      final model = AhecQueryModel.fromJson(response);

      if (isRefresh) {
        ahecQueries.assignAll(model.data);
      } else {
        ahecQueries.addAll(model.data);
      }

      _queryHasMore = _queryPage < model.lastPage;
      if (_queryHasMore) _queryPage++;
    } catch (e, s) {
      debugPrint('❌ [AhecController.getAhecQuery] Error: $e');
      if (!isRefresh && selectedFilterIndex.value == 0) handleError(e);
    } finally {
      isMoreLoading.value = false;
    }
  }

  // 2. Registration API Method (GET)
  Future<void> getAhecRegistration({bool isRefresh = false}) async {
    if (isRefresh) {
      _regPage = 1;
      _regHasMore = true;
    }
    if (!_regHasMore) return;

    if (!isRefresh) isMoreLoading.value = true;
    try {
      final response = await _ahecService.getAhecRegistration(_regPage);
      final model = AhecRegistrationModel.fromJson(response);

      if (isRefresh) {
        ahecRegistrations.assignAll(model.data.data);
      } else {
        ahecRegistrations.addAll(model.data.data);
      }

      _regHasMore = _regPage < model.data.lastPage;
      if (_regHasMore) _regPage++;
    } catch (e, s) {
      debugPrint('❌ [AhecController.getAhecRegistration] Error: $e');
      if (!isRefresh && selectedFilterIndex.value == 1) handleError(e);
    } finally {
      isMoreLoading.value = false;
    }
  }

  // 3. FL Registration API Method (GET)
  Future<void> getAhecFlRegistration({bool isRefresh = false}) async {
    if (isRefresh) {
      _flRegPage = 1;
      _flRegHasMore = true;
    }
    if (!_flRegHasMore) return;

    if (!isRefresh) isMoreLoading.value = true;
    try {
      final response = await _ahecService.getAhecFlRegistration(_flRegPage);
      final model = AhecFlRegistrationModel.fromJson(response);
      final newData = model.data?.data ?? [];

      if (isRefresh) {
        ahecFlRegistrations.assignAll(newData);
      } else {
        ahecFlRegistrations.addAll(newData);
      }

      _flRegHasMore = _flRegPage < (model.data?.lastPage ?? 0);
      if (_flRegHasMore) _flRegPage++;
    } catch (e, s) {
      debugPrint('❌ [AhecController.getAhecFlRegistration] Error: $e');
      if (!isRefresh && selectedFilterIndex.value == 2) handleError(e);
    } finally {
      isMoreLoading.value = false;
    }
  }

  // 4. Affiliate API Method (GET)
  Future<void> getAhecAffiliate({bool isRefresh = false}) async {
    if (isRefresh) {
      _affiliatePage = 1;
      _affiliateHasMore = true;
    }
    if (!_affiliateHasMore) return;

    if (!isRefresh) isMoreLoading.value = true;
    try {
      final response = await _ahecService.getAhecAffiliate(_affiliatePage);
      final model = AhecAffiliateModel.fromJson(response);
      final newData = model.data?.data ?? [];

      if (isRefresh) {
        ahecAffiliates.assignAll(newData);
      } else {
        ahecAffiliates.addAll(newData);
      }

      _affiliateHasMore = _affiliatePage < (model.data?.lastPage ?? 0);
      if (_affiliateHasMore) _affiliatePage++;
    } catch (e, s) {
      debugPrint('❌ [AhecController.getAhecAffiliate] Error: $e');
      if (!isRefresh && selectedFilterIndex.value == 3) handleError(e);
    } finally {
      isMoreLoading.value = false;
    }
  }

  // 5. Newsletter API Method (GET)
  Future<void> getAhecNewsletter({bool isRefresh = false}) async {
    if (isRefresh) {
      _newsletterPage = 1;
      _newsletterHasMore = true;
    }
    if (!_newsletterHasMore) return;

    if (!isRefresh) isMoreLoading.value = true;
    try {
      final response = await _ahecService.getAhecNewslatter(_newsletterPage);
      final model = AhecNewsletterModel.fromJson(response);
      final newData = model.data?.data ?? [];

      if (isRefresh) {
        ahecNewsletters.assignAll(newData);
      } else {
        ahecNewsletters.addAll(newData);
      }

      _newsletterHasMore = _newsletterPage < (model.data?.lastPage ?? 0);
      if (_newsletterHasMore) _newsletterPage++;
    } catch (e, s) {
      debugPrint('❌ [AhecController.getAhecNewsletter] Error: $e');
      if (!isRefresh && selectedFilterIndex.value == 4) handleError(e);
    } finally {
      isMoreLoading.value = false;
    }
  }
}
