import 'package:get/get.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/api_config.dart';

class ReportsViewController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = true.obs;
  var errorMessage = RxnString();
  var recurringPercentage = 0.0.obs;
  var oneTimePercentage = 0.0.obs;
  var totalRecurringVisitors = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReturningVisitors();
  }

  Future<void> fetchReturningVisitors() async {
    try {
      isLoading(true);
      final companyId = await ApiConfig.getCompanyId();
      final data = await _apiService.getReturningVisitors(companyId);
      
      if (data.isNotEmpty) {
        int recurringCount = 0;
        data.forEach((visitor) {
          if (visitor['visitCount'] > 1) {
            recurringCount++;
          }
        });

        totalRecurringVisitors.value = recurringCount;
        recurringPercentage.value = recurringCount / data.length;
        oneTimePercentage.value = 1.0 - recurringPercentage.value;
      } else {
        totalRecurringVisitors.value = 0;
        recurringPercentage.value = 0.0;
        oneTimePercentage.value = 1.0;
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
