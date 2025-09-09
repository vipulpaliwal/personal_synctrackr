import 'package:get/get.dart';

class PurposeController extends GetxController {
  final purposes = ['Meeting', 'Vender', 'Delivery', 'Interview'];
  final selectedPurpose = ''.obs;

  void selectPurpose(String purpose) {
    selectedPurpose.value = purpose;
  }

  void onNext() {
    if (selectedPurpose.isEmpty) {
      Get.snackbar('Select Purpose', 'Please choose a purpose to continue');
      return;
    }
    
    Get.snackbar('Selected', 'Purpose: ${selectedPurpose.value}');
  }
}