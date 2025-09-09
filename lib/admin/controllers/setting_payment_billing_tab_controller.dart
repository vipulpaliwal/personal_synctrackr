import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/models/setting_payment_biiling_tab_model.dart';

class BillingController extends GetxController {
  var isAutoRenewalEnabled = true.obs;

  var invoices = <InvoiceModel>[
    InvoiceModel(date: 'March 01, 2024', amount: '₹8,300.00'),
    InvoiceModel(date: 'March 01, 2023', amount: '₹8,300.00'),
    InvoiceModel(date: 'March 01, 2022', amount: '₹8,300.00'),
    InvoiceModel(date: 'March 01, 2021', amount: '₹8,300.00'),
  ].obs;

  void toggleAutoRenewal(bool value) {
    isAutoRenewalEnabled.value = value;
  }

  void upgradePlan() {
    Get.find<MainController>().upgradePlan();
  }

  void viewAllInvoices() {
    // TODO: Implement view all logic
  }

  void downloadInvoice(InvoiceModel invoice) {
    // TODO: Implement download logic
  }
}
