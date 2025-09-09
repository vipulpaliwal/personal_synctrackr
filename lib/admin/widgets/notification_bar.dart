import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';

class NotificationBar extends StatefulWidget {
  const NotificationBar({super.key});

  @override
  State<NotificationBar> createState() => _NotificationBarState();
}

MainController mainController = Get.find();

class _NotificationBarState extends State<NotificationBar> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;

      return ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: 280,
            // Add a subtle white overlay for better frosted glass effect

            decoration: BoxDecoration(
              color: isDarkMode
                  ? adminAppColors.darkSidebar
                  : adminAppColors.lightSidebar,

              // Very low opacity for pure white effect
               boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08), // halka shadow
                  blurRadius: 8, // halka sa blur
                  spreadRadius: 0, // failne na do
                  offset: const Offset(
                      4, 0), // shadow sirf LEFT side (border ke sath)
                ),
              ],
              border: Border(
                left: BorderSide(
                  color: Colors.white, // White border as per Figma
                  width: 4, // 4px as per Figma (same as sidebar)
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                  child: Text(
                    "Notifications",
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),

                // 🔹 Notifications list
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildNotificationItem(
                        icon: AssetImage(AllImages.notification),
                        title: 'New appointment request',
                        subtitle:
                            'Rahul Gupta for Rajeev Sharma (Interview) on June 4, 11:00 AM – Awaiting approval.',
                        time: 'Just now',
                      ),
                      _buildNotificationItem(
                        icon: AssetImage(AllImages.notification),
                        title: 'Priya Mehta has accepted the meeting',
                        subtitle:
                            'with Nisha Kulkarni (Vendor) on June 5, 3:00 PM.',
                        time: '1 min ago',
                      ),
                      _buildNotificationItem(
                        icon: AssetImage(AllImages.notification),
                        title: 'Anil Verma has declined the meeting',
                        subtitle:
                            'with Ramesh Sinha - Reason: "Not available on selected date".',
                        time: '3 min ago',
                      ),
                      _buildNotificationItem(
                        icon: AssetImage(AllImages.notification),
                        title: 'Sneha Joshi has requested reschedule',
                        subtitle:
                            'for Kavita Patel\'s interview - New time: June 4, 2:00 PM.',
                        time: '7 min ago',
                      ),
                      _buildNotificationItem(
                        icon: AssetImage(AllImages.notification),
                        title: 'New visitor check-in',
                        subtitle: 'Vikram Desai has arrived at the reception.',
                        time: '15 min ago',
                      ),
                      _buildNotificationItem(
                        icon: AssetImage(AllImages.notification),
                        title: 'Anil Verma is currently inactive',
                        subtitle: 'Unable to accept/decline appointments.',
                        time: '21 min ago',
                      ),
                      _buildNotificationItem(
                        icon: AssetImage(AllImages.notification),
                        title: 'New staff added',
                        subtitle: 'Deepak Nair (Admin Officer)',
                        time: '1 hour ago',
                      ),
                      _buildNotificationItem(
                        icon: AssetImage(AllImages.notification),
                        title: 'Visitor waiting',
                        subtitle:
                            'for reception for more than 15 minutes (Rahul Gupta)',
                        time: '3 hour ago',
                      ),
                    ],
                  ),
                ),

                // 🔹 Activities Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                  child: Text(
                    'Activities',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),

                // 🔹 Activities list
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildActivityItem(
                        icon: Icons.email,
                        title:
                            'Enabled email notifications for all meeting types',
                        time: '10:07 AM',
                      ),
                      _buildActivityItem(
                        icon: Icons.add_business,
                        title: 'Added new department Legal & Compliance',
                        time: '09:45 AM',
                      ),
                      _buildActivityItem(
                        icon: Icons.download,
                        title:
                            'Downloaded visitor report for June 1-15 (Excel)',
                        time: '09:20 AM',
                      ),
                      _buildActivityItem(
                        icon: Icons.person,
                        title: 'Created new staff profile for "Sneha Joshi"',
                        time: '09:03 AM',
                      ),
                      _buildActivityItem(
                        icon: Icons.login,
                        title: 'Admin logged in from IP 192.168.1.12',
                        time: '09:01 AM',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // 🔹 Notification Item
  Widget _buildNotificationItem({
    required ImageProvider icon,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageIcon(icon,
                size: 20, color: isDarkMode ? Colors.white : Colors.black),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lexend(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: GoogleFonts.lexend(
                fontSize: 11,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      );
    });
  }

  // 🔹 Activity Item
  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String time,
  }) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon,
                size: 18, color: isDarkMode ? Colors.white : Colors.black),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.lexend(
                  fontSize: 12,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: GoogleFonts.lexend(
                fontSize: 11,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      );
    });
  }
}
