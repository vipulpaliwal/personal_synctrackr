import 'dart:convert';
import 'package:get/get.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/services/api_services.dart';

class VisitorDetailsController extends GetxController {
  final ApiService _apiService = ApiService();
  var isLoading = true.obs;
  var visitor = Rxn<Visitor>();
  var errorMessage = ''.obs;
  var signatureImage = Rxn<dynamic>();

  Future<void> fetchVisitorDetails(int visitorId) async {
    try {
      isLoading(true);
      errorMessage('');
      visitor.value = null;
      signatureImage.value = null;

      final data = await _apiService.fetchEnrichedVisitor(visitorId);
      if (data != null && data['success'] == true && data['data'] != null) {
        visitor.value = Visitor.fromJson(data['data']);
        if (visitor.value?.consent?.signature != null) {
          String base64String = visitor.value!.consent!.signature!;
          if (base64String.startsWith('data:image')) {
            base64String = base64String.split(',').last;
          }
          signatureImage.value = base64Decode(base64.normalize(base64String));
        }
      } else {
        errorMessage('This visitor\'s details are not available in the database.');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
