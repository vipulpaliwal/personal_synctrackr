import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';
import 'package:synctrackr/admin/utils/responsive.dart';
import 'package:synctrackr/admin/screens/sidebar.dart';
import 'package:synctrackr/admin/widgets/network_status_banner.dart';
import 'package:synctrackr/admin/widgets/notification_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());

    final MainController controller = Get.find<MainController>();

    return Obx(() {
      final isDarkMode = controller.isDarkMode.value;

      // Create a custom theme that overrides the main app's theme
      final adminTheme = ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: isDarkMode
            ? adminAppColors.darkSidebar
            : Color(0xffE5ECF5),
        primaryColor:
            isDarkMode ? adminAppColors.darkPrimary : adminAppColors.primary,
      );

      return Theme(
        data: adminTheme,
        child: Scaffold(
          key: controller.scaffoldKey,
          drawer: const Sidebar(),
          body: Column(
            children: [
              // const NetworkStatusBanner(),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: isDarkMode
                            ? adminAppColors.darkSidebar
                                .withOpacity(0.9) // Dark overlay
                            : Color(0xffF8FAFD).withOpacity(
                                0.9), // Light overlay - increased opacity
                      ),
                    ),

                    /// Background Image
                    Positioned.fill(
                      child: Opacity(
                        opacity: isDarkMode ? 0.5 : 0.4,
                        child: Image.asset(
                          AllImages.mainbg,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    /// Dark/Light Overlay

                    /// Main Content (Responsive Screens)
                    Responsive(
                      mobile: Obx(
                          () => controller.screens[controller.selectedIndex]),
                      tablet: Stack(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 230,
                                color: isDarkMode
                                    ? adminAppColors.darkSidebar
                                    : adminAppColors.mainBackground,
                                child: const Sidebar(),
                              ),
                              Expanded(
                                child: Obx(() => controller
                                    .screens[controller.selectedIndex]),
                              ),
                            ],
                          ),
                          Obx(() {
                            if (controller.isNotificationVisible.value) {
                              return GestureDetector(
                                onTap: () {
                                  controller.toggleNotificationVisibility();
                                },
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: NotificationBar(),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                        ],
                      ),
                      desktop: Row(
                        children: [
                          Container(
                            width: 230,
                            color: isDarkMode
                                ? adminAppColors.darkSidebar
                                : adminAppColors.mainBackground,
                            child: const Sidebar(),
                          ),
                          Expanded(
                            child: Obx(() =>
                                controller.screens[controller.selectedIndex]),
                          ),
                          const NotificationBar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const NetworkStatusBanner(),
            ],
          ),
        ),
      );
    });
  }
}
