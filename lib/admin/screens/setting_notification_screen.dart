// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:synctrackr/admin/controllers/setting_notification_controller.dart';
// import 'package:synctrackr/admin/models/setting_notification_model.dart';
// import 'package:synctrackr/admin/utils/colors.dart';

// class NotificationsScreen extends StatelessWidget {
//   final NotificationController controller = Get.put(NotificationController());

//   NotificationsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SingleChildScrollView(
//         child: Opacity(
//           opacity: 0.9,
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: AppColors.primary),
//                 color: AppColors.background,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header Section
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Notifications',
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF212529)),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           "Get emails to find out what's going on when you're not online.",
//                           style: TextStyle(color: Colors.grey.shade600),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Login Alerts
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     child: Obx(
//                       () => _buildToggleItem(
//                         "Login Alerts",
//                         "Notify on new/unfamiliar logins",
//                         controller.settings.value.loginAlerts.value,
//                         controller.toggleLoginAlerts,
//                       ),
//                     ),
//                   ),

//                   // Email Notifications
//                   Container(
//                     margin: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: AppColors.primary),
//                     ),
//                     child: Obx(
//                       () => _buildNotificationSection(
//                         title: 'Email Notifications',
//                         subtitle:
//                             'These are notifications for comments on your posts and replies to your comments.',
//                         newsValue:
//                             controller.settings.value.emailNewsUpdates.value,
//                         onNewsChanged: controller.toggleEmailNewsUpdates,
//                         visitorsActivity:
//                             controller.settings.value.emailVisitorsActivity,
//                         reminders: controller.settings.value.emailReminders,
//                       ),
//                     ),
//                   ),

//                   // Mobile Notifications
//                   Container(
//                     margin: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color:AppColors.primary),
//                     ),
//                     child: Obx(
//                       () => _buildNotificationSection(
//                         title: 'Mobile Notifications',
//                         subtitle:
//                             'These are notifications for comments on your posts and replies to your comments.',
//                         newsValue:
//                             controller.settings.value.mobileNewsUpdates.value,
//                         onNewsChanged: controller.toggleMobileNewsUpdates,
//                         visitorsActivity:
//                             controller.settings.value.mobileVisitorsActivity,
//                         reminders: controller.settings.value.mobileReminders,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildToggleItem(
//       String title, String subtitle, bool value, Function(bool) onChanged) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                   fontWeight: FontWeight.w500, color: Color(0xFF212529)),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               subtitle,
//               style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//             ),
//           ],
//         ),
//         Switch(
//           value: value,
//           onChanged: onChanged,
//           activeColor: Colors.white,
//           activeTrackColor: const Color(0xFF4C6FFF),
//           inactiveTrackColor: const Color(0xFFADB5BD),
//           inactiveThumbColor: Colors.white,
//         ),
//       ],
//     );
//   }

//   Widget _buildNotificationSection({
//     required String title,
//     required String subtitle,
//     required bool newsValue,
//     required Function(bool) onNewsChanged,
//     required NotificationCategory visitorsActivity,
//     required NotificationCategory reminders,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF212529)),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       subtitle,
//                       style: TextStyle(color: Colors.grey.shade600),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: newsValue,
//                     onChanged: (value) => onNewsChanged(value!),
//                     activeColor: const Color(0xFF4C6FFF),
//                   ),
//                   const Text('News and updates'),
//                 ],
//               )
//             ],
//           ),
//           const SizedBox(height: 16),
//           const Divider(color: Color(0xFFE9ECEF), height: 1),
//           const SizedBox(height: 16),
//           _buildRadioGroup(
//             'Visitors activity',
//             "Get notifications about your visitors' movements and actions",
//             visitorsActivity,
//           ),
//           const SizedBox(height: 16),
//           const Divider(color: Color(0xFFE9ECEF), height: 1),
//           const SizedBox(height: 16),
//           _buildRadioGroup(
//             'Reminders',
//             'These are notifications to remind you of updates you might have missed',
//             reminders,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRadioGroup(
//       String title, String subtitle, NotificationCategory category) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                     fontWeight: FontWeight.w500, color: Color(0xFF212529)),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 subtitle,
//                 style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           width: 200,
//           child: Obx(
//             () => Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: category.options
//                   .map<Widget>(
//                     (option) => Row(
//                       children: [
//                         Radio(
//                           value: option.value,
//                           groupValue: category.selectedValue.value,
//                           activeColor: const Color(0xFF4C6FFF),
//                           onChanged: (value) {
//                             controller.updateCategorySelection(
//                                 category, value.toString());
//                           },
//                         ),
//                         Expanded(child: Text(option.label)),
//                       ],
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/setting_notification_controller.dart';
import 'package:synctrackr/admin/models/setting_notification_model.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';

class NotificationsScreen extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());
  final MainController mainController = Get.find();

  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return SingleChildScrollView(
        child: Opacity(
          opacity: 0.9,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: isDarkMode
                        ? adminAppColors.secondary
                        : adminAppColors.primary),
                color: isDarkMode
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
                          'Notifications',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF212529),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Get emails to find out what's going on when you're not online.",
                          style: GoogleFonts.lexend(
                              color: isDarkMode
                                  ? Colors.white70
                                  : Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
      
                  // Login Alerts
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Obx(
                      () => _buildToggleItem(
                        "Login Alerts",
                        "Notify on new/unfamiliar logins",
                        controller.settings.value.loginAlerts.value,
                        controller.toggleLoginAlerts,
                        isDarkMode,
                      ),
                    ),
                  ),
      
                  // Email Notifications
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: isDarkMode
                              ? adminAppColors.secondary
                              : adminAppColors.primary),
                      color: isDarkMode
                          ? adminAppColors.darkSidebar.withOpacity(0.9)
                          : Colors.white,
                    ),
                    child: Obx(
                      () => _buildNotificationSection(
                        title: 'Email Notifications',
                        subtitle:
                            'These are notifications for comments on your posts and replies to your comments.',
                        newsValue:
                            controller.settings.value.emailNewsUpdates.value,
                        onNewsChanged: controller.toggleEmailNewsUpdates,
                        visitorsActivity:
                            controller.settings.value.emailVisitorsActivity,
                        reminders: controller.settings.value.emailReminders,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ),
      
                  // Mobile Notifications
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: isDarkMode
                              ? adminAppColors.secondary
                              : adminAppColors.primary),
                      color: isDarkMode
                          ? adminAppColors.darkSidebar.withOpacity(0.9)
                          : Colors.white,
                    ),
                    child: Obx(
                      () => _buildNotificationSection(
                        title: 'Mobile Notifications',
                        subtitle:
                            'These are notifications for comments on your posts and replies to your comments.',
                        newsValue:
                            controller.settings.value.mobileNewsUpdates.value,
                        onNewsChanged: controller.toggleMobileNewsUpdates,
                        visitorsActivity:
                            controller.settings.value.mobileVisitorsActivity,
                        reminders: controller.settings.value.mobileReminders,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    );
  }

  Widget _buildToggleItem(String title, String subtitle, bool value,
      Function(bool) onChanged, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : const Color(0xFF212529),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.lexend(
                  fontSize: 12,
                  color: isDarkMode ? Colors.white70 : Colors.grey.shade600),
            ),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: isDarkMode ? adminAppColors.primary : Colors.white,
          activeTrackColor: isDarkMode
              ? adminAppColors.darkMainButton
              : const Color(0xFF4C6FFF),
          inactiveTrackColor:
              isDarkMode ? adminAppColors.secondary : const Color(0xFFADB5BD),
          inactiveThumbColor:
              isDarkMode ? adminAppColors.darkMainBackground : Colors.white,
        ),
      ],
    );
  }

  Widget _buildNotificationSection({
    required String title,
    required String subtitle,
    required bool newsValue,
    required Function(bool) onNewsChanged,
    required NotificationCategory visitorsActivity,
    required NotificationCategory reminders,
    required bool isDarkMode,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            isDarkMode ? Colors.white : const Color(0xFF212529),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.lexend(
                          color: isDarkMode
                              ? Colors.white70
                              : Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: newsValue,
                    onChanged: (value) => onNewsChanged(value!),
                    activeColor: isDarkMode
                        ? adminAppColors.primary
                        : const Color(0xFF4C6FFF),
                    checkColor: isDarkMode
                        ? adminAppColors.darkBackground
                        : Colors.white,
                  ),
                  Text('News and updates',
                      style: GoogleFonts.lexend(
                          color: isDarkMode
                              ? adminAppColors.primary
                              : Colors.black)),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Divider(
              color: isDarkMode
                  ? adminAppColors.secondary
                  : const Color(0xFFE9ECEF),
              height: 1),
          const SizedBox(height: 16),
          _buildRadioGroup(
            'Visitors activity',
            "Get notifications about your visitors' movements and actions",
            visitorsActivity,
            isDarkMode,
          ),
          const SizedBox(height: 16),
          Divider(
              color: isDarkMode
                  ? adminAppColors.secondary
                  : const Color(0xFFE9ECEF),
              height: 1),
          const SizedBox(height: 16),
          _buildRadioGroup(
            'Reminders',
            'These are notifications to remind you of updates you might have missed',
            reminders,
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildRadioGroup(String title, String subtitle,
      NotificationCategory category, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w500,
                  color: isDarkMode
                      ? adminAppColors.primary
                      : const Color(0xFF212529),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.lexend(
                    fontSize: 12,
                    color: isDarkMode ? Colors.white70 : Colors.grey.shade600),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 200,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: category.options
                  .map<Widget>(
                    (option) => Row(
                      children: [
                        Radio(
                          value: option.value,
                          groupValue: category.selectedValue.value,
                          activeColor: isDarkMode
                              ? adminAppColors.primary
                              : const Color(0xFF4C6FFF),
                          onChanged: (value) {
                            controller.updateCategorySelection(
                                category, value.toString());
                          },
                        ),
                        Expanded(
                            child: Text(option.label,
                                style: GoogleFonts.lexend(
                                    color: isDarkMode
                                        ? adminAppColors.primary
                                        : Colors.black))),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
