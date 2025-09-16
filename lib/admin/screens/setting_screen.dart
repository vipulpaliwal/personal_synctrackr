// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:synctrackr/admin/screens/setting_account_screen.dart';
// import 'package:synctrackr/admin/widgets/common_header.dart';

// import '../controllers/setting_account_controller.dart';
// // Import the new account view file

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(AccountSettingsController());
//     final isWebOrTablet = MediaQuery.of(context).size.width > 600;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CommonHeader(title: 'Setting'),
//         Expanded(
//           child: DefaultTabController(
//             length: 5, // Number of tabs
//             child: Column(
//               children: [
//                 // Title
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     if (!isWebOrTablet)
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.wb_sunny_outlined),
//                             onPressed: () {},
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.notifications_outlined),
//                             onPressed: () {},
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.search_outlined),
//                             onPressed: () {},
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),

//                 // The TabBar
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: isWebOrTablet ? 25.0 : 16.0,
//                     vertical: 16.0,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: LayoutBuilder(builder: (context, constraints) {
//                     final isScrollable = constraints.maxWidth < 600;
//                     return TabBar(
//                       isScrollable: isScrollable,
//                       tabAlignment: isScrollable ? TabAlignment.start : TabAlignment.fill,
//                       indicatorSize: TabBarIndicatorSize.label,
//                     indicator: const BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           color: Color(0xFF007BFF), // Active tab underline color
//                           width: 2.0,
//                         ),
//                       ),
//                     ),
//                     labelColor: const Color(0xFF007BFF), // Active tab text color
//                     unselectedLabelColor:
//                         Colors.black, // Inactive tab text color
//                     labelStyle: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     unselectedLabelStyle: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     tabs: const [
//                       Tab(text: 'Account'),
//                       Tab(text: 'Payment'),
//                       Tab(text: 'Access Control'),
//                       Tab(text: 'Notifications'),
//                       Tab(text: 'Help'),
//                     ],
//                   );
//                   }),
//                 ),

//                 // TabBarView content
//                 Expanded(
//                   child: TabBarView(
//                     children: [
//                       // First tab content
//                       SettingsAccountView(),
//                       // Placeholder screens for other tabs
//                       const Center(child: Text('Payment Screen')),
//                       const Center(child: Text('Access Control Screen')),
//                       const Center(child: Text('Notifications Screen')),
//                       const Center(child: Text('Help Screen')),
//                     ],
//                   ),
//                 ),
//               ],
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
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/screens/setting_access_control_screen.dart';
import 'package:synctrackr/admin/screens/setting_account_screen.dart';
import 'package:synctrackr/admin/screens/setting_help_screen.dart';
import 'package:synctrackr/admin/screens/setting_notification_screen.dart';
import 'package:synctrackr/admin/screens/setting_payments_screen.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';
import '../controllers/setting_account_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AccountSettingsController());
    final isWebOrTablet = MediaQuery.of(context).size.width > 600;
    MainController mainController = Get.find();

    return Obx(() {
      final isdarkMode = mainController.isDarkMode.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonHeader(title: 'Setting'),
          Expanded(
            child: DefaultTabController(
              length: 5,
              child: Column(
                children: [
                  // TabBar with decoration
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: isWebOrTablet ? 25.0 : 16.0,
                      vertical: 16.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isScrollable = constraints.maxWidth < 600;
                        return TabBar(
                          isScrollable: isScrollable,
                          tabAlignment: isScrollable
                              ? TabAlignment.start
                              : TabAlignment.fill,
                          indicatorSize:
                              TabBarIndicatorSize.label, // pura tab fill karega
                          indicator: BoxDecoration(
                              color: isdarkMode
                                  ? adminAppColors.darkStatCard.withOpacity(0.7)
                                  : Color(0xffBCD3FF).withOpacity(
                                      0.7), // active tab ka background
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight:
                                      Radius.circular(15)) // thoda rounded
                              ),
                          labelColor: const Color(
                              0xFF4C6FFF), // active tab text color (blue)
                          unselectedLabelColor: isdarkMode
                              ? Colors.white
                              : Color(0xFF757575), // inactive text color
                          labelStyle: GoogleFonts.lexend(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          unselectedLabelStyle: GoogleFonts.lexend(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          dividerColor: Colors.transparent,
                          tabs: const [
                            // Tab(text: 'Account'),
                            // Tab(text: 'Payment'),
                            // Tab(text: 'Access Control'),
                            // Tab(text: 'Notifications'),
                            // Tab(text: 'Help'),

                            _CustomTab(text: 'Account'),
                            _CustomTab(text: 'Payment'),
                            _CustomTab(text: 'Access Control'),
                            _CustomTab(text: 'Notifications'),
                            _CustomTab(text: 'Help'),
                          ],
                        );
                      },
                    ),
                  ),

                  // TabBarView content
                  Expanded(
                    child: TabBarView(
                      children: [
                        SettingsAccountView(),
                        SettingPaymentsScreen(),
                        AccessControlScreen(),
                        NotificationsScreen(),
                        HelpScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

// class _CustomTab extends StatelessWidget {
//   final String text;
//   const _CustomTab({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(height: 30, child: Center(child: Text(text))),
//         const SizedBox(height: 6),
//         Container(
//           height: 1.5,
//           width: double.infinity,
//           color: adminAppColors.primary,
//         ),
//       ],
//     );
//   }
// }

//version 2
class _CustomTab extends StatelessWidget {
  final String text;
  const _CustomTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(text),
            ),
          ),
          Container(
            height: 2,
            width: double.infinity, // pura tab width cover karega
            color: adminAppColors.primary,
          ),
        ],
      ),
    );
  }
}

// version3



