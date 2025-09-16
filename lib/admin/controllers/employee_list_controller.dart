import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/api_config.dart';

class EmployeeListController extends GetxController {
  final ApiService _apiService = ApiService();
  late StreamSubscription<List<Visitor>> _visitorSubscription;
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
     

    _initialize();
  }

  Future<void> _initialize() async {
    await _loadEmployeesFromCache();
    _subscribeToVisitors();
  }

  void _subscribeToVisitors() async {
    isLoading(true);
    errorMessage('');
    try {
      final companyId = await ApiConfig.getCompanyId();
      _visitorSubscription = _apiService.getVisitors(companyId).listen(
        (visitors) {
          errorMessage(''); // Clear previous error on new data
          allResults.assignAll(visitors);
          filterResults(searchController.text);
          _saveEmployeesToCache(visitors);
          if (isLoading.value) isLoading(false);
        },
        onError: (error) {
          // Only show error if there's no data to display
          if (allResults.isEmpty) {
            errorMessage(error.toString());
          }
          if (isLoading.value) isLoading(false);
        },
      );
    } catch (e) {
      errorMessage('Failed to initialize visitor stream: $e');
      if (isLoading.value) isLoading(false);
    }
  }

  @override
  void onClose() {
    _visitorSubscription.cancel();
    // searchController.dispose();
    super.onClose();
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
    // Adjust current page if it's out of bounds after filtering
    if (totalPages > 0 && currentPage.value > totalPages) {
      currentPage.value = totalPages;
    } else if (totalPages == 0) {
      currentPage.value = 1;
    }
  }

  List<Visitor> getCurrentPageResults() {
    if (filteredResults.isEmpty) {
      return [];
    }
    final startIndex = (currentPage.value - 1) * _resultsPerPage;
    // Handle case where startIndex is out of bounds
    if (startIndex >= filteredResults.length) {
      return [];
    }
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

  Future<void> _saveEmployeesToCache(List<Visitor> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> jsonData =
          data.map((e) => e.toJson()).toList();
      final String encodedData = jsonEncode(jsonData);
      await prefs.setString('employeeListCache', encodedData);
    } catch (e) {
      print('Error saving employee list to cache: $e');
    }
  }

  Future<void> _loadEmployeesFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? encodedData = prefs.getString('employeeListCache');
      if (encodedData != null) {
        final List<dynamic> decodedData = jsonDecode(encodedData);
        final visitors =
            decodedData.map((item) => Visitor.fromJson(item)).toList();
        allResults.assignAll(visitors);
        filterResults(searchController.text);
      }
    } catch (e) {
      print('Error loading employee list from cache: $e');
    }
  }
}
