import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/visitors_controller.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';
import 'package:synctrackr/admin/screens/visitor_dashboard.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';
import 'package:synctrackr/admin/widgets/custom_pagination.dart';
import 'package:synctrackr/admin/widgets/employee_list.dart';
import 'package:synctrackr/admin/widgets/stats_cards.dart';

class VisitorsScreen extends StatelessWidget {
  const VisitorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VisitorsController controller = Get.put(VisitorsController());
    final MainController mainController = Get.find();

    return LayoutBuilder(builder: (context, constraints) {
      return _buildMainContent(
          context, constraints, controller, mainController);
    });
  }

  Widget _buildMainContent(BuildContext context, BoxConstraints constraints,
      VisitorsController controller, MainController mainController) {
    final isTabletOrWeb = constraints.maxWidth >= 768;
    final isDesktop = constraints.maxWidth >= 1024;

    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor:
                isDarkMode ? Colors.black.withOpacity(0.1) : Colors.white54,
            elevation: 0,
            scrolledUnderElevation: 0.0,
            flexibleSpace: const CommonHeader(title: "Visitors"),
          ),
          SliverPadding(
            padding: EdgeInsets.all(isTabletOrWeb ? 24 : 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Stats Cards
                  StatsCards(
                      cardNames: ['visitors', 'checkin', 'checkout', 'add']),
                  SizedBox(height: isTabletOrWeb ? 24 : 16),

                  // Action Buttons
                  _buildActionButtons(constraints, mainController),
                  SizedBox(height: isTabletOrWeb ? 24 : 16),

                  

                  const SizedBox(height: 24),

                  EmployeeList()

                 
                ],
              ),
            ),
          )
        ],
      );
    });
  }

  Widget _buildActionButtons(
      BoxConstraints constraints, MainController mainController) {
    final isTabletOrWeb = constraints.maxWidth >= 768;
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;

      return Row(
        children: [
          Expanded(
            child: _buildActionButton(
              'Manual Check-In',
              ImageIcon(
                AssetImage(AllImages.exportIcon),
                color: isDarkMode ? adminAppColors.secondary : Colors.black,
              ),
              isTabletOrWeb,
              mainController,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              'Manual Check-Out',
              ImageIcon(
                AssetImage(AllImages.outIcon),
                color: isDarkMode ? adminAppColors.secondary : Colors.black,
              ),
              isTabletOrWeb,
              mainController,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              'Manual QR Scan',
              ImageIcon(
                AssetImage(AllImages.qrScan),
                color: isDarkMode ? adminAppColors.secondary : Colors.black,
              ),
              isTabletOrWeb,
              mainController,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildActionButton(String text, Widget icon, bool isTabletOrWeb,
      MainController mainController) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: isTabletOrWeb ? 16 : 8,
            vertical: isTabletOrWeb ? 12 : 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDarkMode
                ? adminAppColors.secondary
                : adminAppColors.primary, // Set border color
            width: 2.0, // Set border width
            style:
                BorderStyle.solid, // Set border style (solid, dashed, dotted)
          ),
          color: isDarkMode
              ? adminAppColors.darkSecondaryBackground
              : const Color(0xFFe4efff),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              text,
              style: GoogleFonts.lexend(
                fontSize: isTabletOrWeb ? 14 : 10,
                color: isDarkMode ? Colors.white : Color(0xFF374151),
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      );
    });
  }

 
}
