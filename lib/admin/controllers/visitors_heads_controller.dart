import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/models/visitor_heads_model.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/api_config.dart';

class VisitorsHeadsController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxString searchQuery = ''.obs;
  final RxInt currentPage = 1.obs;
  final int itemsPerPage = 10;

  var isLoading = true.obs;
  var totalHeads = 0.obs;
  var totalDepartments = 0.obs;
  final RxList<Employee> employees = <Employee>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    await fetchHeads();
  }

  Future<void> fetchHeads() async {
    try {
      isLoading(true);
      final companyId = await ApiConfig.getCompanyId();
      final result = await _apiService.getHeads(companyId);

      totalHeads.value = result['totalHeads'];
      totalDepartments.value = result['totalDepartments'];
      
      final List<dynamic> data = result['data'];
      employees.value = data.map((json) => Employee.fromJson(json)).toList();

    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch heads: $e');
    } finally {
      isLoading(false);
    }
  }

  List<Employee> get filteredEmployees {
    if (searchQuery.value.isEmpty) return employees;
    return employees
        .where((employee) =>
            employee.name
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            employee.department
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            employee.position
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  int get totalPages => (filteredEmployees.length / itemsPerPage).ceil();

  List<Employee> getCurrentPageResults() {
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, filteredEmployees.length);
    return filteredEmployees.sublist(startIndex, endIndex);
  }

  void search(String value) {
    searchQuery.value = value;
    currentPage.value = 1;
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
    currentPage.value = page;
  }
}
