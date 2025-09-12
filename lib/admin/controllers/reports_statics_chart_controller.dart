import 'package:get/get.dart';
import 'package:synctrackr/admin/config/api_config.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/services/api_services.dart';

class ReportsStaticsChartController extends GetxController {
  final ApiService _apiService = ApiService();

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

  // Store raw data for each filter type
  final RxMap<String, List<Map<String, dynamic>>> rawData = RxMap({
    "monthly": <Map<String, dynamic>>[].obs,
    "weekly": <Map<String, dynamic>>[].obs,
    "yearly": <Map<String, dynamic>>[].obs,
    "daily": <Map<String, dynamic>>[].obs,
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
        rawData[selectedFilter.value]?.clear();
        totalCounts[selectedFilter.value] = "0";
        return;
      }

      // Store raw data
      rawData[selectedFilter.value]?.assignAll(data);

      List<String> labels;
      List<double> values;
      List<Map<String, dynamic>> preparedRaw;

      if (selectedFilter.value == 'monthly') {
        // Group all entries by month (YYYY-MM) and sum counts
        final Map<String, double> monthToSum = {};
        for (final item in data) {
          final date = DateTime.parse(item['date']);
          final key = '${date.year}-${date.month.toString().padLeft(2, '0')}';
          final count = (item['count'] as num).toDouble();
          monthToSum.update(key, (v) => v + count, ifAbsent: () => count);
        }

        // Sort by chronological month key
        final sortedKeys = monthToSum.keys.toList()
          ..sort((a, b) => a.compareTo(b));

        labels = sortedKeys.map((k) {
          final parts = k.split('-');
          final year = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          // Label with month abbreviation (and year if spanning multiple years)
          final monthName = _getMonthName(month);
          final spansMultipleYears = monthToSum.keys
                  .map((e) => int.parse(e.split('-')[0]))
                  .toSet()
                  .length >
              1;

          return spansMultipleYears ? '$monthName $year' : monthName;
        }).toList();

        values = sortedKeys.map((k) => monthToSum[k]!).toList();
        preparedRaw = [
          for (int i = 0; i < sortedKeys.length; i++)
            {
              'date': sortedKeys[i],
              'count': values[i].toInt(),
            }
        ];
      } else {
        // Original behavior for other filters
        labels = data.map<String>((item) {
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
          } else if (selectedFilter.value == 'yearly') {
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
          } else {
            return item['date'] as String;
          }
        }).toList();

        values = data.map((item) => (item['count'] as num).toDouble()).toList();
        preparedRaw =
            data.map((e) => {'date': e['date'], 'count': e['count']}).toList();
      }

      final formattedIndividualCounts =
          values.map((v) => _formatNumber(v)).toList();

      final maxValue =
          values.isEmpty ? 0 : values.reduce((a, b) => a > b ? a : b);
      final normalizedValues =
          maxValue == 0 ? values : values.map((v) => v / maxValue).toList();

      chartData[selectedFilter.value]?.assignAll(normalizedValues);
      chartLabels[selectedFilter.value]?.assignAll(labels);
      chartIndividualCounts[selectedFilter.value]
          ?.assignAll(formattedIndividualCounts);
      rawData[selectedFilter.value]?.assignAll(preparedRaw);
      totalCounts[selectedFilter.value] = "";
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void navigateToReportsScreen(String label) {
    final mainController = Get.find<MainController>();

    // Find the corresponding data for the clicked label
    final currentFilter = selectedFilter.value;
    final labels = chartLabels[currentFilter]!;
    final index = labels.indexOf(label);

    if (index != -1 && index < rawData[currentFilter]!.length) {
      final selectedData = rawData[currentFilter]![index];
      final count = selectedData['count'] as num;

      // Create a more descriptive title based on the filter type
      String title;
      if (currentFilter == 'daily') {
        title = 'Today Visitors';
      } else if (currentFilter == 'weekly') {
        title = '$label Visitors';
      } else if (currentFilter == 'monthly') {
        // For monthly, the label is the month name
        title = '$label Visitors';
      } else {
        title = '$label Visitors';
      }

      // Store the selected data in main controller
      mainController.setSelectedReportData(
        title: title,
        count: count.toInt(),
        date: selectedData['date'],
        filter: currentFilter,
      );
    } else {
      // Fallback to original behavior
      mainController.selectReportsView(label);
    }
  }

  String _formatNumber(double n) {
    if (n >= 1000000) {
      return '${(n / 1000000).toStringAsFixed(2)}M';
    } else if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(2)}K';
    } else {
      return n.toStringAsFixed(0);
    }
  }

  // Removed unused _getDaySuffix helper

  String _getMonthName(int month) {
    const monthNames = [
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
    return monthNames[month];
  }
}
