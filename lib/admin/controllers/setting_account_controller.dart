import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class AccountSettingsController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final twoFA = false.obs;
  final loginAlerts = false.obs;

  // Rx variable to hold the selected file. `PlatformFile` is from the file_picker package.
  final Rx<PlatformFile?> selectedFile = Rx<PlatformFile?>(null);


  void toggle2FA(bool value) {
    twoFA.value = value;
  }

  void toggleLoginAlerts(bool value) {
    loginAlerts.value = value;
  }

  // Function to handle the file picking logic
  Future<void> pickFile() async {
    try {
      print("Attempting to pick a file...");
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'svg'],
        withData: true, // Required for web to get bytes
      );

      if (result != null && result.files.isNotEmpty) {
        print("File picked successfully: ${result.files.first.name}");
        selectedFile.value = result.files.first;
      } else {
        print('File picking cancelled by the user or failed.');
      }
    } catch (e) {
      print('An error occurred while picking the file: $e');
    }
  }

  // Example method for saving changes
  void saveChanges() {
    // Add your logic to save the updated settings
    // This could involve calling an API, updating local storage, etc.
    print('Saving changes...');
    print('Name: ${nameController.text}');
    print('Email: ${emailController.text}');
    print('Phone: ${phoneController.text}');
    print('2FA enabled: ${twoFA.value}');
    print('Login Alerts enabled: ${loginAlerts.value}');
    if (selectedFile.value != null) {
      print('Selected file name: ${selectedFile.value!.name}');
      print('Selected file size: ${selectedFile.value!.size}');
      // You can use selectedFile.value!.bytes or selectedFile.value!.path
      // to access the file data for upload.
    } else {
      print('No file selected.');
    }
  }

  @override
  void onClose() {
    // Clean up controllers when the widget is disposed to prevent memory leaks.
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
