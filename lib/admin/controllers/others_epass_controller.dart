import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/services/e_pass_service.dart';

class EPassController extends GetxController {
  // API Service instance
  final ApiService _apiService = ApiService();

  // Form state
  RxString passType = 'Guest Pass'.obs;
  RxString fullName = ''.obs;
  RxString email = ''.obs;
  RxString department = ''.obs;
  RxString designation = ''.obs;

  // File upload state
  RxString uploadedFileName = ''.obs;
  File? uploadedFile;

  // UI state
  RxBool isLoading = false.obs;

  // Reactive variable to trigger widget refresh
  RxInt refreshTrigger = 0.obs;

  void setPassType(String? type) {
    if (type != null) {
      passType.value = type;
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx', 'xls'],
    );

    if (result != null && result.files.single.path != null) {
      uploadedFile = File(result.files.single.path!);
      uploadedFileName.value = result.files.single.name;
    }
  }

  void removeFile() {
    uploadedFile = null;
    uploadedFileName.value = '';
  }

  Future<void> generatePass() async {
    if (uploadedFile != null) {
      await _handleBulkUpload();
    } else {
      await _handleManualEntry();
    }
  }

  Future<void> _handleManualEntry() async {
    if (fullName.value.isEmpty || email.value.isEmpty) {
      _showSnackbar('Error', 'Full Name and Email are required.', Colors.red);
      return;
    }

    isLoading.value = true;
    final result = await _apiService.createPass(
      fullName: fullName.value,
      email: email.value,
      department: department.value,
      designation: designation.value,
      passType: passType.value,
    );
    isLoading.value = false;

    if (result['success']) {
      _showSnackbar('Success', result['message'], Colors.green);
      _resetManualFields();
      // Refresh the passes list in real-time
      _refreshPassesList();
    } else {
      _showSnackbar('Error', result['message'], Colors.red);
    }
  }

  Future<void> _handleBulkUpload() async {
    if (uploadedFile == null) return;

    isLoading.value = true;
    final result = await _apiService.bulkUploadPasses(uploadedFile!, passType.value);
    isLoading.value = false;

    if (result['success']) {
      _showSnackbar('Success', result['message'], Colors.green);
      removeFile();
      // Refresh the passes list in real-time after bulk upload
      _refreshPassesList();
    } else {
      _showSnackbar('Error', result['message'], Colors.red);
    }
  }

  void _resetManualFields() {
    fullName.value = '';
    email.value = '';
    department.value = '';
    designation.value = '';
  }

  void _refreshPassesList() {
    // Increment the refresh trigger to notify the widget to reload
    // This will trigger real-time update in the passes list
    refreshTrigger.value++;
  }

  void _showSnackbar(String title, String message, Color backgroundColor) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
    );
  }
}
