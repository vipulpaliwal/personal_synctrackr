import 'dart:ui'; // <- for ImageFilter

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';
import 'package:synctrackr/admin/widgets/employee_list.dart';

class LiveFeed extends StatelessWidget {
  const LiveFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find();
    final MainController mainController = Get.find();

    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;

      // ✅ Container ko variable me store kiya
      final container = Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.black.withOpacity(0.7)
              : Colors.white.withOpacity(0.35), // semi-transparent bg
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDarkMode
                ? adminAppColors.darkBorder
                : Colors.white, // light glass border
            width: 4,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Live Feed',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : adminAppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                ImageIcon(
                  AssetImage(AllImages.arrowRight),
                  color: isDarkMode
                      ? adminAppColors.darkTextPrimary
                      : adminAppColors.textPrimary,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Recent Visits',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDarkMode
                    ? adminAppColors.darkTextSecondary
                    : const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 300,
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.fetchLiveFeed();
                },
                child: Obx(() {
                  final isLoading = controller.isLiveFeedLoading.value;
                  final hasError = controller.liveFeedError.value.isNotEmpty;

                  // Prefer showing previously loaded data if available
                  final hasData = controller.liveFeedItems.isNotEmpty;

                  // Compute filtered list once
                  final filteredFeed = controller.liveFeedItems.where((item) {
                    final status = item.status.toLowerCase();
                    return status == 'checked-in' || status == 'checked-out';
                  }).toList();

                  // If no data yet, fall back to loading/error/empty
                  if (!hasData || filteredFeed.isEmpty) {
                    if (isLoading) {
                      return _buildLoadingState(isDarkMode);
                    }
                    if (hasError) {
                      return _buildErrorState(
                        controller.liveFeedError.value,
                        isDarkMode,
                        () {
                          controller.fetchLiveFeed();
                        },
                      );
                    }
                    return _buildEmptyState(isDarkMode);
                  }

                  // Show data; overlay subtle indicators for loading/error
                  return ListView(
                    shrinkWrap: true,
                    children: filteredFeed
                        .asMap()
                        .entries
                        .map((entry) => _buildLiveFeedItem(
                              entry.value,
                              isDarkMode,
                              key: ValueKey(
                                  'live_feed_${entry.key}_${entry.value.name}_${entry.value.time}'),
                            ))
                        .toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      );

      // ✅ Blur sirf light mode me apply hoga
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

  Widget _buildLiveFeedItem(LiveFeedItem item, bool isDarkMode, {Key? key}) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(item.status, isDarkMode, true),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _getStatusDisplayText(item.status),
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _getStatusColor(item.status, isDarkMode, false),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalizeWords(item.name),
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : adminAppColors.textPrimary,
                  ),
                ),
                if (item.company != null && item.company!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.company!,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      color: isDarkMode
                          ? adminAppColors.darkTextSecondary
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            item.time,
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

  String _getStatusDisplayText(String status) {
    switch (status.toLowerCase()) {
      case 'checked-in':
        return 'IN';
      case 'checked-out':
        return 'OUT';
      case 'pending':
        return 'PENDING';
      case 'accepted':
        return 'ACCEPTED';
      default:
        return status.toUpperCase();
    }
  }

  Color _getStatusColor(String status, bool isDarkMode, bool isBackground) {
    switch (status.toLowerCase()) {
      case 'checked-in':
      case 'in':
        return isBackground
            ? (isDarkMode
                ? Colors.green.withOpacity(0.2)
                : const Color(0xFFD1FAE5))
            : (isDarkMode ? Colors.green : const Color(0xFF065F46));
      case 'checked-out':
      case 'out':
        return isBackground
            ? (isDarkMode
                ? Colors.red.withOpacity(0.2)
                : const Color(0xFFFEE2E2))
            : (isDarkMode ? Colors.red : const Color(0xFF991B1B));
      case 'accepted':
        return isBackground
            ? (isDarkMode
                ? adminAppColors.darkSuccess.withOpacity(0.2)
                : const Color(0xFFD1FAE5))
            : (isDarkMode
                ? adminAppColors.darkSuccess
                : const Color(0xFF30BE824D));
      case 'pending':
        return isBackground
            ? (isDarkMode
                ? adminAppColors.darkWarning.withOpacity(0.2)
                : const Color(0xFFFEF3C7))
            : (isDarkMode
                ? adminAppColors.darkWarning
                : const Color(0xFFD97706));
      default:
        return isBackground
            ? (isDarkMode
                ? adminAppColors.darkTextSecondary.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1))
            : (isDarkMode
                ? adminAppColors.darkTextSecondary
                : const Color(0xFF6B7280));
    }
  }

  Widget _buildLoadingState(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
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
              'Loading live feed...',
              style: GoogleFonts.lexend(
                fontSize: 14,
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

  Widget _buildErrorState(String error, bool isDarkMode, VoidCallback onRetry) {
    return GestureDetector(
      onTap: onRetry,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.error_outline,
                size: 32,
                color: isDarkMode ? adminAppColors.darkWarning : Colors.red,
              ),
              const SizedBox(height: 12),
              Text(
                'Failed to load live feed',
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
      ),
    );
  }

  Widget _buildEmptyState(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
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
              'No recent activity',
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
              'Visitor activity will appear here',
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

}
