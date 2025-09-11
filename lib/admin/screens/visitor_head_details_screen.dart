import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';
import 'package:synctrackr/admin/widgets/employee_list.dart';

class VisitorHeadDetailsScreen extends StatelessWidget {
  const VisitorHeadDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find();
    final employeeName = controller.selectedEmployee?.name ?? 'Details';

    return Obx(() {
      final isDarkMode = controller.isDarkMode.value;
      return Container(
        // color: isDarkMode ? Colors.black.withOpacity(0.5) : AppColors.background,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: isDarkMode ? Colors.transparent : Colors.white54,
              elevation: 0,
              scrolledUnderElevation: 0.0,
              flexibleSpace: CommonHeader(title: employeeName),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildProfileCard(employeeName, isDarkMode),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: EmployeeList(),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProfileCard(String employeeName, bool isDarkMode) {
    final MainController controller = Get.find();
    final employee = controller.selectedEmployee;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.black12.withOpacity(0.2)
                : Colors.white.withOpacity(0.35), // transparent white
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isDarkMode
                  ? Colors.white
                  : Colors.white.withOpacity(0.6), // subtle border
              width: 3,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileImage(isDarkMode),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          employee?.name ?? 'N/A',
                          style: GoogleFonts.lexend(
                            fontSize: 34,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? adminAppColors.darkTextPrimary
                                : Colors.black87,
                          ),
                        ),
                        Text(
                          employee?.position ?? 'N/A',
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? adminAppColors.darkTextSecondary
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (employee != null) {
                      Get.find<MainController>().visitorHeadUpdatePerson(employee);
                    }
                  },
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Update Profile'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : Colors.white,
                    backgroundColor:
                        isDarkMode ? adminAppColors.darkSecondary : Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const DottedDivider(),
              const SizedBox(height: 20),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: [
                  _buildInfoColumn(
                      'Department', employee?.department ?? 'N/A', isDarkMode),
                  _buildInfoColumn(
                      'Designation', employee?.position ?? 'N/A', isDarkMode),
                  _buildInfoColumn(
                      'Mobile No.', employee?.phone ?? 'N/A', isDarkMode),
                  _buildInfoColumn(
                      'Email Id', employee?.email ?? 'N/A', isDarkMode),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(bool isDarkMode) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(2), // border ki thickness
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isDarkMode
                  ? adminAppColors.darkPrimary
                  : Colors.blue, // Border ka color
              width: 1.5, // Border ki width
            ),
          ),
          child: const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage("https://placehold.co/100x100"),
          ),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () {},
          icon: ImageIcon(
            const AssetImage(AllImages.updateImageIcon), // thoda matching icon

            color: isDarkMode ? adminAppColors.darkTextPrimary : Colors.black87,
          ),
          label: Text(
            'Update Image',
            style: TextStyle(
              color:
                  isDarkMode ? adminAppColors.darkTextPrimary : Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: isDarkMode
                ? adminAppColors.darkSecondaryBackground
                : const Color(0xFFEAF2FF), // halka light blue bg
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // rounded corners
            ),
          ),
        )
      ],
    );
  }

  Widget _buildInfoColumn(String title, String value, bool isDarkMode) {
    return FractionallySizedBox(
      widthFactor: 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lexend(
                color: isDarkMode
                    ? adminAppColors.darkTextSecondary
                    : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? adminAppColors.darkTextPrimary : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class DottedDivider extends StatelessWidget {
  const DottedDivider({super.key, this.height = 1, this.color = Colors.grey});
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
