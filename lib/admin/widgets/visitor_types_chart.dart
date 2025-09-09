// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/utils/colors.dart';

// class VisitorTypesChart extends StatelessWidget {
//   const VisitorTypesChart({super.key});

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
//                 'Types of Visitors',
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
//                   'This month',
//                   style: GoogleFonts.inter(
//                     fontSize: 12,
//                     color: const Color(0xFF374151),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),
//           Center(
//             child: SizedBox(
//               width: 150,
//               height: 150,
//               child: PieChart(
//                 PieChartData(
//                   sections: [
//                     PieChartSectionData(
//                       color: const Color(0xFF8B5CF6),
//                       value: 80,
//                       title: '',
//                       radius: 25,
//                     ),
//                     PieChartSectionData(
//                       color: const Color(0xFF06B6D4),
//                       value: 50,
//                       title: '',
//                       radius: 25,
//                     ),
//                     PieChartSectionData(
//                       color: const Color(0xFFF59E0B),
//                       value: 20,
//                       title: '',
//                       radius: 25,
//                     ),
//                     PieChartSectionData(
//                       color: const Color(0xFF10B981),
//                       value: 10,
//                       title: '',
//                       radius: 25,
//                     ),
//                   ],
//                   sectionsSpace: 0,
//                   centerSpaceRadius: 50,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           ..._buildLegendItems(),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildLegendItems() {
//     final items = [
//       {'color': const Color(0xFF8B5CF6), 'type': 'Meeting', 'percentage': '80%'},
//       {'color': const Color(0xFF06B6D4), 'type': 'Vendor', 'percentage': '50%'},
//       {
//         'color': const Color(0xFFF59E0B),
//         'type': 'Interview',
//         'percentage': '20%'
//       },
//       {
//         'color': const Color(0xFF10B981),
//         'type': 'Delivery',
//         'percentage': '10%'
//       },
//     ];

//     return items
//         .map((item) => Container(
//               margin: const EdgeInsets.only(bottom: 8),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 12,
//                     height: 12,
//                     decoration: BoxDecoration(
//                       color: item['color'] as Color,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     item['type'] as String,
//                     style: GoogleFonts.inter(
//                       fontSize: 14,
//                       color: const Color(0xFF374151),
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     item['percentage'] as String,
//                     style: GoogleFonts.inter(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ))
//         .toList();
//   }
// }

//updated2

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/controllers/dashboard_controller.dart'; // Import your controller
// import 'package:synctrackr/admin/utils/colors.dart';

// class VisitorTypesChart extends StatelessWidget {
//   const VisitorTypesChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Find the controller instance
//     final DashboardController controller = Get.find();

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
//                 'Types of Visitors',
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const Spacer(),
//               // Replace the Text with a DropdownButton
//               Obx(() => Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF3F4F6),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: DropdownButton<String>(
//                       value: controller.selectedVisitorTimePeriod.value,
//                       icon: const Icon(Icons.arrow_drop_down),
//                       iconSize: 24,
//                       elevation: 16,
//                       style: GoogleFonts.inter(
//                         fontSize: 12,
//                         color: const Color(0xFF374151),
//                       ),
//                       underline: const SizedBox(), // Hides the underline
//                       onChanged: (String? newValue) {
//                         if (newValue != null) {
//                           controller.updateVisitorTimePeriod(newValue);
//                         }
//                       },
//                       items: <String>[
//                         'This Month',
//                         'Last Month',
//                         'This Year',
//                         'All Time'
//                       ].map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                   )),
//             ],
//           ),
//           const SizedBox(height: 24),
//           Center(
//             child: SizedBox(
//               width: 150,
//               height: 150,
//               child: PieChart(
//                 PieChartData(
//                   sections: [
//                     PieChartSectionData(
//                       color: const Color(0xFF8B5CF6),
//                       value: 80,
//                       title: '',
//                       radius: 25,
//                     ),
//                     PieChartSectionData(
//                       color: const Color(0xFF06B6D4),
//                       value: 50,
//                       title: '',
//                       radius: 25,
//                     ),
//                     PieChartSectionData(
//                       color: const Color(0xFFF59E0B),
//                       value: 20,
//                       title: '',
//                       radius: 25,
//                     ),
//                     PieChartSectionData(
//                       color: const Color(0xFF10B981),
//                       value: 10,
//                       title: '',
//                       radius: 25,
//                     ),
//                   ],
//                   sectionsSpace: 0,
//                   centerSpaceRadius: 50,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           ..._buildLegendItems(),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildLegendItems() {
//     final items = [
//       {'color': const Color(0xFF8B5CF6), 'type': 'Meeting', 'percentage': '80%'},
//       {'color': const Color(0xFF06B6D4), 'type': 'Vendor', 'percentage': '50%'},
//       {'color': const Color(0xFFF59E0B), 'type': 'Interview', 'percentage': '20%'},
//       {'color': const Color(0xFF10B981), 'type': 'Delivery', 'percentage': '10%'},
//     ];

//     return items
//         .map((item) => Container(
//               margin: const EdgeInsets.only(bottom: 8),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 12,
//                     height: 12,
//                     decoration: BoxDecoration(
//                       color: item['color'] as Color,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     item['type'] as String,
//                     style: GoogleFonts.inter(
//                       fontSize: 14,
//                       color: const Color(0xFF374151),
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     item['percentage'] as String,
//                     style: GoogleFonts.inter(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ))
//         .toList();
//   }
// }

//updated3

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
// import 'package:synctrackr/admin/utils/colors.dart';

// class VisitorTypesChart extends StatelessWidget {
//   const VisitorTypesChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final DashboardController controller = Get.find();

//     return Container(
//       height: 300,
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
//                 'Types of Visitors',
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const Spacer(),
//               Obx(() => Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF3F4F6),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: DropdownButton<String>(
//                       value: controller.selectedVisitorTimePeriod.value,
//                       icon: const Icon(Icons.arrow_drop_down),
//                       iconSize: 24,
//                       elevation: 16,
//                       style: GoogleFonts.inter(
//                         fontSize: 12,
//                         color: const Color(0xFF374151),
//                       ),
//                       underline: const SizedBox(),
//                       onChanged: (String? newValue) {
//                         if (newValue != null) {
//                           controller.updateVisitorTimePeriod(newValue);
//                         }
//                       },
//                       items: <String>[
//                         'This Month',
//                         'Last month',
//                         'This year',
//                         'All time'
//                       ].map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                   )),
//             ],
//           ),
//           const SizedBox(height: 24),
//           // Align the chart and legend vertically
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center, // This is the key change
//             children: [
//               SizedBox(
//                 width: 150,
//                 height: 150,
//                 child: PieChart(
//                   PieChartData(
//                     sections: [
//                       PieChartSectionData(
//                         color: const Color(0xFF8B5CF6),
//                         value: 80,
//                         title: '',
//                         radius: 25,
//                       ),
//                       PieChartSectionData(
//                         color: const Color(0xFF06B6D4),
//                         value: 50,
//                         title: '',
//                         radius: 25,
//                       ),
//                       PieChartSectionData(
//                         color: const Color(0xFFF59E0B),
//                         value: 20,
//                         title: '',
//                         radius: 25,
//                       ),
//                       PieChartSectionData(
//                         color: const Color(0xFF10B981),
//                         value: 10,
//                         title: '',
//                         radius: 25,
//                       ),
//                     ],
//                     sectionsSpace: 0,
//                     centerSpaceRadius: 50,
//                     pieTouchData: PieTouchData(enabled: false),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start, // Align legend text to the left
//                   children: _buildLegendItems(),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildLegendItems() {
//     final items = [
//       {'color': const Color(0xFF8B5CF6), 'type': 'Meeting', 'percentage': '80%'},
//       {'color': const Color(0xFF06B6D4), 'type': 'Vendor', 'percentage': '50%'},
//       {'color': const Color(0xFFF59E0B), 'type': 'Interview', 'percentage': '20%'},
//       {'color': const Color(0xFF10B981), 'type': 'Delivery', 'percentage': '10%'},
//     ];

//     return items
//         .map((item) => Container(
//               margin: const EdgeInsets.only(bottom: 8),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 12,
//                     height: 12,
//                     decoration: BoxDecoration(
//                       color: item['color'] as Color,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       item['type'] as String,
//                       style: GoogleFonts.inter(
//                         fontSize: 14,
//                         color: const Color(0xFF374151),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     item['percentage'] as String,
//                     style: GoogleFonts.inter(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ))
//         .toList();
//   }
// }

// updated 5
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
// import 'package:synctrackr/admin/utils/colors.dart';

// class VisitorTypesChart extends StatelessWidget {
//   const VisitorTypesChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final DashboardController controller = Get.find();

//     final List<RadialData> data = [
//       RadialData("Meeting", 0.8, const Color(0xFF8B5CF6)),
//       RadialData("Vendor", 0.5, const Color(0xFF06B6D4)),
//       RadialData("Interview", 0.2, const Color(0xFFF59E0B)),
//       RadialData("Delivery", 0.1, const Color(0xFF10B981)),
//     ];

//     return Container(
//       height: 300,
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
//                 'Types of Visitors',
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const Spacer(),
//               Obx(() => Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF3F4F6),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: DropdownButton<String>(
//                       value: controller.selectedVisitorTimePeriod.value,
//                       icon: const Icon(Icons.arrow_drop_down),
//                       iconSize: 24,
//                       elevation: 16,
//                       style: GoogleFonts.inter(
//                         fontSize: 12,
//                         color: const Color(0xFF374151),
//                       ),
//                       underline: const SizedBox(),
//                       onChanged: (String? newValue) {
//                         if (newValue != null) {
//                           controller.updateVisitorTimePeriod(newValue);
//                         }
//                       },
//                       items: <String>[
//                         'This Month',
//                         'Last month',
//                         'This year',
//                         'All time'
//                       ].map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                   )),
//             ],
//           ),
//           const SizedBox(height: 24),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 160,
//                 height: 160,
//                 child: CustomPaint(
//                   painter: RadialPainter(data),
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: data
//                       .map((item) => Container(
//                             margin: const EdgeInsets.only(bottom: 8),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 12,
//                                   height: 12,
//                                   decoration: BoxDecoration(
//                                     color: item.color,
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     item.label,
//                                     style: GoogleFonts.inter(
//                                       fontSize: 14,
//                                       color: const Color(0xFF374151),
//                                     ),
//                                   ),
//                                 ),
//                                 Text(
//                                   "${(item.percent * 100).toInt()}%",
//                                   style: GoogleFonts.inter(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.textPrimary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RadialData {
//   final String label;
//   final double percent;
//   final Color color;
//   RadialData(this.label, this.percent, this.color);
// }

// class RadialPainter extends CustomPainter {
//   final List<RadialData> data;
//   final double strokeWidth = 12;

//   RadialPainter(this.data);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radiusStep = strokeWidth + 8;

//     for (int i = 0; i < data.length; i++) {
//       final item = data[i];

//       final radius = (i + 1) * radiusStep;

//       // background
//       final bgPaint = Paint()
//         ..color = Colors.grey.shade200
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = strokeWidth;

//       canvas.drawCircle(center, radius, bgPaint);

//       // foreground arc
//       final fgPaint = Paint()
//         ..color = item.color
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = strokeWidth
//         ..strokeCap = StrokeCap.round;

//       final sweepAngle = 2 * 3.1415926535 * item.percent;
//       canvas.drawArc(
//         Rect.fromCircle(center: center, radius: radius),
//         -3.1415926535 / 2,
//         sweepAngle,
//         false,
//         fgPaint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

//updated 6

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';

class VisitorTypesChart extends StatelessWidget {
  const VisitorTypesChart({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find();
    final MainController mainController = Get.find();

    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      final visitorTypesFromApi = controller.visitorTypes;

      final defaultTypes = {
        'Meeting': 0,
        'Vendor': 0,
        'Interview': 0,
        'Delivery': 0,
      };

      final totalVisitors = visitorTypesFromApi.values
          .fold<double>(0.0, (sum, count) => sum + count);

      for (var entry in visitorTypesFromApi.entries) {
        final type = entry.key;
        final count = entry.value;
        if (type.isNotEmpty) {
          final formattedType =
              type[0].toUpperCase() + type.substring(1).toLowerCase();
          if (defaultTypes.containsKey(formattedType)) {
            defaultTypes[formattedType] = count.toInt();
          }
        }
      }

      final chartData = defaultTypes.entries.map((entry) {
        return _VisitorData(
          entry.key,
          totalVisitors > 0 ? (entry.value / totalVisitors) * 100 : 0,
          _getColorForVisitorType(entry.key),
        );
      }).toList();

      final chartDataForChart = chartData.reversed.toList();
      return Container(
        height: 300,
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
                  'Types of Visitors',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : adminAppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Obx(() => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? adminAppColors.darkBackground
                            : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButton<String>(
                        value: controller.selectedVisitorTypeRange.value,
                        icon: Icon(Icons.arrow_drop_down,
                            color: isDarkMode
                                ? adminAppColors.darkTextSecondary
                                : const Color(0xFF374151)),
                        iconSize: 24,
                        elevation: 16,
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          color: isDarkMode
                              ? adminAppColors.darkTextSecondary
                              : const Color(0xFF374151),
                        ),
                        underline: const SizedBox(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.changeVisitorTypeRange(newValue);
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: SfCircularChart(
                    margin: EdgeInsets.zero,
                    series: <CircularSeries>[
                      RadialBarSeries<_VisitorData, String>(
                        dataSource: chartDataForChart,
                        xValueMapper: (_VisitorData data, _) => data.type,
                        yValueMapper: (_VisitorData data, _) => data.value,
                        pointColorMapper: (_VisitorData data, _) => data.color,
                        maximumValue: 100,
                        cornerStyle: CornerStyle.bothCurve,
                        radius: '100%',
                        innerRadius: '30%',
                        gap: '10%',
                        trackColor: isDarkMode
                            ? adminAppColors.darkBorder
                            : Colors.grey.shade100, // baki space grey
                        trackOpacity: 1, // full visible grey
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildLegendItems(chartData, isDarkMode),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Color _getColorForVisitorType(String type) {
    switch (type.toLowerCase()) {
      case 'meeting':
        return adminAppColors.meetingChartColor;
      case 'vendor':
        return adminAppColors.vendorChartColor;
      case 'interview':
        return adminAppColors.interviewChartColor;
      case 'delivery':
        return adminAppColors.deliveryChartColor;
      default:
        return Colors.grey;
    }
  }

  List<Widget> _buildLegendItems(List<_VisitorData> items, bool isDarkMode) {
    return items
        .map((item) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: item.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.type,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: isDarkMode
                            ? adminAppColors.darkTextSecondary
                            : const Color(0xFF374151),
                      ),
                    ),
                  ),
                  Text(
                    "${item.value.toStringAsFixed(0)}%",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode
                          ? adminAppColors.darkTextPrimary
                          : adminAppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ))
        .toList();
  }
}

class _VisitorData {
  final String type;
  final double value;
  final Color color;

  _VisitorData(this.type, this.value, this.color);
}
