import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class OthersController extends GetxController {
  var file = Rx<File?>(null);
  var dragging = false.obs;

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
}
