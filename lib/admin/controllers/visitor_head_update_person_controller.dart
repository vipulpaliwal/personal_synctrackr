import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/visitors_heads_controller.dart';
import 'package:synctrackr/admin/models/visitor_heads_model.dart';
import 'dart:convert';
import 'package:synctrackr/admin/config/session_manager.dart';

class VisitorHeadUpdateController extends GetxController {
  final ApiService _apiService = ApiService();
  // Observables for form fields
  final fullName = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final department = ''.obs;
  final designation = ''.obs;
  final accessType = 'Staff Person'.obs;
  final selectedAvatarIndex = (-1).obs;
  final customImage = Rx<File?>(null);

  // Loading and error states
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final String headId;
  String? _companyId;
  String get companyId => _companyId ?? '1';

  VisitorHeadUpdateController({required this.headId});

  @override
  void onInit() {
    super.onInit();
    // Try to get data from selected employee first, then fetch from API if needed
    _initialize();
  }

  Future<void> _initialize() async {
    _companyId = await SessionManager.getCompanyId();
    _loadEmployeeData();
  }

  // Load employee data from selected employee or API
  void _loadEmployeeData() {
    final MainController mainController = Get.find<MainController>();
    final selectedEmployee = mainController.selectedEmployee;

    print('🔍 Loading employee data for headId: "$headId"');
    print('🔍 HeadId type: ${headId.runtimeType}');
    print('🔍 HeadId length: ${headId.length}');
    print('🔍 Selected employee: ${selectedEmployee?.name}');
    print('🔍 Selected employee ID: ${selectedEmployee?.id}');

    // Validate headId before proceeding
    if (headId.isEmpty || headId == '0' || headId == 'null') {
      errorMessage.value =
          'Invalid head ID: "$headId". Please select an employee first.';
      print('❌ Invalid headId: "$headId"');
      return;
    }

    if (selectedEmployee != null) {
      // Use data from selected employee
      fullName.value = selectedEmployee.name;
      phone.value = selectedEmployee.phone;
      email.value = selectedEmployee.email;
      department.value = selectedEmployee.department;
      designation.value = selectedEmployee.position;
      print('✅ Prefilled data from selected employee');
      // Note: We don't have access type in Employee model, so we'll fetch it from API
      fetchHeadDetails();
    } else {
      print('⚠️ No selected employee, fetching from API');
      // No selected employee, fetch from API
      fetchHeadDetails();
    }
  }

  // Fetch access type and other missing data for the visitor head
  void fetchHeadDetails() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // Convert headId to int for API call
      final int headIdInt = int.tryParse(headId) ?? 0;
      print('🔍 Parsed headId: $headIdInt from string: $headId');
      print('🔍 Using companyId: $companyId');

      if (headIdInt == 0) {
        errorMessage.value = 'Invalid head ID: $headId';
        print('❌ Invalid head ID: $headId');
        return;
      }

      print('🌐 Making API call to get head details...');
      final response = await _apiService.getHeadDetails(headIdInt.toString(),
          companyId: companyId);
      print('📡 API Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('📄 API Response data: $responseData');

        // Check if API call was successful and has head data
        if (responseData['success'] == true && responseData['head'] != null) {
          final headData = responseData['head'];
          print('✅ Head data found: $headData');

          // Only update fields that we don't already have from selectedEmployee
          if (fullName.value.isEmpty) fullName.value = headData['name'] ?? '';
          if (phone.value.isEmpty) phone.value = headData['phone'] ?? '';
          if (email.value.isEmpty) email.value = headData['email'] ?? '';
          if (department.value.isEmpty) {
            department.value = headData['dept'] ?? '';
          }
          if (designation.value.isEmpty) {
            designation.value = headData['designation'] ?? '';
          }

          // Set default access type - we'll need to get this from a different API or default to Staff
          accessType.value =
              'Staff Person'; // Default value since role is not in this response
          print('✅ Data loaded successfully');
        } else {
          errorMessage.value = 'Head not found or invalid response';
          print('❌ Head not found in response: ${responseData['success']}');
        }
      } else {
        final errorData = json.decode(response.body);
        errorMessage.value = errorData['message'] ??
            'Failed to load head details (${response.statusCode})';
        print('❌ API Error: ${response.statusCode} - ${errorData['message']}');
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Select an avatar
  void selectAvatar(int index) {
    selectedAvatarIndex.value = index;
    customImage.value = null; // Clear custom image when an avatar is selected
  }

  // Pick an image from the gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      customImage.value = File(pickedFile.path);
      selectedAvatarIndex.value = -1; // Clear avatar selection
    }
  }

  // Submit the updated form
  void submitForm() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Convert headId to int for API call
      final int headIdInt = int.tryParse(headId) ?? 0;
      if (headIdInt == 0) {
        errorMessage.value = 'Invalid head ID: $headId';
        return;
      }

      final Map<String, dynamic> updatedData = {
        'name': fullName.value,
        'phone': phone.value,
        'email': email.value,
        'dept': department.value,
        'designation': designation.value,
        'accessType': accessType.value == 'Admin' ? 'admin' : 'staff',
      };

      final response = await _apiService
          .updateHead(headIdInt.toString(), updatedData, companyId: companyId);

      if (response.statusCode == 200) {
        // Refresh data on previous screens
        final visitorsHeadsController = Get.find<VisitorsHeadsController>();
        await visitorsHeadsController.fetchHeads();

        final mainController = Get.find<MainController>();
        if (mainController.selectedEmployee?.id == headId) {
          final updatedEmployee = Employee(
            id: headId,
            name: fullName.value,
            department: department.value,
            position: designation.value,
            email: email.value,
            phone: phone.value,
            avatar: mainController.selectedEmployee!.avatar,
            status: mainController.selectedEmployee!.status,
            statusColor: mainController.selectedEmployee!.statusColor,
          );
          mainController.selectEmployee(updatedEmployee);
          mainController.selectVisitorHead(updatedEmployee);
        }

        Get.back(); // Navigate back first

        Get.snackbar(
          'Success! ',
          'Your profile has been updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(16),
          borderRadius: 8,
          icon: Icon(Icons.check_circle, color: Colors.white),
        );
      } else {
        final message =
            json.decode(response.body)['message'] ?? 'Failed to update profile';
        errorMessage.value = message;
        Get.snackbar(
          'Error ',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          margin: EdgeInsets.all(16),
          borderRadius: 8,
          icon: Icon(Icons.error, color: Colors.white),
        );
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      Get.snackbar(
        'Error ',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        margin: EdgeInsets.all(16),
        borderRadius: 8,
        icon: Icon(Icons.error, color: Colors.white),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
