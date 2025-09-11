import 'package:get/get.dart';
import 'package:synctrackr/admin/config/api_config.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/services/api_services.dart';

class ReportsStaticsChartController extends GetxController {
  final ApiService _apiService = ApiService();

  String _formatNumber(double n) {
    if (n >= 1000000) {
      return '${(n / 1000000).toStringAsFixed(2)}M';
    } else if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(2)}K';
    } else {
      return n.toStringAsFixed(0);
    }
  }

  late String companyId;
  final RxList<String> months = <String>[].obs;
  var hoveredIndex = RxnInt();
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

  final RxMap<String, List<String>> chartLabels = RxMap({
    "monthly": <String>[].obs,
    "weekly": <String>[].obs,
    "yearly": <String>[].obs,
    "daily": <String>[].obs,
  });

  final RxMap<String, List<String>> chartIndividualCounts = RxMap({
    "monthly": <String>[].obs,
    "weekly": <String>[].obs,
    "yearly": <String>[].obs,
    "daily": <String>[].obs,
  });

  final RxMap<String, String> totalCounts = RxMap({
    "monthly": "",
    "weekly": "",
    "yearly": "",
    "daily": "",
  });

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    companyId = await ApiConfig.getCompanyId();
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
        chartLabels[selectedFilter.value]?.clear();
        chartIndividualCounts[selectedFilter.value]?.clear();
        totalCounts[selectedFilter.value] = "0";
        return;
      }

      final labels = data.map((item) {
        final date = DateTime.parse(item['date']);
        if (selectedFilter.value == 'daily') {
          return "Today";
        } else if (selectedFilter.value == 'weekly') {
          const dayAbbreviations = [
            'Mon',
            'Tue',
            'Wed',
            'Thu',
            'Fri',
            'Sat',
            'Sun'
          ];
          return dayAbbreviations[date.weekday - 1];
        } else {
          // monthly or yearly
          const monthAbbreviations = [
            '',
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec'
          ];
          return monthAbbreviations[date.month];
        }
      }).toList();

      final values =
          data.map((item) => (item['count'] as num).toDouble()).toList();

      final formattedIndividualCounts =
          values.map((v) => _formatNumber(v)).toList();

      final maxValue = values.reduce((a, b) => a > b ? a : b);
      final normalizedValues =
          maxValue == 0 ? values : values.map((v) => v / maxValue).toList();

      chartData[selectedFilter.value]?.assignAll(normalizedValues);
      chartLabels[selectedFilter.value]?.assignAll(labels);
      chartIndividualCounts[selectedFilter.value]
          ?.assignAll(formattedIndividualCounts);
      totalCounts[selectedFilter.value] = "";
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
