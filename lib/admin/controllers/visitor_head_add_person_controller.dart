import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VisitorController extends GetxController {
  final ApiService _apiService = ApiService();
  final _secureStorage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final staffRoleController = TextEditingController();
  final deptController = TextEditingController();
  final designationController = TextEditingController();
  final mobileNumberController = TextEditingController();

  var isLoading = false.obs;
  var selectedAvatarIndex = (-1).obs;
  var customImage = Rxn<XFile>();
  var accessType = 'Staff Person'.obs;
  var role = 'staff'.obs;

  GlobalKey<FormState> get formKey => _formKey;

  void selectAvatar(int index) {
    selectedAvatarIndex.value = index;
    customImage.value = null;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      customImage.value = image;
      selectedAvatarIndex.value = -1;
    }
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      isLoading.value = true;

      final data = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "role": "staff",
        "staffRole": role.value,
        "dept": deptController.text,
        "designation": designationController.text,
        "mobileNumber": mobileNumberController.text,
      };

      try {
        final token = await _secureStorage.read(key: 'authToken');
        if (token == null) {
          throw Exception('Auth token not found');
        }
        await _apiService.addStaff(data, token);
        Get.snackbar('Success', 'Staff added successfully',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        _clearForm();
      } catch (e) {
        Get.snackbar('Error', e.toString(),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading.value = false;
      }
    }
  }

  void _clearForm() {
    _formKey.currentState!.reset();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    staffRoleController.clear();
    deptController.clear();
    designationController.clear();
    mobileNumberController.clear();
    selectedAvatarIndex.value = -1;
    customImage.value = null;
  }
}
