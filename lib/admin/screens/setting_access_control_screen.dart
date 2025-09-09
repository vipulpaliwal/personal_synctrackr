import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/notification_bar.dart';

class AccessControlScreen extends StatelessWidget {
  const AccessControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();
    return Center(
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(
              () => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: mainController.isDarkMode.value
                            ? adminAppColors.secondary
                            : adminAppColors.primary),
                    color: mainController.isDarkMode.value
                        ? adminAppColors.darkSidebar.withOpacity(0.9)
                        : adminAppColors.background,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Access Control',
                              style: GoogleFonts.lexend(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: mainController.isDarkMode.value
                                      ? Colors.white
                                      : Color(0xFF212529)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'To control your biometrics and access devices',
                              style: GoogleFonts.lexend(
                                  color: mainController.isDarkMode.value
                                      ? Colors.white
                                      : Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),

                      // Access Control List
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _buildAccessControlItem(
                              context,
                              'eSSL Access Control',
                              'eSSLBioSecurity-v5000-4.1.1',
                              true,
                            ),
                            const SizedBox(height: 16),
                            _buildAccessControlItem(
                              context,
                              'Matrix Access Control Solution',
                              'eSSLBioSecurity-v5000-4.1.1',
                              false,
                            ),
                          ],
                        ),
                      ),

                      const Divider(color: Color(0xFFE9ECEF), height: 1),

                      // New Access Control Button
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Obx(
                          () => ElevatedButton.icon(
                            onPressed: () {
                              // "New Access Control" button logic
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: mainController.isDarkMode.value
                                  ? adminAppColors.darkTextPrimary
                                  : adminAppColors.primary,
                            ),
                            label: Text(
                              'New Access Control',
                              style: GoogleFonts.lexend(
                                color: mainController.isDarkMode.value
                                    ? adminAppColors.darkTextPrimary
                                    : adminAppColors.primary,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainController.isDarkMode.value
                                  ? adminAppColors.darkStatCard
                                  : const Color(0xffE5E8F5),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: mainController.isDarkMode.value
                                      ? adminAppColors.secondary
                                      : adminAppColors.primary,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget to build a single access control item
  Widget _buildAccessControlItem(
      BuildContext context, String title, String subtitle, bool isActive) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode
              ? adminAppColors.darkSidebar.withOpacity(0.9)
              : adminAppColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Icon/Image
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.5)),
              ),
              child:  Center(
                child: Text(
                  'eSSL',
                  style: GoogleFonts.lexend(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lexend(
                      color: mainController.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.lexend(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Status Icon
            Icon(
              isActive ? Icons.check_circle : Icons.warning_amber_rounded,
              color: isActive ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 8),
            // More Options Button
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // More options button logic
              },
            ),
          ],
        ),
      );
    });
  }
}
