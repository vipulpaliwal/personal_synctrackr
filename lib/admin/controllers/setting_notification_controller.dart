import 'package:get/get.dart';
import 'package:synctrackr/admin/models/setting_notification_model.dart';

class NotificationController extends GetxController {
  Rx<NotificationSettings> settings = NotificationSettings(
    loginAlerts: true,
    emailNewsUpdates: true,
    mobileNewsUpdates: true,
    emailVisitorsActivity: NotificationCategory(
      title: "Visitors activity",
      selectedValue: "inout",
      options: [
        NotificationOption(label: "Do not notify me", value: "none"),
        NotificationOption(label: "In/Out activities only", value: "inout"),
        NotificationOption(label: "All activities of visitors", value: "all"),
      ],
    ),
    emailReminders: NotificationCategory(
      title: "Reminders",
      selectedValue: "important",
      options: [
        NotificationOption(label: "Do not notify me", value: "none"),
        NotificationOption(
            label: "Important reminders only", value: "important"),
        NotificationOption(label: "All reminders", value: "all"),
      ],
    ),
    mobileVisitorsActivity: NotificationCategory(
      title: "Visitors activity",
      selectedValue: "inout",
      options: [
        NotificationOption(label: "Do not notify me", value: "none"),
        NotificationOption(label: "In/Out activities only", value: "inout"),
        NotificationOption(label: "All activities of visitors", value: "all"),
      ],
    ),
    mobileReminders: NotificationCategory(
      title: "Reminders",
      selectedValue: "important",
      options: [
        NotificationOption(label: "Do not notify me", value: "none"),
        NotificationOption(
            label: "Important reminders only", value: "important"),
        NotificationOption(label: "All reminders", value: "all"),
      ],
    ),
  ).obs;

  void toggleLoginAlerts(bool value) {
    settings.value.loginAlerts.value = value;
  }

  void toggleEmailNewsUpdates(bool value) {
    settings.value.emailNewsUpdates.value = value;
  }

  void toggleMobileNewsUpdates(bool value) {
    settings.value.mobileNewsUpdates.value = value;
  }

  void updateCategorySelection(NotificationCategory category, String selected) {
    category.selectedValue.value = selected;
  }
}
