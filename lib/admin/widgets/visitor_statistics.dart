

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';

class VisitorStatistics extends StatelessWidget {
  final DashboardController controller = Get.find();

  VisitorStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:
              isDarkMode ? adminAppColors.darkChartsBackground : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: adminAppColors.textPrimary.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Visitor Statistic',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : adminAppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                // Dropdown Button
                Obx(() => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? adminAppColors.darkBackground
                            : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButton<String>(
                        value: controller.selectedStatRange.value,
                        icon: Icon(Icons.arrow_drop_down,
                            color: isDarkMode
                                ? adminAppColors.darkTextSecondary
                                : const Color(0xFF374151)),
                        iconSize: 24,
                        elevation: 16,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: isDarkMode
                              ? adminAppColors.darkTextSecondary
                              : const Color(0xFF374151),
                        ),
                        underline: const SizedBox(), // Hides the underline
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.changeStatRange(newValue);
                          }
                        },
                        items: <String>['Weekly', 'Monthly', 'Daily']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 188,
              child: _buildChart(isDarkMode),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildChart(bool isDarkMode) {
    final stats = controller.visitorStats;
    final isLoading = controller.isStatsLoading.value;

    // If there's no data at all, then decide whether to show loading or empty state.
    if (stats.isEmpty) {
      if (isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Center(
          child: Text(
            'No visitor data for this period.',
            style: GoogleFonts.inter(
              color: isDarkMode
                  ? adminAppColors.darkTextSecondary
                  : const Color(0xFF6B7280),
              fontSize: 14,
            ),
          ),
        );
      }
    }

    // Create fixed 7 bars for weekly, 12 for monthly, 1 for daily
    final fixedData = _getFixedChartData(stats, controller.selectedStatRange.value);

    // Calculate maxY based on the aggregated data
    final maxValue = fixedData.isEmpty ? 0 : fixedData.reduce((a, b) => a > b ? a : b);
    final maxY = maxValue > 0 ? (maxValue * 1.2).ceil().toDouble() : 10.0;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final count = rod.toY.toInt();
              String periodLabel = '';

              switch (controller.selectedStatRange.value) {
                case 'Weekly':
                  const weekLabels = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
                  periodLabel = weekLabels[groupIndex];
                  break;
                case 'Monthly':
                  const monthLabels = ['January', 'February', 'March', 'April', 'May', 'June',
                                     'July', 'August', 'September', 'October', 'November', 'December'];
                  periodLabel = monthLabels[groupIndex];
                  break;
                case 'Daily':
                  periodLabel = 'Today';
                  break;
              }

              return BarTooltipItem(
                '$periodLabel\n$count ${count == 1 ? 'visitor' : 'visitors'}',
                GoogleFonts.lexend(
                  color: isDarkMode
                      ? adminAppColors.darkTextPrimary
                      : adminAppColors.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                return _buildFixedBottomTitle(index, controller.selectedStatRange.value, isDarkMode);
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value % _getYAxisInterval(maxY) != 0) {
                  return Container();
                }
                return Text(
                  value.toInt().toString(),
                  style: GoogleFonts.inter(
                    color: isDarkMode
                        ? adminAppColors.darkTextSecondary
                        : const Color(0xFF6B7280),
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: fixedData.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: value,
                color: isDarkMode ? adminAppColors.darkPrimary : const Color(0xFF3B82F6),
                width: _getBarWidth(controller.selectedStatRange.value),
                borderRadius: BorderRadius.circular(4),
              )
            ],
          );
        }).toList(),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _getYAxisInterval(maxY),
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: isDarkMode
                  ? adminAppColors.darkTextSecondary.withOpacity(0.1)
                  : const Color(0xFF6B7280).withOpacity(0.1),
              strokeWidth: 1,
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomTitle(String date, String range, bool isDarkMode) {
    String displayText;
    try {
      final dateTime = DateTime.parse(date);
      switch (range) {
        case 'Weekly':
          displayText = _getWeekdayAbbrev(dateTime.weekday);
          break;
        case 'Monthly':
          displayText = _getMonthName(dateTime.month);
          break;
        case 'Daily':
          displayText = dateTime.day.toString();
          break;
        default:
          displayText = date;
      }
    } catch (e) {
      displayText = date;
    }

    return Text(
      displayText,
      style: GoogleFonts.inter(
        color: isDarkMode
            ? adminAppColors.darkTextSecondary
            : const Color(0xFF6B7280),
        fontSize: 10,
      ),
    );
  }

  String _getWeekdayAbbrev(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  double _getYAxisInterval(double maxY) {
    if (maxY <= 10) return 2;
    if (maxY <= 50) return 10;
    if (maxY <= 100) return 20;
    if (maxY <= 500) return 100;
    return 200;
  }

  List<double> _getFixedChartData(Map<String, int> stats, String range) {
    switch (range) {
      case 'Weekly':
        return _getWeeklyData(stats);
      case 'Monthly':
        return _getMonthlyData(stats);
      case 'Daily':
        return _getDailyData(stats);
      default:
        return _getWeeklyData(stats);
    }
  }

  List<double> _getWeeklyData(Map<String, int> stats) {
    // Always return 7 values for 7 days of the week
    final List<double> weeklyData = List.filled(7, 0.0);

    // Map API data to the correct day positions
    stats.forEach((date, count) {
      try {
        final dateTime = DateTime.parse(date);
        final weekday = dateTime.weekday; // 1 = Monday, 7 = Sunday
        // Convert to our array index (0 = Sunday, 6 = Saturday)
        final index = (weekday % 7);
        weeklyData[index] = count.toDouble();
      } catch (e) {
        // If date parsing fails, skip this entry
      }
    });

    return weeklyData;
  }

  List<double> _getMonthlyData(Map<String, int> stats) {
    // Always return 12 values for 12 months
    final List<double> monthlyData = List.filled(12, 0.0);

    // Aggregate daily data by month for the current year
    stats.forEach((date, count) {
      try {
        final dateTime = DateTime.parse(date);
        final month = dateTime.month - 1; // 0-based index (September = 8)
        if (month >= 0 && month < 12) {
          monthlyData[month] += count.toDouble();
        }
      } catch (e) {
        // If date parsing fails, skip this entry
      }
    });

    return monthlyData;
  }

  List<double> _getDailyData(Map<String, int> stats) {
    // For daily, show only today's data
    final today = DateTime.now();
    final todayKey = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    final todayValue = stats[todayKey]?.toDouble() ?? 0.0;
    return [todayValue];
  }

  Widget _buildFixedBottomTitle(int index, String range, bool isDarkMode) {
    String displayText;

    switch (range) {
      case 'Weekly':
        // S M T W T F S (Sunday to Saturday)
        const weekLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
        displayText = index < weekLabels.length ? weekLabels[index] : '';
        break;
      case 'Monthly':
        // Jan, Feb, Mar, etc.
        const monthLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                           'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        displayText = index < monthLabels.length ? monthLabels[index] : '';
        break;
      case 'Daily':
        // Just show "Today" for the single bar
        displayText = index == 0 ? 'Today' : '';
        break;
      default:
        displayText = '';
    }

    return Text(
      displayText,
      style: GoogleFonts.inter(
        color: isDarkMode
            ? adminAppColors.darkTextSecondary
            : const Color(0xFF6B7280),
        fontSize: 10,
      ),
    );
  }

  double _getBarWidth(String range) {
    switch (range) {
      case 'Weekly':
        return 24; // 7 bars, wider
      case 'Monthly':
        return 16; // 12 bars, medium
      case 'Daily':
        return 40; // 1 bar, very wide
      default:
        return 20;
    }
  }
}
