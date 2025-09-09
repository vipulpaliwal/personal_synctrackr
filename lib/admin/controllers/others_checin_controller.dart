import 'package:get/get.dart';

class OthersCheckinController extends GetxController {
  RxBool needMobileNumber = true.obs;
  RxBool isIdProofRequired = true.obs;
  RxBool mobileWithOTPRequired = true.obs;
  RxBool idCaptureRequired = true.obs;
  RxString selectedIdType = 'ID Proof'.obs;
  List<String> idTypes = ['ID Proof', 'Aadhar Card', 'PAN Card', 'Driving License'];

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
}
