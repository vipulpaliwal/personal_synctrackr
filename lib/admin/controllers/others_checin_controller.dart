import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/api_config.dart';

class OthersCheckinController extends GetxController {
  // Form key and text controllers for validations
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();

  RxBool needMobileNumber = true.obs;
  RxBool isIdProofRequired = true.obs;
  RxBool mobileWithOTPRequired = true.obs;
  RxBool idCaptureRequired = true.obs;
  RxString selectedIdType = 'ID Proof'.obs;
  List<String> idTypes = [
    'ID Proof',
    'Aadhar Card',
    'PAN Card',
    'Driving License'
  ];

  final ApiService _api = ApiService();
  final isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadVisitorForm();
  }

  void toggleMobileNumber(bool value) {
    needMobileNumber.value = value;
  }

  void toggleIdProofRequired(bool value) {
    isIdProofRequired.value = value;
  }

  void setMobileWithOTP(bool value) {
    mobileWithOTPRequired.value = value;
  }

  void setIdCaptureRequired(bool value) {
    idCaptureRequired.value = value;
  }

  void setSelectedIdType(String value) {
    selectedIdType.value = value;
  }

  Future<void> _loadVisitorForm() async {
    try {
      final companyId = await ApiConfig.getCompanyId();
      final resp = await _api.getVisitorForm(companyId);
      final form = resp['visitorForm'];
      if (form != null && form['fields'] != null) {
        final fields = Map<String, dynamic>.from(form['fields']);
        needMobileNumber.value = fields['mobileRequired'] == true;
        mobileWithOTPRequired.value = fields['otpRequired'] == true;
        isIdProofRequired.value = fields['idProofRequired'] == true;
        idCaptureRequired.value = fields['idProofPhotoRequired'] == true;
        final idType = fields['idType'];
        if (idType is String && idType.isNotEmpty) {
          selectedIdType.value = idType;
        }
      }
    } catch (e) {
      // Don't clear the form settings if an error occurs
      // This will keep the last known settings
      print('Failed to load visitor form settings: $e');
    }
  }

  // Validators
  String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  String? validatePhone(String? value) {
    if (!needMobileNumber.value) return null;
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Mobile number is required';
    final digitsOnly = text.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 10) return 'Enter a valid 10-digit mobile number';
    return null;
  }

  String? validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null; // optional
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(text)) return 'Enter a valid email address';
    return null;
  }

  String? validateIdNumber(String? value) {
    if (!isIdProofRequired.value) return null;
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'ID number is required';
    return null;
  }

  Future<void> validateAndSave() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      Get.snackbar('Validation', 'Please fix the errors and try again',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    await saveVisitorForm();
  }

  Future<void> saveVisitorForm() async {
    try {
      isSaving.value = true;
      final companyId = await ApiConfig.getCompanyId();
      final fields = {
        'mobileRequired': needMobileNumber.value,
        'otpRequired': mobileWithOTPRequired.value,
        'idProofRequired': isIdProofRequired.value,
        'idProofPhotoRequired': idCaptureRequired.value,
        'idType': selectedIdType.value,
      };
      await _api.saveVisitorForm(companyId: companyId, fields: fields);
    } finally {
      isSaving.value = false;
    }
  }

  // @override
  // void onClose() {
  //   fullNameController.dispose();
  //   emailController.dispose();
  //   departmentController.dispose();
  //   designationController.dispose();
  //   phoneController.dispose();
  //   idNumberController.dispose();
  //   super.onClose();
  // }
}
