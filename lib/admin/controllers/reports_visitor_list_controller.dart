import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/api_config.dart';

// Web-specific imports
import 'dart:html' as html;

class ReportsVisitorListController extends GetxController {
  final ApiService _apiService = ApiService();
  late StreamSubscription<List<Visitor>> _visitorSubscription;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var searchController = TextEditingController();
  var allResults = <Visitor>[].obs;
  var filteredResults = <Visitor>[].obs;

  // Status filter
  var selectedStatus = ''.obs; // Empty string means no filter (all)

  // Track if current filter has data
  var hasDataForCurrentFilter = true.obs;

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
      _visitorSubscription = _apiService.getVisitors(
        companyId,
        status: selectedStatus.value.isNotEmpty ? selectedStatus.value : null
      ).listen(
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

  // Method to update status filter
  void updateStatusFilter(String status) {
    selectedStatus.value = status;
    // Cancel current subscription and create new one with updated status
    _visitorSubscription.cancel();
    _subscribeToVisitors();
  }

  // Method to clear status filter
  void clearStatusFilter() {
    selectedStatus.value = '';
    _visitorSubscription.cancel();
    _subscribeToVisitors();
  }

  // Get available status options
  List<String> getStatusOptions() {
    return [
      'All',
      'pending',
      'accepted',
      'rejected',
      'appointment_date_changed',
      'checked-in',
      'checked-out'
    ];
  }

  // Get display name for status
  String getStatusDisplayName(String status) {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'accepted':
        return 'Accepted';
      case 'rejected':
        return 'Rejected';
      case 'appointment_date_changed':
        return 'Rescheduled';
      case 'checked-in':
        return 'Checked In';
      case 'checked-out':
        return 'Checked Out';
      default:
        return 'All';
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

    // Update data availability for current filter
    _updateDataAvailability();

    // Adjust current page if it's out of bounds after filtering
    if (totalPages > 0 && currentPage.value > totalPages) {
      currentPage.value = totalPages;
    } else if (totalPages == 0) {
      currentPage.value = 1;
    }
  }

  /// Update data availability based on current filter and search
  void _updateDataAvailability() {
    // Check if there's data for the current filter combination
    hasDataForCurrentFilter.value = filteredResults.isNotEmpty;
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

  // ==================== CSV EXPORT FUNCTIONALITY ====================

  // Export loading state
  var isExporting = false.obs;

  /// Export visitors as CSV with status filtering
  Future<void> exportVisitorsCsv(String status) async {
    if (isExporting.value) return; // Prevent multiple simultaneous exports

    // Check if there's data to export
    if (!hasDataForCurrentFilter.value) {
      Get.snackbar(
        'No Data to Export',
        'There are no visitors matching the current filter criteria.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    isExporting.value = true;

    try {
      final companyId = await ApiConfig.getCompanyId();
      if (companyId == null) {
        throw Exception('Company ID not found. Please log in again.');
      }

      // Get CSV data from API
      final response = await _apiService.exportVisitorsCsv(
        companyId: companyId,
        status: status != 'All' ? status : null,
        search: searchController.text.isNotEmpty ? searchController.text : null,
      );

      if (response.statusCode == 200) {
        final csvData = response.bodyBytes;

        // Generate filename with timestamp and status
        final timestamp = DateTime.now().toIso8601String().split('T')[0];
        final statusSuffix = status != 'All' ? '_${status.replaceAll('-', '_')}' : '';
        final fileName = 'visitors${statusSuffix}_$timestamp.csv';

        // Download based on platform
        await _downloadCsvFile(csvData, fileName);

        Get.snackbar(
          'Export Successful',
          'CSV file downloaded successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        // Try to parse error message from response
        String errorMessage = 'Export failed with status: ${response.statusCode}';
        try {
          final errorBody = json.decode(response.body);
          if (errorBody is Map<String, dynamic> && errorBody.containsKey('message')) {
            errorMessage = errorBody['message'];
          }
        } catch (_) {
          // Use default error message if parsing fails
        }

        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Export error: $e');

      String userFriendlyMessage = 'Failed to export CSV file';
      if (e.toString().contains('timeout')) {
        userFriendlyMessage = 'Export timed out. Please try again.';
      } else if (e.toString().contains('network')) {
        userFriendlyMessage = 'Network error. Please check your connection.';
      } else if (e.toString().contains('Company ID not found')) {
        userFriendlyMessage = 'Authentication error. Please log in again.';
      }

      Get.snackbar(
        'Export Failed',
        userFriendlyMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isExporting.value = false;
    }
  }

  /// Check if running on web platform
  bool _isWebPlatform() {
    try {
      return html.document != null;
    } catch (e) {
      return false;
    }
  }

  /// Download CSV file based on platform
  Future<void> _downloadCsvFile(Uint8List csvData, String fileName) async {
    if (_isWebPlatform()) {
      await _downloadForWeb(csvData, fileName);
    } else {
      await _downloadForMobile(csvData, fileName);
    }
  }

  /// Web-specific CSV download
  Future<void> _downloadForWeb(Uint8List csvData, String fileName) async {
    try {
      // Create blob from CSV data
      final blob = html.Blob([csvData], 'text/csv');

      // Create download link
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..target = '_blank'
        ..download = fileName;

      // Trigger download
      anchor.click();

      // Clean up
      html.Url.revokeObjectUrl(url);

    } catch (e) {
      throw Exception('Web download failed: $e');
    }
  }

  /// Mobile-specific CSV download
  Future<void> _downloadForMobile(Uint8List csvData, String fileName) async {
    try {
      // Get appropriate directory based on platform
      Directory? directory;

      if (Platform.isAndroid) {
        // For Android, use Downloads directory
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        // For iOS, use Documents directory
        directory = await getApplicationDocumentsDirectory();
      } else {
        // Fallback
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access storage directory');
      }

      // Create file path
      final filePath = '${directory.path}/$fileName';

      // Write file
      final file = File(filePath);
      await file.writeAsBytes(csvData);

      // Share file to open in file manager
      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'Visitor data export',
        subject: 'Visitors CSV Export',
      );

    } catch (e) {
      // If sharing fails, still show success since file was saved
      Get.snackbar(
        'File Saved',
        'CSV file saved to Downloads folder',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  /// Get export status text for UI
  String getExportStatusText() {
    if (isExporting.value) {
      return 'Exporting...';
    }
    return 'Export';
  }

  /// Check if export is currently in progress
  bool get isExportInProgress => isExporting.value;
}
