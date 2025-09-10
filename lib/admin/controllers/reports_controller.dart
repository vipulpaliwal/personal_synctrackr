import 'package:get/get.dart';
import 'package:synctrackr/admin/config/api_config.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/services/api_services.dart';

class ReportsController extends GetxController {
  final ApiService _apiService = ApiService();
  final String companyId = ApiConfig.defaultCompanyId;
  final List<String> months = ["July", "Aug", "Sep", "Oct", "Nov", "Dec"];
  var hoveredMonth = RxnString();
  var selectedFilter = "monthly".obs;

  var isLoading = true.obs;
  var errorMessage = RxnString();

  // Chart points for demo (0 to 1 scale)
  final RxMap<String, List<double>> chartData = RxMap({
    "monthly": <double>[].obs,
    "weekly": <double>[].obs,
    "yearly": <double>[].obs,
    "daily": <double>[].obs,
  });

  @override
  void onInit() {
    super.onInit();
    fetchChartData();
    selectedFilter.listen((_) => fetchChartData());
  }

  Future<void> fetchChartData() async {
    try {
      isLoading(true);
      final data =
          await _apiService.getStatsSeries(companyId, selectedFilter.value);

      if (data.isEmpty) {
        chartData[selectedFilter.value]?.clear();
        return;
      }

      final values =
          data.map((item) => (item['count'] as num).toDouble()).toList();

      final maxValue = values.reduce((a, b) => a > b ? a : b);
      final normalizedValues =
          maxValue == 0 ? values : values.map((v) => v / maxValue).toList();

      chartData[selectedFilter.value]?.assignAll(normalizedValues);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void navigateToReportsScreen(String month) {
    final mainController = Get.find<MainController>();
    mainController.selectReportsView(month);
  }
}
