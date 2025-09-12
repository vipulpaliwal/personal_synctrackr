import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/reports_statics_chart_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/core/constants/app_barrels.dart';

class ReportsStaticsChart extends GetView<ReportsStaticsChartController> {
  const ReportsStaticsChart({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReportsStaticsChartController());
    final MainController mainController = Get.find();
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Container(
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
            // Title + Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Statistics (Total Visitor)",
                    style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isDarkMode ? Colors.grey : Colors.black,
                          width: 1.5), // border
                      borderRadius: BorderRadius.circular(8), // corner rounded
                    ),
                    child: DropdownButton<String>(
                      isDense: true,
                      dropdownColor: isDarkMode
                          ? adminAppColors.darkChartsBackground
                          : Colors.white,
                      value: controller.selectedFilter.value,
                      items: ["monthly", "weekly", "yearly", "daily"]
                          .map(
                            (f) => DropdownMenuItem(
                              value: f,
                              child: Text(f.capitalizeFirst!,
                                  style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        controller.selectedFilter.value = val!;
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Chart
            Container(
              height: 220,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.errorMessage.value != null
                      ? Center(
                          child: Text(controller.errorMessage.value!),
                        )
                      : Stack(
                          children: [
                            CustomPaint(
                              painter: VisitorChartPainter(
                                hoveredIndex: controller.hoveredIndex.value,
                                values: controller.chartData[
                                    controller.selectedFilter.value]!,
                                labels: controller.chartLabels[
                                    controller.selectedFilter.value]!,
                                individualValues: controller
                                    .chartIndividualCounts[
                                        controller.selectedFilter.value]!
                                    .toList(),
                                isDarkMode: isDarkMode,
                              ),
                              size: Size.infinite,
                            ),
                            Row(
                              children: List.generate(
                                  controller
                                      .chartLabels[
                                          controller.selectedFilter.value]!
                                      .length, (index) {
                                return Expanded(
                                  child: MouseRegion(
                                    onEnter: (_) =>
                                        controller.hoveredIndex.value = index,
                                    onExit: (_) =>
                                        controller.hoveredIndex.value = null,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (controller.hoveredIndex.value ==
                                            index) {
                                          controller.navigateToReportsScreen(
                                              controller.chartLabels[controller
                                                  .selectedFilter
                                                  .value]![index]);
                                        } else {
                                          controller.hoveredIndex.value = index;
                                        }
                                      },
                                      child:
                                          Container(color: Colors.transparent),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
            ),
          ],
        ),
      );
    });
  }
}

// ------------------- Painter -------------------
class VisitorChartPainter extends CustomPainter {
  final int? hoveredIndex;
  final List<double> values; // 0–1 scale
  final List<String> labels;
  final List<String> individualValues;
  final bool isDarkMode;

  VisitorChartPainter({
    required this.hoveredIndex,
    required this.values,
    required this.labels,
    required this.individualValues,
    required this.isDarkMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = isDarkMode ? Color(0xffbbd2ff) : Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(0, size.height);

    if (values.length == 1) {
      double dy = size.height * (1 - values[0]);
      path.lineTo(size.width, dy);
      path.lineTo(size.width, size.height);
    } else {
      double columnWidth = size.width / (values.length - 1);

      for (int i = 0; i < values.length; i++) {
        double dx = columnWidth * i;
        double dy = size.height * (1 - values[i]);

        if (i == 0) {
          path.lineTo(dx, dy);
        } else {
          double prevDx = columnWidth * (i - 1);
          double prevDy = size.height * (1 - values[i - 1]);

          path.quadraticBezierTo(
            (prevDx + dx) / 2,
            (prevDy + dy) / 2,
            dx,
            dy,
          );
        }
      }
      path.lineTo(size.width, size.height);
    }
    path.close();
    canvas.drawPath(path, paint);

    // Divider lines
    final dividerPaint = Paint()
      ..color = isDarkMode ? Colors.black : Colors.white
      ..strokeWidth = 2.5;
    double columnWidth2 = size.width / labels.length;
    for (int i = 1; i < labels.length; i++) {
      double dx = columnWidth2 * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), dividerPaint);
    }

    // Labels
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < labels.length; i++) {
      double xCenter = columnWidth2 * i + columnWidth2 / 2;

      if (i == hoveredIndex) {
        Rect highlightRect = Rect.fromLTWH(
          columnWidth2 * i,
          0,
          columnWidth2,
          size.height,
        );
        Paint highlightPaint = Paint()
          ..color = isDarkMode
              ? adminAppColors.darkMainButton.withOpacity(0.08)
              : Colors.blue.withOpacity(0.08)
          ..style = PaintingStyle.fill;
        canvas.drawRect(highlightRect, highlightPaint);
      }

      textPainter.text = TextSpan(
        text: labels[i],
        style: TextStyle(
          color: i == hoveredIndex
              ? (isDarkMode ? adminAppColors.darkMainButton : Colors.blue)
              : isDarkMode
                  ? Colors.white
                  : Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout(maxWidth: columnWidth2);
      textPainter.paint(canvas, Offset(xCenter - textPainter.width / 2, 10));

      textPainter.text = TextSpan(
        text: individualValues[i],
        style: GoogleFonts.lexend(
          color: i == hoveredIndex
              ? (isDarkMode ? adminAppColors.darkMainButton : Colors.blue)
              : isDarkMode
                  ? Colors.white
                  : Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout(maxWidth: columnWidth2);
      textPainter.paint(canvas, Offset(xCenter - textPainter.width / 2, 30));

      if (i == hoveredIndex) {
        textPainter.text = TextSpan(
          text: "Details →",
          style: GoogleFonts.lexend(
              color: isDarkMode ? adminAppColors.darkMainButton : Colors.blue,
              fontSize: 11),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(xCenter - textPainter.width / 2, 50));
      }
    }
  }

  @override
  bool shouldRepaint(covariant VisitorChartPainter oldDelegate) {
    return oldDelegate.hoveredIndex != hoveredIndex ||
        oldDelegate.values != values;
  }
}
