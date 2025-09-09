import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/setting_payments_plans_tab_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';

import '../widgets/gradient_border.container.dart';

class PlansTab extends StatelessWidget {
  final PlansController controller = Get.put(PlansController());
  final MainController mainController = Get.find<MainController>();

  PlansTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Container(
          color: mainController.isDarkMode.value
              ? adminAppColors.darkSidebar.withOpacity(0.9)
              : adminAppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: mainController.isDarkMode.value
                        ? adminAppColors.secondary
                        : adminAppColors.secondary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildBillingTab('Monthly billing', true),
                    // const SizedBox(width: 8),
                    _buildBillingTab('Annual billing', false, isDiscount: true),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildEnterprisePlanCard(),
              const SizedBox(height: 24),
              _buildFeaturesTable(),
              const SizedBox(height: 24),
              _buildUpgradeButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBillingTab(String text, bool isMonthly,
      {bool isDiscount = false}) {
    bool isSelected = controller.isMonthlySelected.value == isMonthly;
    return GestureDetector(
      onTap: () => controller.toggleBilling(isMonthly),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(
                  width: isSelected ? 1.0 : 0.0,
                  color: mainController.isDarkMode.value
                      ? adminAppColors.secondary
                      : adminAppColors.secondary)
              : null,
          color: isSelected
              ? (mainController.isDarkMode.value
                  ? adminAppColors.darkStatCard.withOpacity(0.9)
                  : Color(0xFFE4EFFF))
              : (mainController.isDarkMode.value
                  ? adminAppColors.darkCard
                  : Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: GoogleFonts.lexend(
                color: isSelected
                    ? (mainController.isDarkMode.value
                        ? adminAppColors.primary
                        : Color(0xFF24263D))
                    : (mainController.isDarkMode.value
                        ? adminAppColors.darkTextSecondary
                        : Colors.black),
                fontWeight: isSelected ? FontWeight.w300 : FontWeight.w300,
              ),
            ),
            if (isDiscount)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: mainController.isDarkMode.value
                      ? Colors.transparent
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Save 20%',
                  style: GoogleFonts.lexend(
                    color: adminAppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnterprisePlanCard() {
    return GradientBorderContainer(
      borderWidth: 3,
      borderRadius: 12,
      topLeftColor: Color(0xFF79CBCA),//teal
      topRightColor: Color(0xFFE684AE),// pink
      bottomLeftColor: Color(0xFF77A1D3),// blue
      bottomRightColor: Color(0xFF79CBCA),//teal
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: mainController.isDarkMode.value
              ? adminAppColors.darkCard
              : adminAppColors.background,
          borderRadius: BorderRadius.circular(12),
        /*  border: Border.all(
            color: mainController.isDarkMode.value
                ? adminAppColors.secondary
                : Colors.grey[300]!,
          ),*/
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Enterprise Plan',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: mainController.isDarkMode.value
                                  ? adminAppColors.darkTextPrimary
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          //Container(
                            /*padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),*/
                            //child:
                            Text(
                              'Available',
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                  color: Colors.red, fontWeight: FontWeight.w300),
                            ),
                          //),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        // icon: const Icon(Icons.link, size: 16, color: Colors.white),
                        label: const Text('Connect with Us'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: mainController.isDarkMode.value
                              ? adminAppColors.darkMainButton
                              : Color(0xFF3E7FFF),
                          foregroundColor: mainController.isDarkMode.value
                              ? Colors.black
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color(0xFFBCD3FF),
                                width: 1.0
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Personalized Prices | Completely Customized to Your Company',
                    style: GoogleFonts.lexend(
                      color: mainController.isDarkMode.value
                          ? adminAppColors.darkPrimary
                          : adminAppColors.darkMainBackground,
                      fontWeight: FontWeight.w300,
                      fontSize: 14
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A visitor management system that can grow with your business and be fully customized to fit your needs.',
                    style: GoogleFonts.lexend(
                      color: mainController.isDarkMode.value
                          ? adminAppColors.darkTextSecondary
                          : const Color(0xFF757575),
                      fontSize: 11
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(width: 20),

          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesTable() {
    return Container(
      decoration: BoxDecoration(
        color: mainController.isDarkMode.value
            ? adminAppColors.darkCard
            : adminAppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: mainController.isDarkMode.value
              ? adminAppColors.secondary
              : adminAppColors.secondary,
        ),
      ),
      child: Column(
        children: [
          _buildFeatureHeader(),
          Divider(
            height: 1,
            color: mainController.isDarkMode.value
                ? adminAppColors.secondary
                : Colors.grey,
          ),
          Column(
            children: [
              ...controller.features.expand((feature) => [
                _buildFeatureRow(feature.name, feature.values),
                Divider(
                  height: 1,
                  color: mainController.isDarkMode.value
                      ? adminAppColors.secondary
                      : Color(0xFFE0E0E0),
                ),
              ]),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFeatureHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Features',
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: mainController.isDarkMode.value
                    ? adminAppColors.darkTextPrimary
                    :  Color(0xff292929),
              ),
            ),
          ),
          ...[
            'Free trial\n10-Day',
            'Basic\n₹899',
            'Standard\n₹1599',
            'Premium\n₹2999'
          ].map(
            (e) => Expanded(
              flex: 2,
              child: Text(
                e,
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  color: mainController.isDarkMode.value
                      ? adminAppColors.darkTextSecondary
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String feature, List<String> values) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              feature,
              style: GoogleFonts.lexend(
                color: mainController.isDarkMode.value
                    ? adminAppColors.darkTextPrimary
                    : Colors.black,
              ),
            ),
          ),
          ...values.map(
            (value) => Expanded(
              flex: 2,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  color: mainController.isDarkMode.value
                      ? adminAppColors.darkTextSecondary
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.open_in_new),
      iconAlignment: IconAlignment.end,
      label: const Text('Upgrade Plan'),
      style: ElevatedButton.styleFrom(
        backgroundColor: mainController.isDarkMode.value
            ? adminAppColors.darkMainButton
            : Color(0xFF3E7FFF),
        foregroundColor: mainController.isDarkMode.value
            ? adminAppColors.darkTextPrimary
            : Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
