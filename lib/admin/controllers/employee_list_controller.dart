import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/api_config.dart';

class EmployeeListController extends GetxController {
  final ApiService _apiService = ApiService();
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var searchController = TextEditingController();
  var allResults = <Visitor>[].obs;
  var filteredResults = <Visitor>[].obs;

  // Pagination
  var currentPage = 1.obs;
  final int _resultsPerPage = 10;

  int get totalPages => (filteredResults.length / _resultsPerPage).ceil();

  @override
  void onInit() {
    super.onInit();
    fetchVisitors();
  }

  void fetchVisitors() async {
    try {
      isLoading(true);
      final companyId = await ApiConfig.getCompanyId();
      var visitors = await _apiService.getVisitors(companyId);
      allResults.assignAll(visitors);
      filteredResults.assignAll(allResults);
    } catch (e) {
      errorMessage('Failed to fetch visitors: $e');
    } finally {
      isLoading(false);
    }
  }

  void filterResults(String query) {
    if (query.isEmpty) {
      filteredResults.assignAll(allResults);
    } else {
      filteredResults.assignAll(allResults
          .where((visitor) =>
              visitor.name.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
    currentPage(1); // Reset to first page after filtering
  }

  List<Visitor> getCurrentPageResults() {
    final startIndex = (currentPage.value - 1) * _resultsPerPage;
    final endIndex = startIndex + _resultsPerPage;
    return filteredResults.sublist(startIndex,
        endIndex > filteredResults.length ? filteredResults.length : endIndex);
  }

  void nextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      currentPage.value = page;
    }
  }
}
