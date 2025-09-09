import 'package:get/get.dart';
import 'package:synctrackr/admin/models/setting_payments_plans_tab_model.dart';

class PlansController extends GetxController {
  var isMonthlySelected = true.obs;

  List<PlanFeature> features = [
    PlanFeature(name: 'Devices Supported', values: ['1', '1', '5', '10']),
    PlanFeature(name: 'Admin Accounts', values: ['1', '1', '3', '5']),
    PlanFeature(
        name: 'Staff Members', values: ['1', 'Up to 5', 'Up to 10', 'Unlimited']),
    PlanFeature(
        name: 'Report Access Duration',
        values: ['10 Days', '1 Months', '6 Months', 'Unlimited']),
    PlanFeature(
        name: 'Visitor Limit',
        values: ['Unlimited', 'Unlimited', 'Unlimited', 'Unlimited']),
    PlanFeature(
        name: 'Visitor Detail Capture (Basic)', values: ['✓', '✓', '✓', '✓']),
    PlanFeature(name: 'Visitor Photo & ID with OTP', values: ['-', '✓', '✓', '✓']),
    PlanFeature(
        name: 'Visitor Health & Safety Compliance',
        values: ['-', '-', '✓', '✓']),
    PlanFeature(
        name: 'Manual Check-In/Check-Out', values: ['✓', '✓', '✓', '✓']),
    PlanFeature(
        name: 'QR Code Check-In/Check-Out', values: ['-', '✓', '✓', '✓']),
    PlanFeature(
        name: 'RFID Card Check-In/Check-Out', values: ['-', '-', '✓', '✓']),
    PlanFeature(
        name: 'Access Control Integration', values: ['-', '-', '-', '✓']),
    PlanFeature(
        name: 'Custom Reports (View & Export)', values: ['-', '✓', '✓', '✓']),
    PlanFeature(
        name: 'Visitor Email Notifications', values: ['✓', '✓', '✓', '✓']),
    PlanFeature(
        name: 'Visitor Mobile Notifications', values: ['-', '✓', '✓', '✓']),
    PlanFeature(
        name: 'Admin Email Notifications', values: ['✓', '✓', '✓', '✓']),
    PlanFeature(
        name: 'Admin Mobile Notifications', values: ['-', '✓', '✓', '✓']),
    PlanFeature(name: 'Visitor Pass Printing', values: ['-', '-', '✓', '✓']),
    PlanFeature(
        name: 'Reschedule Visitor Appointments', values: ['-', '-', '-', '✓']),
    PlanFeature(
        name: 'Custom Visitor Form Options', values: ['-', '-', '✓', '✓']),
    PlanFeature(
        name: 'Editable Company Profile & Logo', values: ['-', '-', '-', '✓']),
    PlanFeature(name: 'Event Pass Generation', values: ['-', '-', '✓', '✓']),
    PlanFeature(name: 'Bulk Pass Generation', values: ['-', '-', '✓', '✓']),
  ];

  void toggleBilling(bool isMonthly) {
    isMonthlySelected.value = isMonthly;
  }
}
