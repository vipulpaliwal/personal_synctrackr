import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';
import 'package:synctrackr/admin/widgets/employee_list.dart';
import 'package:synctrackr/admin/widgets/visitor_types_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ReportsViewScreen extends StatelessWidget {
  const ReportsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find<MainController>();
    final isDarkMode = controller.isDarkMode.value;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: CommonHeader(title: controller.selectedMonth ?? 'Report'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 100,
                            padding: const EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: isDarkMode
                                  ?  adminAppColors.darkSidebar
                                  : const Color(0xFFF3F8FF),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: isDarkMode
                                      ? adminAppColors.secondary
                                      : const Color(0xFFBCD3FF),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.selectedMonth ?? 'Report',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? adminAppColors.darkTextPrimary
                                            : const Color(0xFF282828),
                                        fontSize: 20,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w600,
                                        height: 1.50,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Monthly Visitors',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? adminAppColors.darkTextPrimary
                                            : const Color(0xFF282828),
                                        fontSize: 20,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w300,
                                        height: 1.50,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '8940',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? adminAppColors.darkTextPrimary
                                            : const Color(0xFF282828),
                                        fontSize: 24,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w600,
                                        height: 1.50,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: isDarkMode
                                  ?  adminAppColors.darkSidebar
                                  : const Color(0xFFF3F8FF),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: isDarkMode
                                      ? adminAppColors.secondary
                                      : const Color(0xFFBCD3FF),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Returning Visitors',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? adminAppColors.darkTextPrimary
                                            : const Color(0xFF282828),
                                        fontSize: 16,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w600,
                                        height: 1.50,
                                      ),
                                    ),
                                    Text(
                                      'This month',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white
                                            : const Color(0xFF757575),
                                        fontSize: 12,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w300,
                                        height: 1.50,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircularPercentIndicator(
                                      radius: 60.0,
                                      lineWidth: 13.0,
                                      animation: true,
                                      percent: 0.2,
                                      center: Text(
                                        "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      progressColor: isDarkMode
                                          ? adminAppColors.darkPrimary
                                          : const Color(0xFF3E7FFF),
                                      backgroundColor: isDarkMode
                                          ? adminAppColors.darkBorder
                                          : const Color(0xFFBCD3FF),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '20%',
                                              style: TextStyle(
                                                color: isDarkMode
                                                    ? adminAppColors.darkTextPrimary
                                                    : const Color(0xFF24263D),
                                                fontSize: 16,
                                                fontFamily: 'Lexend',
                                                fontWeight: FontWeight.w600,
                                                height: 1.50,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              width: 12,
                                              height: 12,
                                              decoration: ShapeDecoration(
                                                color: isDarkMode
                                                    ? adminAppColors.darkPrimary
                                                    : const Color(0xFF3E7FFF),
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Recurring',
                                              style: TextStyle(
                                                color: isDarkMode
                                                    ? adminAppColors.darkTextPrimary
                                                    : const Color(0xFF24263D),
                                                fontSize: 16,
                                                fontFamily: 'Lexend',
                                                fontWeight: FontWeight.w300,
                                                height: 1.57,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '80%',
                                              style: TextStyle(
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : const Color(0xFF24263D),
                                                fontSize: 16,
                                                fontFamily: 'Lexend',
                                                fontWeight: FontWeight.w600,
                                                height: 1.50,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              width: 12,
                                              height: 12,
                                              decoration: ShapeDecoration(
                                                color: isDarkMode
                                                    ? adminAppColors.darkBorder
                                                    : const Color(0xFFBCD3FF),
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'One-Time',
                                              style: TextStyle(
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : const Color(0xFF757575),
                                                fontSize: 14,
                                                fontFamily: 'Lexend',
                                                fontWeight: FontWeight.w300,
                                                height: 1.57,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(flex: 1, child: VisitorTypesChart()),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const EmployeeList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
