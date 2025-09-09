// // import 'package:flutter/material.dart';
// // import 'package:synctrackr/admin/screens/annual_billing_screen.dart';
// // import 'package:synctrackr/admin/screens/monthly_billing_screen.dart';
// // import 'package:synctrackr/admin/widgets/common_header.dart';

// // class UpgradePlan extends StatefulWidget {
// //   const UpgradePlan({super.key});

// //   @override
// //   State<UpgradePlan> createState() => _UpgradePlanState();
// // }

// // class _UpgradePlanState extends State<UpgradePlan> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       child: Opacity(
// //         opacity: 0.9,
// //         child: Padding(
// //           padding: const EdgeInsets.all(20.0),
// //           child: Column(
// //             children: [
// //               CommonHeader(title: 'Settings'),
// //               const SizedBox(height: 20),
// //               Container(
// //                 width: double.infinity,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(16),
// //                   border: Border.all(color: Colors.grey.shade200),
// //                   color: Colors.white,
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     // Header
// //                     Container(
// //                       padding: const EdgeInsets.all(20),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           const Text(
// //                             "Payment Details",
// //                             style: TextStyle(
// //                                 fontSize: 24,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Color(0xFF212529)),
// //                           ),
// //                           const SizedBox(height: 4),
// //                           Text(
// //                             "All transactions are secure and encrypted",
// //                             style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     const Divider(color: Color(0xFFE9ECEF), height: 1), // Add divider here

// //                     // TabBar
// //                     Padding(
// //                       padding: const EdgeInsets.all(20), // Add padding here
// //                       child: DefaultTabController(
// //                         length: 2,
// //                         child: Column(
// //                           children: [
// //                             Container(
// //                               height: 48,
// //                               decoration: BoxDecoration(
// //                                 color: Colors.white54,
// //                                 borderRadius: BorderRadius.circular(10),
// //                               ),
// //                               child: TabBar(
// //                                 indicatorSize: TabBarIndicatorSize.label,
// //                                 indicator: const BoxDecoration(
// //                                   border: Border(
// //                                     bottom: BorderSide(
// //                                       color: Color(0xFF4C6FFF),
// //                                       width: 2.0,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 labelColor: const Color(0xFF4C6FFF),
// //                                 unselectedLabelColor: Colors.grey[600],
// //                                 labelStyle: const TextStyle(fontWeight: FontWeight.bold),
// //                                 tabs: [
// //                                   const Tab(text: 'Monthly Billing'),
// //                                   Tab(
// //                                     child: Row(
// //                                       mainAxisAlignment: MainAxisAlignment.center,
// //                                       children: [
// //                                         const Text('Annual Billing'),
// //                                         const SizedBox(width: 8),
// //                                         Container(
// //                                           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //                                           decoration: BoxDecoration(
// //                                             color: Colors.white,
// //                                             borderRadius: BorderRadius.circular(4),
// //                                           ),
// //                                           child: const Text(
// //                                             'Save 20%',
// //                                             style: TextStyle(
// //                                               color: Color(0xFF4C6FFF),
// //                                               fontSize: 10,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                             const SizedBox(height: 24),
// //                             const SizedBox(
// //                               height: 450, // Adjust height as needed
// //                               child: TabBarView(
// //                                 children: [
// //                                   MonthlyBillingScreen(),
// //                                   AnnualBillingScreen(),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/controllers/upgrade_plan_controller.dart';
// import 'package:synctrackr/admin/utils/colors.dart';
// import 'package:synctrackr/admin/widgets/common_header.dart';
// import 'package:synctrackr/admin/widgets/upgrade_plan_enterprise_card.dart';
// import 'package:synctrackr/admin/widgets/upgrade_plan_plan_card.dart';

// class UpgradePlan extends GetView<UpgradePlanController> {
//   const UpgradePlan({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(UpgradePlanController());
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Determine if the screen is wide enough for a row layout (web) or a column (tablet/mobile)
//         final isWeb = constraints.maxWidth > 720;

//         return CustomScrollView(
//       slivers: [
//         const SliverAppBar(
//           pinned: true,
//           automaticallyImplyLeading: false,
//           backgroundColor: AppColors.background,
//           elevation: 0,
//           scrolledUnderElevation: 0.0,
//           flexibleSpace: CommonHeader(title: "Settings"),
//         ),
//         SliverList(
//           delegate: SliverChildListDelegate([
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: AppColors.darkBorder),
//                   color: AppColors.darkBackground,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildHeader(),
//                     const Divider(color: Color(0xFFE9ECEF), height: 1),
//                     _buildTabSection(isWeb),
//                     _buildBottomButtons(),
//                   ],
//                 ),
//               ),
//             ),
//           ]),
//         ),
//       ],
//     );
//       },
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//            Text(
//             "Payment Details",
//             style: GoogleFonts.lexend(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.darkTextPrimary),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             "All transactions are secure and encrypted",
//             style: GoogleFonts.lexend(color: AppColors.darkTextSecondary),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabSection(bool isWeb) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: DefaultTabController(
//         length: 2,
//         initialIndex: controller.isAnnualBilling.value ? 1 : 0,
//         child: Column(
//           children: [
//             Container(
//               height: 48,
//               decoration: BoxDecoration(
//                 color: AppColors.darkSidebar,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: TabBar(
//                 onTap: (index) => controller.toggleBilling(index),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 indicator: BoxDecoration(
//                     color: AppColors.darkSecondaryBackground,
//                     borderRadius: BorderRadius.circular(8)),
//                 labelColor: AppColors.darkTextPrimary,
//                 unselectedLabelColor: AppColors.darkTextSecondary,
//                 labelStyle: const TextStyle(fontWeight: FontWeight.bold),
//                 tabs: [
//                   const Tab(text: 'Monthly Billing'),
//                   Tab(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text('Annual Billing'),
//                         const SizedBox(width: 8),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 6, vertical: 2),
//                           decoration: BoxDecoration(
//                             color: AppColors.background,
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: const Text(
//                             'Save 20%',
//                             style: TextStyle(
//                               color: Color(0xFF4C6FFF),
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             _buildAutoRenewalSwitch(),
//             const SizedBox(height: 24),
//             Obx(() => _buildPlanCards(isWeb)),
//             const SizedBox(height: 20),
//             EnterpriseCardWidget(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAutoRenewalSwitch() {
//     return Obx(
//       () => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Enable auto renewal",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.darkTextPrimary,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 "Checking this will auto-renew your plan after it expires",
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: AppColors.darkTextSecondary,
//                 ),
//               ),
//             ],
//           ),
//           Switch(
//             value: controller.autoRenewEnabled.value,
//             onChanged: controller.toggleAutoRenewal,
//             activeColor: AppColors.darkSecondary,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPlanCards(bool isWeb) {
//     final selectedId = controller.isAnnualBilling.value
//         ? controller.selectedAnnualPlanId.value
//         : controller.selectedMonthlyPlanId.value;

//     final cards = controller.plans.map((plan) {
//       return PlanCardWidget(
//         plan: plan,
//         isSelected: plan.id == selectedId,
//         isAnnualBilling: controller.isAnnualBilling.value,
//         onTap: () => controller.selectPlan(plan.id),
//       );
//     }).toList();

//     if (isWeb) {
//       List<Widget> spacedCards = [];
//       for (int i = 0; i < cards.length; i++) {
//         spacedCards.add(Expanded(child: cards[i]));
//         if (i < cards.length - 1) {
//           spacedCards.add(const SizedBox(width: 20));
//         }
//       }
//       return Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: spacedCards,
//       );
//     } else {
//       return Column(
//         children: cards
//             .map((card) => Padding(
//                   padding:
//                       const EdgeInsets.only(bottom: 20, right: 10, left: 10),
//                   child: card,
//                 ))
//             .toList(),
//       );
//     }
//   }

//   Widget _buildBottomButtons() {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: OutlinedButton(
//               onPressed: controller.exit,
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: AppColors.darkSecondary,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                 side: BorderSide(color: Colors.grey.shade300),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text(
//                 "Exit",
//                 style: TextStyle(color: AppColors.darkTextPrimary),
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: ElevatedButton(
//               onPressed: controller.purchasePlan,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.darkMainButton,
//                 foregroundColor: AppColors.darkBackground,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text(
//                 "Purchase Plan",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/upgrade_plan_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';
import 'package:synctrackr/admin/widgets/upgrade_plan_enterprise_card.dart';
import 'package:synctrackr/admin/widgets/upgrade_plan_plan_card.dart';

class UpgradePlan extends GetView<UpgradePlanController> {
  const UpgradePlan({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpgradePlanController());
    final MainController mainController = Get.find();

    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return LayoutBuilder(
        builder: (context, constraints) {
          final isWeb = constraints.maxWidth > 720;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                scrolledUnderElevation: 0.0,
                flexibleSpace: CommonHeader(title: "Settings"),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
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
                            ? adminAppColors.darkCard
                            : adminAppColors.cardBackground,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(isDarkMode),
                          Divider(
                              color: isDarkMode
                                  ? adminAppColors.darkBorder
                                  : const Color(0xFFE9ECEF),
                              height: 1),
                          _buildTabSection(isWeb, isDarkMode),
                          _buildBottomButtons(isDarkMode),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
      );
    });
  }

  Widget _buildHeader(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Details",
            style: GoogleFonts.lexend(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? adminAppColors.darkTextPrimary
                    : adminAppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            "All transactions are secure and encrypted",
            style: GoogleFonts.lexend(
                color: isDarkMode
                    ? adminAppColors.darkTextSecondary
                    : adminAppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection(bool isWeb, bool isDarkMode) {
    final UpgradePlanController controller = Get.find();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: DefaultTabController(
        length: 2,
        initialIndex: controller.isAnnualBilling.value ? 1 : 0,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDarkMode
                    ? adminAppColors.darkCard
                    : adminAppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: isDarkMode
                      ? adminAppColors.darkStatCard.withOpacity(0.5)
                      : adminAppColors.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: (index) => controller.toggleBilling(index),
                isScrollable: false,
                dividerColor: Colors.transparent,
                tabs: [
                  // Monthly Tab
                  Obx(
                    () {
                      final isSelected = !controller.isAnnualBilling.value;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            "Monthly Billing",
                            style: GoogleFonts.lexend(
                              fontSize: 15,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              color: isSelected
                                  ? (isDarkMode
                                      ? adminAppColors.primary
                                      : const Color(0xFF4C6FFF))
                                  : (isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF212529)),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            height: 1.5,
                            width: double.infinity,
                            color: isSelected
                                ? (isDarkMode
                                    ? adminAppColors.secondary
                                    : adminAppColors.primary)
                                : (isDarkMode
                                    ? Colors.white.withOpacity(0.2)
                                    : Colors.grey.shade400),
                          ),
                        ],
                      );
                    },
                  ),

                  // Annual Tab
                  Obx(
                    () {
                      final isSelected = controller.isAnnualBilling.value;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Annual Billing",
                                style: GoogleFonts.lexend(
                                  fontSize: 15,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  color: isSelected
                                      ? (isDarkMode
                                          ? adminAppColors.primary
                                          : const Color(0xFF4C6FFF))
                                      : (isDarkMode
                                          ? Colors.white
                                          : const Color(0xFF212529)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.transparent
                                      : adminAppColors.cardBackground,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "Save 20%",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? adminAppColors.darkPrimary
                                        : adminAppColors.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            height: 1.5,
                            width: double.infinity,
                            color: isSelected
                                ? (isDarkMode
                                    ? adminAppColors.secondary
                                    : adminAppColors.primary)
                                : (isDarkMode
                                    ? Colors.white.withOpacity(0.2)
                                    : Colors.grey.shade400),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildAutoRenewalSwitch(isDarkMode),
            const SizedBox(height: 24),
            Obx(() => _buildPlanCards(isWeb, isDarkMode)),
            const SizedBox(height: 20),
            EnterpriseCardWidget(isDarkMode: isDarkMode),
          ],
        ),
      ),
    );
  }

  // Widget _buildTabSection(bool isWeb, bool isDarkMode) {
  //   return Padding(
  //     padding: const EdgeInsets.all(20),
  //     child: DefaultTabController(
  //       length: 2,
  //       initialIndex: controller.isAnnualBilling.value ? 1 : 0,
  //       child: Column(
  //         children: [
  //           Container(
  //             decoration: BoxDecoration(
  //               color: isDarkMode
  //                   ? AppColors.darkCard
  //                   : AppColors.background,
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: TabBar(
  //               onTap: (index) => controller.toggleBilling(index),
  //               isScrollable: false,
  //               indicatorSize: TabBarIndicatorSize.label,
  //               indicator: BoxDecoration(
  //                 color: isDarkMode
  //                     ? AppColors.darkMainButton
  //                     : const Color(0xffBCD3FF),
  //                 borderRadius: const BorderRadius.only(
  //                   topLeft: Radius.circular(15),
  //                   topRight: Radius.circular(15),
  //                 ),
  //               ),
  //               dividerColor: Colors.transparent,
  //               labelPadding:
  //                   const EdgeInsets.symmetric(horizontal: 8),
  //               labelColor: isDarkMode
  //                   ? AppColors.primary
  //                   : const Color(0xFF4C6FFF),
  //               unselectedLabelColor:
  //                   isDarkMode
  //                       ? Colors.white
  //                       : const Color(0xFF212529),
  //               labelStyle: GoogleFonts.lexend(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w700,
  //               ),
  //               unselectedLabelStyle: GoogleFonts.lexend(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //               tabs: [
  //                 const Tab(text: 'Monthly Billing'),
  //                 Tab(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       const Text('Annual Billing'),
  //                       const SizedBox(width: 8),
  //                       Container(
  //                         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  //                         decoration: BoxDecoration(
  //                           color: isDarkMode ? Colors.transparent : AppColors.cardBackground,
  //                           borderRadius: BorderRadius.circular(4),
  //                         ),
  //                         child: Text(
  //                           'Save 20%',
  //                           style: TextStyle(
  //                             color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
  //                             fontSize: 10,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const SizedBox(height: 24),
  //           _buildAutoRenewalSwitch(isDarkMode),
  //           const SizedBox(height: 24),
  //           Obx(() => _buildPlanCards(isWeb, isDarkMode)),
  //           const SizedBox(height: 20),
  //           EnterpriseCardWidget(isDarkMode: isDarkMode),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildAutoRenewalSwitch(bool isDarkMode) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enable auto renewal",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode
                      ? adminAppColors.darkTextPrimary
                      : adminAppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Checking this will auto-renew your plan after it expires",
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode
                      ? adminAppColors.darkTextSecondary
                      : adminAppColors.textSecondary,
                ),
              ),
            ],
          ),
          Switch(
            value: controller.autoRenewEnabled.value,
            onChanged: controller.toggleAutoRenewal,
            activeColor: isDarkMode
                ? adminAppColors.darkSecondary
                : adminAppColors.primary,
            inactiveThumbColor:
                isDarkMode ? adminAppColors.darkTextSecondary : Colors.grey,
            inactiveTrackColor:
                isDarkMode ? adminAppColors.darkSidebar : Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCards(bool isWeb, bool isDarkMode) {
    final selectedId = controller.isAnnualBilling.value
        ? controller.selectedAnnualPlanId.value
        : controller.selectedMonthlyPlanId.value;

    final cards = controller.plans.map((plan) {
      return PlanCardWidget(
        plan: plan,
        isSelected: plan.id == selectedId,
        isAnnualBilling: controller.isAnnualBilling.value,
        onTap: () => controller.selectPlan(plan.id),
        isDarkMode: isDarkMode,
      );
    }).toList();

    if (isWeb) {
      List<Widget> spacedCards = [];
      for (int i = 0; i < cards.length; i++) {
        spacedCards.add(Expanded(child: cards[i]));
        if (i < cards.length - 1) {
          spacedCards.add(const SizedBox(width: 20));
        }
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: spacedCards,
      );
    } else {
      return Column(
        children: cards
            .map((card) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, right: 10, left: 10),
                  child: card,
                ))
            .toList(),
      );
    }
  }

  Widget _buildBottomButtons(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: controller.exit,
              style: OutlinedButton.styleFrom(
                backgroundColor: isDarkMode
                    ? adminAppColors.darkSidebar
                    : adminAppColors.secondary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                side: BorderSide(
                    color: isDarkMode
                        ? adminAppColors.darkBorder
                        : Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Exit",
                style: TextStyle(
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : adminAppColors.textPrimary),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: controller.purchasePlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode
                    ? adminAppColors.darkMainButton
                    : adminAppColors.primary,
                foregroundColor: isDarkMode ? Colors.black : Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Purchase Plan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
