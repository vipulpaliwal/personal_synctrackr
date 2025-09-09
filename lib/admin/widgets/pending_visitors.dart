import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';

class PendingVisitors extends StatelessWidget {
  const PendingVisitors({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    final DashboardController dashboardController = Get.find();

    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;

      final container = Container(
        height: 700,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.black.withOpacity(0.7)
              : Colors.white.withOpacity(0.35),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDarkMode ? adminAppColors.darkBorder : Colors.white,
            width: 4,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pending Visitor',
                  style: GoogleFonts.lexend(
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: ImageIcon(
                    const AssetImage(AllImages.arrowRight),
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : Colors.black,
                  ),
                  onPressed: () {
                    dashboardController.fetchPendingVisitors();
                  },
                ),
              ],
            ),
            Text(
              'Recent visit requests',
              style: TextStyle(
                color:
                    isDarkMode ? adminAppColors.darkTextSecondary : Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (dashboardController.isPendingVisitorsLoading.value &&
                  dashboardController.pendingVisitors.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (dashboardController.pendingVisitors.isEmpty) {
                return Center(
                  child: Text(
                    'No pending visitors',
                    style: TextStyle(
                      color: isDarkMode
                          ? adminAppColors.darkTextSecondary
                          : Colors.grey,
                    ),
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: dashboardController.pendingVisitors.length,
                  itemBuilder: (context, index) {
                    final visitor = dashboardController.pendingVisitors[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: visitor.photo != null &&
                                    visitor.photo!.isNotEmpty
                                ? NetworkImage(visitor.photo!)
                                : null,
                            radius: 25,
                            child:
                                visitor.photo == null || visitor.photo!.isEmpty
                                    ? const Icon(Icons.person, size: 25)
                                    : null,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  visitor.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? adminAppColors.darkTextPrimary
                                        : Colors.black,
                                  ),
                                ),
                                Text(
                                  visitor.company ?? '',
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? adminAppColors.darkTextSecondary
                                        : Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Meeting with',
                                style: TextStyle(
                                  color: isDarkMode
                                      ? adminAppColors.darkTextSecondary
                                      : Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                visitor.meetingWith,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? adminAppColors.darkTextPrimary
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                style: TextStyle(
                                  color: isDarkMode
                                      ? adminAppColors.darkTextSecondary
                                      : Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                visitor.time,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? adminAppColors.darkTextPrimary
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Icon(
                            visitor.isApproved
                                ? Icons.check_circle_outline
                                : Icons.cancel_outlined,
                            color: visitor.isApproved
                                ? Colors.lightGreen
                                : Colors.red,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      );

      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: isDarkMode
            ? container
            : BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: container,
              ),
      );
    });
  }
}
