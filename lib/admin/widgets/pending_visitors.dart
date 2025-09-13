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
import 'package:synctrackr/admin/widgets/employee_list.dart';






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
            Expanded(
              child: Obx(() {
                final isLoading =
                    dashboardController.isPendingVisitorsLoading.value;
                final hasError =
                    dashboardController.pendingVisitorsError.value.isNotEmpty;
                final hasData = dashboardController.pendingVisitors.isNotEmpty;

                if (!hasData) {
                  if (isLoading) {
                    return _buildLoadingState(isDarkMode);
                  }
                  if (hasError) {
                    return _buildErrorState(
                      dashboardController.pendingVisitorsError.value,
                      isDarkMode,
                      () {
                        dashboardController.fetchPendingVisitors();
                      },
                    );
                  }
                  return _buildEmptyState(isDarkMode);
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    dashboardController.fetchPendingVisitors();
                  },
                  child: ListView.builder(
                    itemCount: dashboardController.pendingVisitors.length,
                    itemBuilder: (context, index) {
                      final visitor =
                          dashboardController.pendingVisitors[index];
                      return _buildVisitorItem(visitor, isDarkMode);
                    },
                  ),
                );
              }),
            ),
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

  Widget _buildVisitorItem(PendingVisitor visitor, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                visitor.photo != null && visitor.photo!.isNotEmpty
                    ? NetworkImage(visitor.photo!)
                    : null,
            radius: 25,
            child: visitor.photo == null || visitor.photo!.isEmpty
                ? const Icon(Icons.person, size: 25)
                : null,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalizeWords(visitor.name),
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
            color: visitor.isApproved ? Colors.lightGreen : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              isDarkMode
                  ? adminAppColors.darkTextPrimary
                  : adminAppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Loading pending visitors...',
            style: GoogleFonts.lexend(
              fontSize: 14,
              color: isDarkMode
                  ? adminAppColors.darkTextSecondary
                  : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
      String error, bool isDarkMode, VoidCallback onRetry) {
    return GestureDetector(
      onTap: onRetry,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 32,
              color: isDarkMode ? adminAppColors.darkWarning : Colors.red,
            ),
            const SizedBox(height: 12),
            Text(
              'Failed to load visitors',
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDarkMode
                    ? adminAppColors.darkTextPrimary
                    : adminAppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap to retry',
              style: GoogleFonts.lexend(
                fontSize: 12,
                color: isDarkMode
                    ? adminAppColors.darkTextSecondary
                    : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 32,
            color: isDarkMode
                ? adminAppColors.darkTextSecondary
                : const Color(0xFF6B7280),
          ),
          const SizedBox(height: 12),
          Text(
            'No pending visitors',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDarkMode
                  ? adminAppColors.darkTextPrimary
                  : adminAppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'New visitor requests will appear here',
            style: GoogleFonts.lexend(
              fontSize: 12,
              color: isDarkMode
                  ? adminAppColors.darkTextSecondary
                  : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}
