import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';

class VisitorsController extends GetxController {
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
      // Using dummy data instead of API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      final dummyVisitors = [
        Visitor(
          id: 1,
          name: 'John Doe',
          company: 'ABC Corp',
          purpose: 'Meeting',
          status: 'Pending',
          appointmentDate: DateTime.now(),
          createdAt: DateTime.now(),
          host: Host(id: 1, name: 'Jane Smith', email: 'jane@example.com'),
        ),
        Visitor(
          id: 2,
          name: 'Alice Johnson',
          company: 'XYZ Ltd',
          purpose: 'Delivery',
          status: 'Approved',
          signedIn: DateTime.now().subtract(const Duration(hours: 1)),
          appointmentDate: DateTime.now(),
          createdAt: DateTime.now(),
          host: Host(id: 2, name: 'Robert Brown', email: 'robert@example.com'),
        ),
        Visitor(
          id: 3,
          name: 'Bob Williams',
          company: 'Tech Solutions',
          purpose: 'Interview',
          status: 'Rejected',
          appointmentDate: DateTime.now(),
          createdAt: DateTime.now(),
          host: Host(id: 1, name: 'Jane Smith', email: 'jane@example.com'),
        ),
        Visitor(
          id: 4,
          name: 'Charlie Brown',
          purpose: 'Maintenance',
          status: 'Checked Out',
          signedIn: DateTime.now().subtract(const Duration(hours: 2)),
          signedOut: DateTime.now().subtract(const Duration(minutes: 30)),
          appointmentDate: DateTime.now(),
          createdAt: DateTime.now(),
          host: Host(id: 3, name: 'Michael Davis', email: 'michael@example.com'),
        ),
      ];
      visitors.value = dummyVisitors;
      totalVisitors.value = visitors.length;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch visitors: $e');
    } finally {
      isLoading(false);
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
