import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';
import 'package:synctrackr/admin/utils/responsive.dart';

class CommonHeader extends StatelessWidget {
  final String title;

  const CommonHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find();
    return Obx(
      () {
        final isDarkMode = controller.isDarkMode.value;
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDarkMode ? Colors.black : Colors.white,
                width: 2,
              ),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'Dashboard / $title',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.toggleTheme();
                    },
                    child: ImageIcon(
                        AssetImage(isDarkMode
                            ? AllImages.lightMode
                            : AllImages.darkMode),
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  const SizedBox(width: 16),
                  if (Responsive.isTablet(context)) ...[
                    GestureDetector(
                      onTap: () {
                        Get.find<MainController>()
                            .toggleNotificationVisibility();
                      },
                      child:  ImageIcon(
                        AssetImage(AllImages.notification),
                        color: isDarkMode?Colors.white:Colors.black,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
