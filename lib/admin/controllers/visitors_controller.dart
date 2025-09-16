import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/routes/app_routes.dart';
import 'package:synctrackr/admin/services/api_services.dart';

class VisitorsController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxString searchQuery = ''.obs;
  final RxInt currentPage = 1.obs;
  final int itemsPerPage = 10;

  var isLoading = true.obs;
  var totalVisitors = 0.obs;
  final RxList<Visitor> visitors = <Visitor>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchVisitors();
  }

  Future<void> fetchVisitors() async {
    try {
      isLoading(true);
      // Assuming you have a way to get the companyId
      String companyId = "your_company_id"; // Replace with actual companyId
      _apiService.getVisitors(companyId).listen((visitorList) {
        visitors.assignAll(visitorList);
        totalVisitors.value = visitorList.length;
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch visitors: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> handleQrScan(String qrData) async {
    try {
      final visitorData = await _apiService.getEnrichedVisitorIfAny(qrData);
      if (visitorData != null) {
        final status = visitorData['data']['status'];
        if (status == 'IN') {
          final success = await _apiService.manualCheckout(qrData);
          if (success) {
            Get.toNamed(adminAppRoutes.manualCheckoutComplete, arguments: {
              'message': 'Checked Out',
              'isCheckIn': false,
            });
          } else {
            Get.snackbar('Error', 'Failed to check out visitor.');
          }
        } else {
          final success = await _apiService.manualCheckin(qrData);
          if (success) {
            Get.toNamed(adminAppRoutes.manualCheckoutComplete, arguments: {
              'message': 'Checked In',
              'isCheckIn': true,
            });
          } else {
            Get.snackbar('Error', 'Failed to check in visitor.');
          }
        }
      } else {
        Get.snackbar('Error', 'Visitor not found.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  List<Visitor> get filteredVisitors {
    if (searchQuery.value.isEmpty) return visitors;
    return visitors
        .where((visitor) =>
            visitor.name
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            (visitor.company ?? '')
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            visitor.purpose
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  int get totalPages => (filteredVisitors.length / itemsPerPage).ceil();

  List<Visitor> getCurrentPageResults() {
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, filteredVisitors.length);
    return filteredVisitors.sublist(startIndex, endIndex);
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
