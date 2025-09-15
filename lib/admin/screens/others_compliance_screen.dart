import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/others_compliance_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';

class OthersComplianceScreen extends StatelessWidget {
  const OthersComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ComplianceController controller = Get.put(ComplianceController());
    final MainController mainController = Get.find();

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          flexibleSpace: CommonHeader(title: "Compliance"),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    final isDarkMode = mainController.isDarkMode.value;
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? adminAppColors.darkMainBackground
                            : adminAppColors.background,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: isDarkMode
                                ? adminAppColors.secondary
                                : adminAppColors.primary),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Custom Compliances',
                            style: GoogleFonts.lexend(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? adminAppColors.darkTextPrimary
                                    : Colors.black),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Customize Your Safety and Health Compliance to Meet Your Needs',
                            style: GoogleFonts.lexend(
                                fontSize: 14,
                                color: isDarkMode
                                    ? adminAppColors.darkTextSecondary
                                    : Colors.black54),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Do you want to see Compliances ?',
                                style: GoogleFonts.lexend(
                                    fontSize: 16,
                                    color: isDarkMode
                                        ? adminAppColors.darkTextPrimary
                                        : Colors.black),
                              ),
                              Switch(
                                value: controller.showCompliance.value,
                                onChanged: controller.toggleCompliance,
                                activeColor: const Color(0xFF006AF4),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (controller.showCompliance.value)
                            ...controller.questions
                                .asMap()
                                .entries
                                .map((entry) {
                              final index = entry.key;
                              final question = entry.value;
                              return ComplianceQuestion(
                                index: index,
                                question: question,
                                onChanged: (value) {
                                  controller.updateQuestion(index, value);
                                },
                                onDelete: () => controller.deleteCompliance(index),
                              );
                            }),
                          const SizedBox(height: 12),
                          Center(
                            child: TextButton.icon(
                              onPressed: controller.addNewCompliance,
                              icon: const Icon(Icons.add_circle_outline,
                                  color: Color(0xFF006AF4)),
                              label: Text(
                                'New Compliance',
                                style: GoogleFonts.lexend(
                                    fontSize: 16,
                                    color: const Color(0xFF006AF4),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await controller.saveCompliances();
                                Get.snackbar('Saved', 'Compliances updated');
                              },
                              icon: Icon(
                                Icons.arrow_forward,
                                color: isDarkMode
                                    ? Colors.black
                                    : adminAppColors.background,
                              ),
                              label: Text(
                                controller.isSaving.value
                                    ? 'Saving...'
                                    : 'Save',
                                style: GoogleFonts.lexend(
                                    color: isDarkMode
                                        ? Colors.black
                                        : adminAppColors.background),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: isDarkMode
                                    ? adminAppColors.darkMainButton
                                    : const Color(0xFF006AF4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class ComplianceQuestion extends StatelessWidget {
  final int index;
  final String question;
  final ValueChanged<String> onChanged;
  final VoidCallback onDelete;

  const ComplianceQuestion({
    super.key,
    required this.index,
    required this.question,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isDarkMode
              ? adminAppColors.darkBackground
              : adminAppColors.background,
          border: Border.all(
              color:
                  isDarkMode ? adminAppColors.primary : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              '${index + 1}.',
              style: TextStyle(
                  color: isDarkMode
                      ? adminAppColors.darkTextPrimary
                      : Colors.black),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                initialValue: question,
                onChanged: onChanged,
                style: TextStyle(
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : Colors.black),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: isDarkMode ? Colors.redAccent : Colors.red,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      );
    });
  }
}
