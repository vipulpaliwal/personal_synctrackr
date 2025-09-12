import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/api_config.dart';

class OthersController extends GetxController {
  var file = Rx<File?>(null);
  var dragging = false.obs;

  // Advanced Options (loaded from company settings.modifications)
  final otpRequired = false.obs;
  final mobileRequired = false.obs;
  final idProofRequired = false.obs;
  final isLoadingSettings = false.obs;

  final _api = ApiService();
  final isUploading = false.obs;

  void onFileDrop(String path) {
    file.value = File(path);
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx', 'xls'],
    );

    if (result != null && result.files.single.path != null) {
      file.value = File(result.files.single.path!);
    }
  }

  Future<void> loadCompanySettings() async {
    try {
      isLoadingSettings.value = true;
      final companyId = await ApiConfig.getCompanyId();
      final data = await _api.getCompanySettings(companyId);
      final company = data['company'] ?? {};
      final modifications = company['modifications'] ?? {};
      otpRequired.value = modifications['otpRequired'] == true;
      mobileRequired.value = modifications['mobileRequired'] == true;
      idProofRequired.value = modifications['idProofRequired'] == true;
    } catch (_) {
      // Keep defaults on error
    } finally {
      isLoadingSettings.value = false;
    }
  }

  Future<String?> updateModification(String key, bool value) async {
    try {
      final companyId = await ApiConfig.getCompanyId();
      await _api.updateCompanyModifications(companyId, {key: value});
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> uploadBulkFile() async {
    try {
      final selected = file.value;
      if (selected == null) return 'Please select a file first';
      isUploading.value = true;
      final companyId = await ApiConfig.getCompanyId();
      await _api.uploadBulkEpasses(
          companyId: companyId, filePath: selected.path);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      isUploading.value = false;
    }
  }
}
