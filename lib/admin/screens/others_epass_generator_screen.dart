
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/others_epass_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';
import 'package:synctrackr/admin/widgets/bulk_pass_section.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';
import 'package:synctrackr/admin/widgets/others%20_event%20_e%20_pass_generated_section.dart';

class OthersEpassGenerator extends StatelessWidget {
  final EPassController controller = Get.put(EPassController());
  final MainController mainController = Get.find();

  OthersEpassGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          flexibleSpace: CommonHeader(title: "EPass Generator"),
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
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? adminAppColors.darkMainBackground
                              : adminAppColors.background,
                          border: Border.all(
                            color: isDarkMode
                                ? adminAppColors.secondary
                                : adminAppColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Event E-Pass Generator',
                              style: GoogleFonts.lexend(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? Colors.white
                                    : adminAppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Start by using the manual entry form or bulk upload feature.',
                              style: GoogleFonts.lexend(
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Colors.grey),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              'Generate New Passes',
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildPassTypeSelector(),
                            const SizedBox(height: 24),
                            _buildBulkUploadSection(),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(child: Divider()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text('OR',
                                      style: GoogleFonts.lexend(
                                          color: isDarkMode
                                              ? Colors.white70
                                              : Colors.grey)),
                                ),
                                Expanded(child: Divider()),
                              ],
                            ),
                            const SizedBox(height: 24),
                            _buildManualEntryForm(),
                            const SizedBox(height: 32),
                            _buildGeneratePassButton(),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  OthersEventEPassGeneratedSection()
                                  ],
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildPassTypeSelector() {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pass Type',
            style: GoogleFonts.lexend(
                fontSize: 14, color: isDarkMode ? Colors.white : Colors.black),
          ),
          Row(
            children: [
              Radio<String>(
                value: 'Guest Pass',
                groupValue: controller.passType.value,
                onChanged: controller.setPassType,
                activeColor: const Color(0xFF4F46E5),
              ),
              Text(
                'Guest Pass',
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              const SizedBox(width: 20),
              Radio<String>(
                value: 'Management Staff',
                groupValue: controller.passType.value,
                onChanged: controller.setPassType,
                activeColor: const Color(0xFF4F46E5),
              ),
              Text(
                'Management Staff',
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildBulkUploadSection() {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return ExpansionTile(
        iconColor: isDarkMode ? Colors.white : Colors.black,
        collapsedIconColor: isDarkMode ? Colors.white : Colors.black,
        initiallyExpanded: true,
        title: Text(
          'Bulk Upload (CSV/Excel)',
          style: GoogleFonts.lexend(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black),
        ),
        children: [
          const SizedBox(height: 16),
          GestureDetector(
            onTap: controller.pickFile,
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: const Radius.circular(12),
                color: isDarkMode
                    ? adminAppColors.secondary
                    : adminAppColors.primary,
                strokeWidth: 2,
                dashPattern: const [8, 4],
              ),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? adminAppColors.darkSecondaryBackground.withOpacity(0.5)
                      : adminAppColors.mainBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage(AllImages.bulkUploadIcon),
                        size: 40,
                        color:
                            isDarkMode ? Colors.white70 : Colors.grey.shade600),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Drag your file(s) or ',
                          style: GoogleFonts.lexend(
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                        Text(
                          ' browse',
                          style: GoogleFonts.lexend(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text('Max 10 MB files are allowed',
                        style: GoogleFonts.lexend(
                            fontSize: 12,
                            color: isDarkMode
                                ? Colors.white70
                                : Colors.grey.shade600)),
                    Text('Only support .csv, .xlsx and .xls files',
                        style: GoogleFonts.lexend(
                            fontSize: 10,
                            color: isDarkMode
                                ? Colors.white70
                                : Colors.grey.shade500)),
                  ],
                ),
              ),
            ),
          ),
          Obx(() => controller.uploadedFileName.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    leading:
                        const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(
                      controller.uploadedFileName.value,
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.close,
                          color: isDarkMode ? Colors.white : Colors.black),
                      onPressed: controller.removeFile,
                    ),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      );
    });
  }

  Widget _buildManualEntryForm() {
    final isDarkMode = mainController.isDarkMode.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manual Entry',
          style: GoogleFonts.lexend(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isDarkMode ? Colors.white : Colors.black),
        ),
        const SizedBox(height: 16),
        _buildCustomTextField(
            label: 'Full Name',
            onChanged: (val) => controller.fullName.value = val),
        const SizedBox(height: 16),
        _buildCustomTextField(
            label: 'Email Id',
            onChanged: (val) => controller.email.value = val),
        const SizedBox(height: 16),
        _buildCustomTextField(
            label: 'Department',
            onChanged: (val) => controller.department.value = val),
        const SizedBox(height: 16),
        _buildCustomTextField(
            label: 'Designation',
            onChanged: (val) => controller.designation.value = val),
      ],
    );
  }

  Widget _buildCustomTextField(
      {required String label, required ValueChanged<String> onChanged}) {
    return Obx(
      () {
        final isDarkMode = mainController.isDarkMode.value;
        return TextField(
          onChanged: onChanged,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          decoration: InputDecoration(
            labelText: label,
            labelStyle:
                TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: isDarkMode
                      ? adminAppColors.secondary
                      : adminAppColors.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: isDarkMode ? adminAppColors.primary : Colors.blue),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGeneratePassButton() {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDarkMode
                ? adminAppColors.darkMainButton
                : const Color(0xFF4F46E5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: controller.generatePass,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Generate Pass',
                style: GoogleFonts.lexend(
                  color: isDarkMode ? Colors.black : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward,
                  color: isDarkMode ? Colors.black : Colors.white),
            ],
          ),
        ),
      );
    });
  }
}
