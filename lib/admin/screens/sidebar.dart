import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find();
    return Obx(() {
      final isDarkMode = controller.isDarkMode.value;
      return ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            // Add a subtle white overlay for better frosted glass effect

            decoration: BoxDecoration(
              color: isDarkMode
                  ? adminAppColors.darkSidebar
                  : adminAppColors.lightSidebar, // Reduced opacity for pure white effect
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08), // halka shadow
                  blurRadius: 18, // halka sa blur
                  spreadRadius: 0, // failne na do
                  offset: const Offset(
                      4, 0), // shadow sirf LEFT side (border ke sath)
                ),
              ],
              border: const Border(
                right: BorderSide(
                  color: Colors.white, // White border as per Figma
                  width: 4, // 4px as per Figma
                ),
              ),
            ),
            child: Column(
              children: [
                // Logo
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Image.asset(
                      isDarkMode ? AllImages.darkModeLogo : AllImages.adminLogo,
                      width: 180,
                      height: 100,
                    ),
                  ),
                ),
                // Menu Items
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      Divider(
                        thickness: 1,
                        color: isDarkMode
                            ? adminAppColors.darkBorder
                            : Colors.grey,
                      ),
                      _buildMenuItem(
                        const AssetImage(AllImages.dashboard),
                        'Dashboard',
                        controller.selectedIndex == 0,
                        isDarkMode,
                        onTap: () => controller.selectScreen(0),
                      ),
                      _buildMenuItem(
                        const AssetImage(AllImages.visitor),
                        'Visitors',
                        controller.selectedIndex == 1,
                        isDarkMode,
                        onTap: () => controller.selectScreen(1),
                      ),
                      _buildMenuItem(
                        const AssetImage(AllImages.visitorsHead),
                        "Visitors' Heads",
                        controller.selectedIndex == 2,
                        isDarkMode,
                        onTap: () => controller.selectScreen(2),
                      ),
                      _buildMenuItem(
                        const AssetImage(AllImages.reports),
                        'Reports',
                        controller.selectedIndex == 3,
                        isDarkMode,
                        onTap: () => controller.selectScreen(3),
                      ),
                      Divider(
                        thickness: 1,
                        color: isDarkMode
                            ? adminAppColors.darkBorder
                            : Colors.grey,
                      ),
                      _buildMenuItem(
                        const AssetImage(AllImages.others),
                        'Others',
                        controller.selectedIndex == 4,
                        isDarkMode,
                        onTap: () => controller.selectScreen(4),
                      ),
                      _buildMenuItem(
                        const AssetImage(AllImages.setting),
                        'Settings',
                        controller.selectedIndex == 5,
                        isDarkMode,
                        onTap: () => controller.selectScreen(5),
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

  Widget _buildMenuItem(
    ImageProvider<Object> icon,
    String title,
    bool isActive,
    bool isDarkMode, {
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isActive
            ? (isDarkMode ? Color(0xffBCD3FF) : const Color(0xFF4F46E5))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
        leading: ImageIcon(
          icon,
          color: isActive
              ? (isDarkMode ? Colors.black : Colors.white)
              : (isDarkMode ? adminAppColors.darkTextPrimary : Colors.black),
          size: 22,
        ),
        title: Text(
          title,
          style: GoogleFonts.lexend(
            color: isActive
                ? (isDarkMode ? Colors.black : Colors.white)
                : (isDarkMode ? adminAppColors.darkTextPrimary : Colors.black),
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w300 : FontWeight.w300,
          ),
        ),
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
