import 'package:get/get.dart';

class ComplianceController extends GetxController {
  // Compliance toggle switch
  RxBool showCompliance = false.obs;

  // List of compliance questions
  RxList<String> questions = <String>[
    'Is there a Fire Exit plan available?',
    'Are First Aid kits easily accessible?',
  ].obs;

  // Toggle compliance view
  void toggleCompliance(bool value) {
    showCompliance.value = value;
  }

  // Add new compliance
  void addNewCompliance() {
    questions.add('');
  }

  // Update question
  void updateQuestion(int index, String value) {
    questions[index] = value;
  }
}
