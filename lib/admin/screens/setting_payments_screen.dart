import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/screens/setting_payment_billing_tab_screen.dart';
import 'package:synctrackr/admin/screens/setting_payments_plans_tab_screen.dart';
import 'package:synctrackr/admin/utils/colors.dart';

class SettingPaymentsScreen extends StatefulWidget {
  const SettingPaymentsScreen({super.key});

  @override
  State<SettingPaymentsScreen> createState() => _SettingPaymentsScreenState();
}

class _SettingPaymentsScreenState extends State<SettingPaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: mainController.isDarkMode.value
                    ? adminAppColors.secondary
                    : adminAppColors.primary,
              ),
              color: mainController.isDarkMode.value
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
                        'Plans & Billing',
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: mainController.isDarkMode.value
                              ? adminAppColors.darkTextPrimary
                              : const Color(0xFF212529),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage your subscription plan and billing details',
                        style: GoogleFonts.lexend(
                          color: mainController.isDarkMode.value
                              ? adminAppColors.darkTextSecondary
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(color: Color(0xFFE9ECEF), height: 1),

                // Tab Bar
                Container(
                  padding: const EdgeInsets.all(20),
                  child: DefaultTabController(
                    length: 2, // Billing and Plans
                    initialIndex: 0,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          child: TabBar(
                            isScrollable: false,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BoxDecoration(
                              color: mainController.isDarkMode.value
                                  ? adminAppColors.darkStatCard.withOpacity(0.5)
                                  : const Color(0xffBCD3FF),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            dividerColor: Colors.transparent,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            labelColor: mainController.isDarkMode.value
                                ? adminAppColors.primary
                                : const Color(0xFF4C6FFF),
                            unselectedLabelColor:
                                mainController.isDarkMode.value
                                    ? Colors.white
                                    : const Color(0xFF212529),
                            labelStyle: GoogleFonts.lexend(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            unselectedLabelStyle: GoogleFonts.lexend(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            tabs: const [
                              _CustomTab(
                                text: 'Billing',
                                index: 0,
                              ),
                              _CustomTab(
                                text: 'Plans',
                                index: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 400, // Adjust height as needed
                          child: TabBarView(
                            children: [
                              const BillingTab(),
                              PlansTab(),
                            ],
                          ),
                        ),
                      ],
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
}

// class _CustomTab extends StatelessWidget {
//   final String text;
//   const _CustomTab({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     final MainController mainController = Get.find<MainController>();
//     return Obx(
//       () => Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 30, child: Center()),
//           Text(
//             text,
//           ),
//           const SizedBox(height: 4),
//           Container(
//             height: 1.5,
//             width: double.infinity,
//             color: mainController.isDarkMode.value
//                 ? AppColors.secondary
//                 : AppColors.primary,
//           ),
//         ],
//       ),
//     );
//   }
// }

class _CustomTab extends StatelessWidget {
  final String text;
  final int index;
  const _CustomTab({required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();
    final TabController tabController = DefaultTabController.of(context);
    return Obx(
      () {
        final isDark = mainController.isDarkMode.value;
        final activeColor =
            isDark ? adminAppColors.primary : adminAppColors.primary;
        final inactiveColor = const Color(0xFF757575);
        return AnimatedBuilder(
            animation: tabController!,
            builder: (context, _) {
              final bool isSelected = tabController.index == index;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔹 Text + Background
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      text,
                      style: GoogleFonts.lexend(
                        color: isSelected ? activeColor : inactiveColor,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // 🔹 Permanent thin underline (independent of height)
                  Container(
                      height: 1, // 👈 Always thin line
                      width: double.infinity,
                      color: activeColor),
                ],
              );
            });
      },
    );
  }
}
