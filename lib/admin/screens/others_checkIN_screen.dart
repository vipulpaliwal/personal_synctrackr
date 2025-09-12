import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/others_checin_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';

class OthersCheckinScreen extends StatelessWidget {
  OthersCheckinScreen({super.key});

  final OthersCheckinController controller = Get.put(OthersCheckinController());
  final MainController mainController = Get.find();

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
          flexibleSpace: CommonHeader(title: "Check-In"),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: double.infinity),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildForm(),
                        ],
                      ),
                    )),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personalize this form',
            style: GoogleFonts.lexend(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Color(0xFF101828),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Personalize Your Check-In Form to Fit Your Needs',
            style: GoogleFonts.lexend(
              fontSize: 16,
              color: isDarkMode ? Colors.white : Color(0xFF667085),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildForm() {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDarkMode
              ? adminAppColors.darkMainBackground
              : adminAppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isDarkMode
                  ? adminAppColors.secondary
                  : adminAppColors.primary),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(16, 24, 40, 0.03),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Color.fromRGBO(16, 24, 40, 0.02),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(
              height: 20,
            ),
            _buildMobileSection(),
            const SizedBox(height: 24),
            _buildCustomTextField(label: 'Full Name'),
            const SizedBox(height: 16),
            _buildCustomTextField(label: 'Email Id'),
            const SizedBox(height: 16),
            _buildCustomTextField(label: 'Department'),
            const SizedBox(height: 16),
            _buildCustomTextField(label: 'Designation'),
            const SizedBox(height: 24),
            _buildIdProofSection(),
            const SizedBox(height: 24),
            _buildFormTypeOptions(),
            const SizedBox(height: 32),
            _buildSaveButton(),
          ],
        ),
      );
    });
  }

  Widget _buildMobileSection() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Need a mobile number?',
            value: controller.needMobileNumber.value,
            onChanged: controller.toggleMobileNumber,
          ),
          if (controller.needMobileNumber.value) ...[
            const SizedBox(height: 16),
            _buildPhoneInput(),
            const SizedBox(height: 16),
            _buildRadioGroup(
              title: 'Mobile with OTP',
              value: controller.mobileWithOTPRequired.value,
              onChanged: controller.setMobileWithOTP,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIdProofSection() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: 'Is it necessary to keep ID proof',
            value: controller.isIdProofRequired.value,
            onChanged: controller.toggleIdProofRequired,
          ),
          if (controller.isIdProofRequired.value) ...[
            const SizedBox(height: 16),
            _buildIdDropdown(),
            const SizedBox(height: 16),
            _buildCustomTextField(label: 'Enter ID no.'),
            const SizedBox(height: 16),
            _buildRadioGroup(
              title: 'Capture of an ID card',
              value: controller.idCaptureRequired.value,
              onChanged: controller.setIdCaptureRequired,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Color(0xFF344054),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF006AF4),
          ),
        ],
      );
    });
  }

  Widget _buildPhoneInput() {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                  color:
                      isDarkMode ? adminAppColors.primary : Color(0xFFD0D5DD)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text(
              '+91',
              style: GoogleFonts.lexend(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              controller: controller.phoneController,
              validator: controller.validatePhone,
              decoration: InputDecoration(
                hintText: 'Phone',
                hintStyle: GoogleFonts.lexend(
                    color: isDarkMode ? Colors.white : Colors.black),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkMode
                          ? adminAppColors.primary
                          : Color(0xFFD0D5DD)),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF006AF4)),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildCustomTextField({required String label}) {
    return Obx(
      () {
        final isDarkMode = mainController.isDarkMode.value;
        final controllerMap = {
          'Full Name': controller.fullNameController,
          'Email Id': controller.emailController,
          'Department': controller.departmentController,
          'Designation': controller.designationController,
          'Enter ID no.': controller.idNumberController,
        };
        final tc = controllerMap[label];
        return TextFormField(
          controller: tc,
          validator: (value) {
            if (label == 'Full Name') {
              return controller.validateRequired(value, fieldName: 'Full Name');
            }
            if (label == 'Email Id') {
              return controller.validateEmail(value);
            }
            if (label == 'Enter ID no.') {
              return controller.validateIdNumber(value);
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: label,
            hintStyle: GoogleFonts.lexend(
                color: isDarkMode ? Colors.white : Colors.black),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      isDarkMode ? adminAppColors.primary : Color(0xFFD0D5DD)),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF006AF4)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIdDropdown() {
    return Obx(() {
      final isdarkMode = mainController.isDarkMode.value;
      return DropdownButtonFormField<String>(
        value: controller.selectedIdType.value,
        items: controller.idTypes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: GoogleFonts.lexend(
                  color: isdarkMode ? Colors.white : Colors.black),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            controller.setSelectedIdType(newValue);
          }
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isdarkMode ? adminAppColors.primary : Color(0xFFD0D5DD)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF006AF4)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    });
  }

  Widget _buildRadioGroup({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 14,
              color: isDarkMode ? Colors.white : Color(0xFF344054),
            ),
          ),
          Row(
            children: [
              _buildRadioButton('Required', true, value, onChanged),
              const SizedBox(width: 16),
              _buildRadioButton('Not Required', false, value, onChanged),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildRadioButton(
    String label,
    bool radioValue,
    bool groupValue,
    ValueChanged<bool> onChanged,
  ) {
    final isSelected = radioValue == groupValue;
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return GestureDetector(
        onTap: () => onChanged(radioValue),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF006AF4)
                      : const Color(0xFFD0D5DD),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF006AF4),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 14,
                color: isDarkMode ? Colors.white : Color(0xFF344054),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildFormTypeOptions() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _buildFormTypeChip('Text Box', Icons.text_fields_outlined, true),
        _buildFormTypeChip('Dropdown', Icons.arrow_drop_down_circle_outlined),
        _buildFormTypeChip('Number', Icons.format_list_numbered),
        _buildFormTypeChip('Checkbox', Icons.check_box_outlined),
        _buildFormTypeChip('Radio Button', Icons.radio_button_checked_outlined),
      ],
    );
  }

  Widget _buildFormTypeChip(String label, IconData icon,
      [bool selected = false]) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? (isDarkMode
                  ? adminAppColors.darkSecondaryBackground
                  : const Color(0xFFF0F6FF))
              : (isDarkMode ? adminAppColors.darkMainBackground : Colors.white),
          border: Border.all(
            color: selected
                ? (isDarkMode
                    ? adminAppColors.secondary
                    : const Color(0xFF006AF4))
                : (isDarkMode
                    ? adminAppColors.darkBorder
                    : const Color(0xFFD0D5DD)),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: selected
                  ? (isDarkMode
                      ? adminAppColors.darkTextPrimary
                      : const Color(0xFF006AF4))
                  : (isDarkMode
                      ? adminAppColors.darkTextSecondary
                      : const Color(0xFF667085)),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: selected
                    ? (isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : const Color(0xFF006AF4))
                    : (isDarkMode
                        ? adminAppColors.darkTextSecondary
                        : const Color(0xFF344054)),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSaveButton() {
    return Obx(() {
      final isdarkMode = mainController.isDarkMode.value;
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            await controller.validateAndSave();
            Get.snackbar('Saved', 'Visitor form updated');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isdarkMode
                ? adminAppColors.darkMainButton
                : const Color(0xFF006AF4),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.isSaving.value ? 'Saving...' : 'Save',
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isdarkMode ? Colors.black : Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward,
                  color: isdarkMode ? Colors.black : Colors.white, size: 20),
            ],
          ),
        ),
      );
    });
  }
}
