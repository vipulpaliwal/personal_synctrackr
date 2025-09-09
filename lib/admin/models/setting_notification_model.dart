import 'package:get/get.dart';

class NotificationOption {
  String label;
  String value;

  NotificationOption({required this.label, required this.value});
}

class NotificationCategory {
  String title;
  List<NotificationOption> options;
  RxString selectedValue;

  NotificationCategory({
    required this.title,
    required this.options,
    required String selectedValue,
  }) : selectedValue = selectedValue.obs;
}

class NotificationSettings {
  RxBool loginAlerts;
  RxBool emailNewsUpdates;
  RxBool mobileNewsUpdates;

  NotificationCategory emailVisitorsActivity;
  NotificationCategory emailReminders;
  NotificationCategory mobileVisitorsActivity;
  NotificationCategory mobileReminders;

  NotificationSettings({
    required bool loginAlerts,
    required bool emailNewsUpdates,
    required bool mobileNewsUpdates,
    required this.emailVisitorsActivity,
    required this.emailReminders,
    required this.mobileVisitorsActivity,
    required this.mobileReminders,
  })  : loginAlerts = loginAlerts.obs,
        emailNewsUpdates = emailNewsUpdates.obs,
        mobileNewsUpdates = mobileNewsUpdates.obs;
}
