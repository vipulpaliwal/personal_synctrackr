import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/setting_payment_billing_tab_controller.dart';
import 'package:synctrackr/admin/models/setting_payment_biiling_tab_model.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/gradient_border.container.dart';

class BillingTab extends StatelessWidget {
  const BillingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BillingController());
    final MainController mainController = Get.find<MainController>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enable auto renewal',
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: mainController.isDarkMode.value
                            ? adminAppColors.darkTextPrimary
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Checking this will auto-renew your plan after it expires',
                      style: GoogleFonts.lexend(
                        color: mainController.isDarkMode.value
                            ? adminAppColors.darkTextSecondary
                            : Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: controller.isAutoRenewalEnabled.value,
                  onChanged: controller.toggleAutoRenewal,
                  // activeColor: Color(0xFF006AF5),
                  activeTrackColor: Color(0xFF006AF5),
                  // activeThumbColor: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Current Plan Card
          Obx(
            () => GradientBorderContainer(
              borderWidth: 3,
              borderRadius: 12,
              topLeftColor: Color(0xFF79CBCA),
              //teal
              topRightColor: Color(0xFFE684AE),
              // pink
              bottomLeftColor: Color(0xFF77A1D3),
              // blue
              bottomRightColor: Color(0xFF79CBCA),
              //teal
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: mainController.isDarkMode.value
                      ? adminAppColors.darkCard
                      : adminAppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(
                  //   color: mainController.isDarkMode.value
                  //       ? adminAppColors.secondary
                  //       : Colors.blue.withOpacity(0.5),
                  // ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Front plan (billed yearly)',
                      style: GoogleFonts.lexend(
                        color: mainController.isDarkMode.value
                            ? adminAppColors.darkTextSecondary
                            : Color(0xFF757575),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Basic Plan',
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: mainController.isDarkMode.value
                                    ? adminAppColors.darkTextPrimary
                                    : adminAppColors.darkMainBackground,
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: controller.upgradePlan,
                              icon: Icon(Icons.open_in_new, size: 16),
                              iconAlignment: IconAlignment.end,
                              label: Text('Upgrade Plan',
                                  style: GoogleFonts.lexend()),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: mainController.isDarkMode.value
                                    ? adminAppColors.darkCard
                                    : adminAppColors.primary,
                                foregroundColor: mainController.isDarkMode.value
                                    ? adminAppColors.darkTextPrimary
                                    : Colors.white,
                                /* side: BorderSide(
                                  color: mainController.isDarkMode.value
                                      ? adminAppColors.secondary
                                      : Colors.blue.withOpacity(0.5),
                                ),*/
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.transparent, width: 1.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total per year',
                              style: GoogleFonts.lexend(
                                  color: mainController.isDarkMode.value
                                      ? adminAppColors.darkTextSecondary
                                      : adminAppColors.darkMainBackground,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              '₹8,300.00',
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: mainController.isDarkMode.value
                                    ? adminAppColors.darkTextPrimary
                                    : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Invoices Section
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoices',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: mainController.isDarkMode.value
                        ? adminAppColors.darkTextPrimary
                        : Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: controller.viewAllInvoices,
                  child: Text(
                    'View all',
                    style: GoogleFonts.lexend(
                      color: mainController.isDarkMode.value
                          ? adminAppColors.darkPrimary
                          : Color(0xFF757575),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Obx(
            () => Column(
              children: controller.invoices
                  .map((invoice) =>
                      _buildInvoiceItem(context, invoice, controller))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(BuildContext context, InvoiceModel invoice,
      BillingController controller) {
    final MainController mainController = Get.find<MainController>();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: mainController.isDarkMode.value
                ? adminAppColors.darkCard
                : adminAppColors.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: mainController.isDarkMode.value
                  ? adminAppColors.secondary
                  : Colors.grey[200]!,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                invoice.date,
                style: GoogleFonts.lexend(
                  color: mainController.isDarkMode.value
                      ? adminAppColors.darkTextSecondary
                      : Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    invoice.amount,
                    style: GoogleFonts.lexend(
                      color: mainController.isDarkMode.value
                          ? adminAppColors.darkTextPrimary
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: Icon(
                      Icons.file_download_outlined,
                      color: mainController.isDarkMode.value
                          ? adminAppColors.darkTextSecondary
                          : Colors.black,
                    ),
                    onPressed: () => controller.downloadInvoice(invoice),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
