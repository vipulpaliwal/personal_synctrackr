import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class EPassController extends GetxController {
  RxString passType = 'Guest Pass'.obs;
  RxString uploadedFileName = ''.obs;

  RxString fullName = ''.obs;
  RxString email = ''.obs;
  RxString department = ''.obs;
  RxString designation = ''.obs;

  void setPassType(String? type) {
    if (type != null) {
      passType.value = type;
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx', 'xls'],
    );

    if (result != null) {
      uploadedFileName.value = result.files.single.name;
    }
  }

  void removeFile() {
    uploadedFileName.value = '';
  }

  void generatePass() {
    // Implement logic for pass generation
    print('Pass Type: ${passType.value}');
    print('Full Name: ${fullName.value}');
    print('Email: ${email.value}');
    print('Department: ${department.value}');
    print('Designation: ${designation.value}');
  }
}
