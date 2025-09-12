// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
// import 'package:synctrackr/admin/utils/colors.dart';
// import 'package:synctrackr/admin/utils/images.dart';

// class LiveFeed extends StatelessWidget {
//   const LiveFeed({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final DashboardController controller = Get.find();
//     return Opacity(
//       opacity: 0.8,
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.textPrimary.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   'Live Feed',
//                   style: GoogleFonts.inter(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 const Spacer(),
//                 // const Icon(CupertinoIcons.arrow_branch, color: Color(0xFF6B7280)),
//                 ImageIcon(AssetImage(AllImages.arrowRight))
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Recent Visits',
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//                 color: const Color(0xFF6B7280),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Obx(() => Column(
//                   children: controller.liveFeed
//                       .map((item) => _buildLiveFeedItem(item))
//                       .toList(),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLiveFeedItem(Map<String, String> item) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: item['status'] == 'IN'
//                   ? const Color(0xFFD1FAE5)
//                   : const Color(0xFFFEE2E2),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(
//               item['status']!,
//               style: GoogleFonts.inter(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: item['status'] == 'IN'
//                     ? const Color(0xFF065F46)
//                     : const Color(0xFF991B1B),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               item['name']!,
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//           ),
//           const Spacer(),
//           Text(
//             item['time']!,
//             style: GoogleFonts.inter(
//               fontSize: 12,
//               color: const Color(0xFF6B7280),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//update1

// import 'dart:ui'; // <- for ImageFilter

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
// import 'package:synctrackr/admin/controllers/main_controller.dart';
// import 'package:synctrackr/admin/utils/colors.dart';
// import 'package:synctrackr/admin/utils/images.dart';

// class LiveFeed extends StatelessWidget {
//   const LiveFeed({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final DashboardController controller = Get.find();
//     final MainController mainController = Get.find();
//     return Obx(() {
//       final isDarkMode = mainController.isDarkMode.value;
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // blur effect
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: isDarkMode
//                   ? adminAppColors.darkCard.withOpacity(0.5)
//                   : Colors.white.withOpacity(0.35), // semi-transparent bg
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: isDarkMode
//                     ? adminAppColors.darkBorder
//                     : Colors.white, // light glass border
//                 width: 4,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'Live Feed',
//                       style: GoogleFonts.lexend(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: isDarkMode
//                             ? adminAppColors.darkTextPrimary
//                             : adminAppColors.textPrimary,
//                       ),
//                     ),
//                     const Spacer(),
//                     ImageIcon(
//                       AssetImage(AllImages.arrowRight),
//                       color: isDarkMode
//                           ? adminAppColors.darkTextPrimary
//                           : adminAppColors.textPrimary,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Recent Visits',
//                   style: GoogleFonts.inter(
//                     fontSize: 14,
//                     color: isDarkMode
//                         ? adminAppColors.darkTextSecondary
//                         : const Color(0xFF6B7280),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Obx(() => Column(
//                       children: controller.liveFeed
//                           .map((item) => _buildLiveFeedItem(item, isDarkMode))
//                           .toList(),
//                     )),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Widget _buildLiveFeedItem(Map<String, String> item, bool isDarkMode) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: item['status'] == 'IN'
//                   ? (isDarkMode
//                       ? adminAppColors.darkSuccess.withOpacity(0.2)
//                       : const Color(0xFFD1FAE5))
//                   : (isDarkMode
//                       ? adminAppColors.darkWarning.withOpacity(0.2)
//                       : const Color(0xFFFEE2E2)),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(
//               item['status']!,
//               style: GoogleFonts.inter(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: item['status'] == 'IN'
//                     ? (isDarkMode
//                         ? adminAppColors.darkSuccess
//                         : const Color(0xFF065F46))
//                     : (isDarkMode
//                         ? adminAppColors.darkWarning
//                         : const Color(0xFF991B1B)),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               item['name']!,
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: isDarkMode
//                     ? adminAppColors.darkTextPrimary
//                     : adminAppColors.textPrimary,
//               ),
//             ),
//           ),
//           const Spacer(),
//           Text(
//             item['time']!,
//             style: GoogleFonts.inter(
//               fontSize: 12,
//               color: isDarkMode
//                   ? adminAppColors.darkTextSecondary
//                   : const Color(0xFF6B7280),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//update 2

import 'dart:ui'; // <- for ImageFilter

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';

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
                    final status = item['status']?.toUpperCase();
                    return status == 'IN' || status == 'OUT' || status == 'in' || status == 'out';
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
                  return Stack(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: filteredFeed
                            .asMap()
                            .entries
                            .map((entry) => _buildLiveFeedItem(
                                  entry.value,
                                  isDarkMode,
                                  key: ValueKey(
                                      'live_feed_${entry.key}_${entry.value['name']}_${entry.value['time']}'),
                                ))
                            .toList(),
                      ),
                      if (isLoading)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: LinearProgressIndicator(
                            minHeight: 2,
                            color: isDarkMode
                                ? adminAppColors.darkTextPrimary
                                : adminAppColors.textPrimary,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      if (hasError)
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: _buildStaleBanner(
                            isDarkMode,
                            message: 'Showing last updated data. Tap to retry.',
                            onRetry: () => controller.fetchLiveFeed(),
                          ),
                        ),
                    ],
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

  Widget _buildLiveFeedItem(Map<String, String> item, bool isDarkMode,
      {Key? key}) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(item['status']!, isDarkMode, true),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              item['status']!,
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _getStatusColor(item['status']!, isDarkMode, false),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name']!,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : adminAppColors.textPrimary,
                  ),
                ),
                if (item['company'] != null && item['company']!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    item['company']!,
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
            item['time']!,
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

  Color _getStatusColor(String status, bool isDarkMode, bool isBackground) {
    switch (status.toUpperCase()) {
      case 'IN':
        return isBackground
            ? (isDarkMode
                ? adminAppColors.darkSuccess.withOpacity(0.2)
                : const Color(0xFFD1FAE5))
            : (isDarkMode
                ? adminAppColors.darkSuccess
                : const Color(0xFF065F46));
      case 'OUT':
        return isBackground
            ? (isDarkMode
                ? adminAppColors.darkWarning.withOpacity(0.2)
                : const Color(0xFFFEE2E2))
            : (isDarkMode
                ? adminAppColors.darkWarning
                : const Color(0xFF991B1B));
      case 'ACCEPTED':
        return isBackground
            ? (isDarkMode
                ? adminAppColors.darkSuccess.withOpacity(0.2)
                : const Color(0xFFD1FAE5))
            : (isDarkMode
                ? adminAppColors.darkSuccess
                : const Color(0xFF065F46));
      case 'PENDING':
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

  Widget _buildStaleBanner(bool isDarkMode,
      {required String message, required VoidCallback onRetry}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onRetry,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isDarkMode
                ? adminAppColors.darkTextSecondary.withOpacity(0.15)
                : Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDarkMode ? adminAppColors.darkBorder : Colors.black12,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: 16,
                color: isDarkMode
                    ? adminAppColors.darkTextSecondary
                    : const Color(0xFF6B7280),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : adminAppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Retry',
                style: GoogleFonts.lexend(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? adminAppColors.darkTextPrimary
                      : adminAppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
