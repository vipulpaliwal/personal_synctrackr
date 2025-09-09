import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';

class StatsCards extends StatelessWidget {
  final List<String> cardNames;

  const StatsCards({super.key, required this.cardNames});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    final DashboardController dashboardController = Get.find();
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;

          // Responsive sizes
          double cardWidth = (maxWidth / cardNames.length - 16).floorToDouble();
          double iconSize = maxWidth < 900 ? 20 : 28;
          double titleFontSize = maxWidth < 900 ? 12 : 14;
          double valueFontSize = maxWidth < 900 ? 16 : 20;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < cardNames.length; i++) ...[
                  SizedBox(
                    width: cardWidth,
                    child: _buildCardByName(
                      cardNames[i],
                      iconSize,
                      titleFontSize,
                      valueFontSize,
                      isDarkMode,
                      dashboardController,
                    ),
                  ),
                  if (i != cardNames.length - 1) const SizedBox(width: 16),
                ],
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildCardByName(
      String name,
      double iconSize,
      double titleSize,
      double valueSize,
      bool isDarkMode,
      DashboardController controller) {
    switch (name.toLowerCase()) {
      case 'visitors':
        return Obx(() => _buildStatCard(
            "Today's Visitors",
            controller.todaysVisitors.value.toString(),
            AssetImage(AllImages.peopleIcon),
            isDarkMode ? adminAppColors.secondary : const Color(0xFF3B82F6),
            isDarkMode ? Color(0xff2D5073) : const Color(0xFFEFF1FD),
            iconSize,
            titleSize,
            valueSize,
            isDarkMode));
      case 'checkin':
        return Obx(() => _buildStatCard(
            "Check  In",
            controller.todaysCheckins.value.toString(),
            AssetImage(AllImages.exportIcon),
            isDarkMode ? adminAppColors.secondary : const Color(0xFF3B82F6),
            isDarkMode ? Color(0xff325A72) : const Color(0xFFF0F6FF),
            iconSize,
            titleSize,
            valueSize,
            isDarkMode));
      case 'checkout':
        return Obx(() => _buildStatCard(
            "Check Out",
            controller.todaysCheckouts.value.toString(),
            AssetImage(AllImages.outIcon),
            isDarkMode ? adminAppColors.secondary : const Color(0xFF3B82F6),
            isDarkMode ? Color(0xff2D5073) : const Color(0xFFEFF1FD),
            iconSize,
            titleSize,
            valueSize,
            isDarkMode));
      case 'monthly':
        return _buildStatCard(
            "Monthly Visitors",
            "8928", // This can be updated later if you have an API for it
            AssetImage(AllImages.peopleIcon),
            isDarkMode ? adminAppColors.secondary : const Color(0xFF3B82F6),
            isDarkMode ? Color(0xff325A72) : const Color(0xFFF0FAF4),
            iconSize,
            titleSize,
            valueSize,
            isDarkMode);
      case 'add':
        return _buildAddVisitorCard(iconSize, titleSize, isDarkMode);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStatCard(
      String title,
      String value,
      ImageProvider<Object> icon,
      Color iconColor,
      Color bgColor,
      double iconSize,
      double titleSize,
      double valueSize,
      bool isDarkMode) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
            color:
                isDarkMode ? adminAppColors.secondary : adminAppColors.primary,
            width: 2),
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(icon, color: iconColor, size: iconSize),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexend(
                      fontSize: titleSize,
                      color: isDarkMode ? Colors.white : Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.lexend(
                    fontSize: valueSize,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddVisitorCard(
      double iconSize, double titleSize, bool isDarkMode) {
    final MainController mainController = Get.find();
    return GestureDetector(
      onTap: () => mainController.selectAddVisitorHead(),
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 10), // same as stat cards
        decoration: BoxDecoration(
          border: Border.all(
              color: isDarkMode
                  ? adminAppColors.secondary
                  : adminAppColors.primary,
              width: 2),
          color: isDarkMode ? Color(0xff325A72) : const Color(0xFFF0F6FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Visitor',
              style: GoogleFonts.lexend(
                  fontSize: titleSize,
                  color: isDarkMode ? Colors.white : Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 6,
            ),
            Icon(Icons.add,
                color: isDarkMode
                    ? adminAppColors.darkTextPrimary
                    : Colors.black54,
                size: iconSize),
          ],
        ),
      ),
    );
  }
}
