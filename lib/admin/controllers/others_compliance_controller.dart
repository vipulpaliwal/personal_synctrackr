import 'package:get/get.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/api_config.dart';

class ComplianceController extends GetxController {
  // Compliance toggle switch
  RxBool showCompliance = false.obs;

  // List of compliance questions
  RxList<String> questions = <String>[
    'Is there a Fire Exit plan available?',
    'Are First Aid kits easily accessible?',
  ].obs;

  final isSaving = false.obs;
  final ApiService _api = ApiService();

  @override
  void onInit() {
    super.onInit();
    _loadFromCompanySettings();
  }

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

  // Delete compliance
  void deleteCompliance(int index) {
    Get.defaultDialog(
      title: 'Delete Compliance',
      middleText: 'Are you sure you want to delete this compliance?',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      onConfirm: () async {
        final complianceToRemove = questions[index];
        questions.removeAt(index);
        Get.back();
        try {
          final companyId = await ApiConfig.getCompanyId();
          await _api.deleteCompliances(
            companyId: companyId,
            remove: [complianceToRemove],
          );
          Get.snackbar('Success', 'Compliance deleted successfully');
        } catch (e) {
          Get.snackbar('Error', 'Failed to delete compliance: $e');
          // If the API call fails, add the compliance back to the list
          questions.insert(index, complianceToRemove);
        }
      },
    );
  }

  Future<void> _loadFromCompanySettings() async {
    try {
      final companyId = await ApiConfig.getCompanyId();
      final resp = await _api.getCompanySettings(companyId);
      final List<dynamic> comps = (resp['compliances'] ?? []) as List<dynamic>;
      questions.assignAll(comps.map((e) => e.toString()).toList());
      showCompliance.value = questions.isNotEmpty;
    } catch (_) {
      // keep defaults
    }
  }

  Future<void> saveCompliances() async {
    try {
      isSaving.value = true;
      final companyId = await ApiConfig.getCompanyId();
      final filtered =
          questions.map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
      if (filtered.isNotEmpty) {
        await _api.putCompliances(companyId: companyId, compliances: filtered);
      }
    } finally {
      isSaving.value = false;
    }
  }
}
