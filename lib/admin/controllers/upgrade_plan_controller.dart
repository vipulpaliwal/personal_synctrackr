import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/models/upgrade_plan_plan_model.dart';

class UpgradePlanController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Reactive state variables
  var isAnnualBilling = false.obs;
  var autoRenewEnabled = true.obs;
  var selectedMonthlyPlanId = 0.obs;
  var selectedAnnualPlanId = 0.obs;

  // Plan data for monthly and annual billing
  final List<Plan> plans = [
    Plan(
      id: 0,
      title: "Basic Plan",
      monthlyPrice: "₹899/month",
      annualPrice: "₹699/month",
      description:
          "Ideal for small offices that require simple visitor management with team collaboration.",
    ),
    Plan(
      id: 1,
      title: "Standard Plan",
      monthlyPrice: "₹1,599/month",
      annualPrice: "₹1,299/month",
      description:
          "Designed for growing businesses with multi-device support and advanced visitor validation.",
    ),
    Plan(
      id: 2,
      title: "Premium Plan",
      monthlyPrice: "₹2,999/month",
      annualPrice: "₹2,499/month",
      description:
          "A comprehensive solution for large organizations with advanced security and flexible visitor handling.",
    ),
  ];

  // Method to switch between monthly and annual billing tabs
  void toggleBilling(int index) {
    isAnnualBilling.value = index == 1;
  }

  // Method to toggle the auto-renewal switch
  void toggleAutoRenewal(bool value) {
    autoRenewEnabled.value = value;
  }

  // Methods to handle plan selection
  void selectPlan(int id) {
    if (isAnnualBilling.value) {
      selectedAnnualPlanId.value = id;
    } else {
      selectedMonthlyPlanId.value = id;
    }
  }

  // Method for the "Purchase Plan" button
  void purchasePlan() {
    Get.find<MainController>().checkoutScreen();
    String? selectedPlanAmount;
    if (isAnnualBilling.value) {
      final selectedPlan = plans
          .firstWhereOrNull((plan) => plan.id == selectedAnnualPlanId.value);
      selectedPlanAmount = selectedPlan?.annualPrice;
    } else {
      final selectedPlan = plans
          .firstWhereOrNull((plan) => plan.id == selectedMonthlyPlanId.value);
      selectedPlanAmount = selectedPlan?.monthlyPrice;
    }

    if (selectedPlanAmount != null) {
      print("Selected plan amount: $selectedPlanAmount");
    } else {
      print("No plan selected.");
    }
  }

  // Method for the "Exit" button
  void exit() {
    // Logic for exiting the screen
    print("Exiting upgrade plan screen.");
  }
}
