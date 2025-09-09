// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
// import 'package:synctrackr/admin/utils/colors.dart';

// class VisitorStatistics extends StatelessWidget {
//   final DashboardController controller = Get.find();

//   VisitorStatistics({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.textPrimary.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 'Visitor Statistic',
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const Spacer(),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF3F4F6),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Text(
//                   'This week',
//                   style: GoogleFonts.inter(
//                     fontSize: 12,
//                     color: const Color(0xFF374151),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),
//           SizedBox(
//             height: 280,
//             child: BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.spaceAround,
//                 maxY: 400,
//                 barTouchData: BarTouchData(enabled: false),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         const titles = ['M', 'T', 'W', 'Th', 'F', 'S'];
//                         return Text(
//                           titles[value.toInt()],
//                           style: GoogleFonts.inter(
//                             color: const Color(0xFF6B7280),
//                             fontSize: 12,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 40,
//                       getTitlesWidget: (value, meta) {
//                         if (value % 100 != 0) {
//                           return Container();
//                         }
//                         return Text(
//                           value.toInt().toString(),
//                           style: GoogleFonts.inter(
//                             color: const Color(0xFF6B7280),
//                             fontSize: 12,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   topTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false)),
//                   rightTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false)),
//                 ),
//                 borderData: FlBorderData(show: false),
//                 barGroups: controller.statistics
//                     .asMap()
//                     .entries
//                     .map((entry) => BarChartGroupData(x: entry.key, barRods: [
//                           BarChartRodData(
//                               toY: entry.value.value.toDouble(),
//                               color: const Color(0xFF3B82F6),
//                               width: 20,
//                               borderRadius: BorderRadius.circular(4))
//                         ]))
//                     .toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//updated1

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
                        items: <String>['This Week', 'This Month', 'This Year', 'All']
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
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 400,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ['M', 'T', 'W', 'Th', 'F', 'S'];
                          final index = value.toInt();
                          if (index < 0 || index >= titles.length) {
                            return Container();
                          }
                          return Text(
                            titles[index],
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
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          if (value % 100 != 0) {
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
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: controller.visitorStats.entries
                      .toList()
                      .asMap()
                      .entries
                      .map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return BarChartGroupData(x: index, barRods: [
                      BarChartRodData(
                          toY: data.value.toDouble(),
                          color: isDarkMode
                              ? adminAppColors.darkPrimary
                              : const Color(0xFF3B82F6),
                          width: 20,
                          borderRadius: BorderRadius.circular(4))
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
