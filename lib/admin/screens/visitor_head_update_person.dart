import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/visitor_head_update_person_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'dart:io';

import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';

// Main Widget
class VisitorHeadUpdatePerson extends StatelessWidget {
  final VisitorHeadUpdateController controller;

  // Avatar colors - representing different avatar options
  final List<String> avatarImagePaths = [
    "assets/images/adminImages/avatar1.png",
    "assets/images/adminImages/avatar2.png",
    "assets/images/adminImages/avatar3.png",
    "assets/images/adminImages/avatar4.png",
    "assets/images/adminImages/avatar1.png",
    "assets/images/adminImages/avatar2.png",
    "assets/images/adminImages/avatar3.png",
    "assets/images/adminImages/avatar4.png",
    "assets/images/adminImages/avatar1.png",
    "assets/images/adminImages/avatar2.png",
    "assets/images/adminImages/avatar3.png",
    "assets/images/adminImages/avatar4.png"
  ];

  VisitorHeadUpdatePerson({required String headId, super.key})
      : controller = Get.put(VisitorHeadUpdateController(headId: headId));

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();

    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;

      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonHeader(title: "Update Person"),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: isDarkMode ? adminAppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        isDarkMode ? adminAppColors.secondary : Colors.grey[300]!,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                          ? Colors.black.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      "Visitor's Head",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? adminAppColors.darkTextPrimary
                            : Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Let's finish the profile of the head person",
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode
                            ? adminAppColors.darkTextSecondary
                            : Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 20),
        
                    // Avatar Selection Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side - Selected Avatar and Upload option
                        Column(
                          children: [
                            // Selected Avatar Circle
                            Obx(() {
                              final image = controller.customImage.value;
                              if (image != null) {
                                final provider = kIsWeb
                                    ? NetworkImage(image.path)
                                    : FileImage(File(image.path))
                                        as ImageProvider;
        
                                return Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: isDarkMode
                                            ? adminAppColors.darkBorder
                                            : Colors.grey[300]!,
                                        width: 2),
                                  ),
                                  child: CircleAvatar(
                                    radius: 38,
                                    backgroundImage: provider,
                                  ),
                                );
                              } else if (controller.selectedAvatarIndex.value !=
                                  -1) {
                                return CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                    avatarImagePaths[
                                        controller.selectedAvatarIndex.value],
                                  ),
                                );
                              } else {
                                return CircleAvatar(
                                  radius: 38,
                                  backgroundColor: isDarkMode
                                      ? adminAppColors.darkStatCard
                                      : Colors.grey[200],
                                  child: Icon(Icons.person,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.grey[500],
                                      size: 35),
                                );
                              }
                            }),
        
                            SizedBox(height: 12),
        
                            // Upload Image Button
                            GestureDetector(
                              onTap: () => controller.pickImage(),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isDarkMode
                                        ? adminAppColors.darkBorder
                                        : Colors.grey[300]!,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  color: isDarkMode
                                      ? adminAppColors.darkStatCard
                                      : Colors.grey[100],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.upload,
                                        color: isDarkMode
                                            ? adminAppColors.darkTextSecondary
                                            : Colors.grey[600],
                                        size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      "Upload Image",
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? adminAppColors.darkTextSecondary
                                            : Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
        
                        SizedBox(width: 20),
        
                        // Vertical divider line
                        Container(
                          width: 1,
                          height: 120,
                          color: isDarkMode
                              ? adminAppColors.darkBorder
                              : Colors.grey[300]!,
                        ),
        
                        SizedBox(width: 20),
        
                        // Right side - Avatar options and text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You can also select your avatar",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkMode
                                      ? adminAppColors.darkTextSecondary
                                      : Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 12),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final double avatarSize = 60;
                                  final double spacing = 12;
                                  final int itemsPerRow = (constraints.maxWidth /
                                          (avatarSize + spacing))
                                      .floor();
                                  final double maxWrapWidth =
                                      itemsPerRow * (avatarSize + spacing);
        
                                  return SizedBox(
                                    width: maxWrapWidth,
                                    child: Wrap(
                                      spacing: spacing,
                                      runSpacing: spacing,
                                      children: List.generate(
                                          avatarImagePaths.length, (index) {
                                        return Obx(() => GestureDetector(
                                              onTap: () =>
                                                  controller.selectAvatar(index),
                                              child: Container(
                                                  width: avatarSize,
                                                  height: avatarSize,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: controller
                                                                  .selectedAvatarIndex
                                                                  .value ==
                                                              index
                                                          ? (isDarkMode
                                                              ? adminAppColors
                                                                  .darkSecondary
                                                              : adminAppColors
                                                                  .primary)
                                                          : Colors.transparent,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: AssetImage(
                                                        avatarImagePaths[index]),
                                                  )),
                                            ));
                                      }),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
        
                    SizedBox(height: 25),
        
                    // Form Fields
                    Obx(() => _buildTextField(
                          label: "Full Name",
                          initialValue: controller.fullName.value,
                          onChanged: (value) => controller.fullName.value = value,
                          isDarkMode: isDarkMode,
                        )),
                    SizedBox(height: 16),
        
                    Obx(() => _buildTextField(
                          label: "Phone",
                          prefix: "+91",
                          initialValue: controller.phone.value,
                          onChanged: (value) => controller.phone.value = value,
                          keyboardType: TextInputType.phone,
                          isDarkMode: isDarkMode,
                        )),
                    SizedBox(height: 16),
        
                    Obx(() => _buildTextField(
                          label: "Email Id",
                          initialValue: controller.email.value,
                          onChanged: (value) => controller.email.value = value,
                          keyboardType: TextInputType.emailAddress,
                          isDarkMode: isDarkMode,
                        )),
                    SizedBox(height: 16),
        
                    Obx(() => _buildTextField(
                          label: "Department",
                          initialValue: controller.department.value,
                          onChanged: (value) =>
                              controller.department.value = value,
                          isDarkMode: isDarkMode,
                        )),
                    SizedBox(height: 16),
        
                    Obx(() => _buildTextField(
                          label: "Designation",
                          initialValue: controller.designation.value,
                          onChanged: (value) =>
                              controller.designation.value = value,
                          isDarkMode: isDarkMode,
                        )),
                    SizedBox(height: 20),
        
                    // Access Type
                    Text(
                      "Access Type",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode
                            ? adminAppColors.darkTextPrimary
                            : Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
        
                    Obx(() => Row(
                          children: [
                            Radio<String>(
                              value: 'Staff Person',
                              groupValue: controller.accessType.value,
                              onChanged: (value) =>
                                  controller.accessType.value = value!,
                              activeColor: isDarkMode
                                  ? adminAppColors.darkSecondary
                                  : adminAppColors.primary,
                            ),
                            Text(
                              'Staff Person',
                              style: TextStyle(
                                color: isDarkMode
                                    ? adminAppColors.darkTextSecondary
                                    : Colors.grey[600],
                              ),
                            ),
                            SizedBox(width: 20),
                            Radio<String>(
                              value: 'Admin',
                              groupValue: controller.accessType.value,
                              onChanged: (value) =>
                                  controller.accessType.value = value!,
                              activeColor: isDarkMode
                                  ? adminAppColors.darkSecondary
                                  : adminAppColors.primary,
                            ),
                            Text(
                              'Admin',
                              style: TextStyle(
                                color: isDarkMode
                                    ? adminAppColors.darkTextSecondary
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 30),
        
                    // Submit Button
                    Obx(() => controller.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => controller.submitForm(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDarkMode
                                    ? adminAppColors.darkMainButton
                                    : adminAppColors.primary,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward,
                                      color: isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      size: 20),
                                ],
                              ),
                            ),
                          )),
                    Obx(() {
                      if (controller.errorMessage.value.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            controller.errorMessage.value,
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTextField({
    required String label,
    String? prefix,
    required Function(String) onChanged,
    TextInputType? keyboardType,
    required bool isDarkMode,
    String? initialValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isDarkMode ? adminAppColors.primary : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(8),
            color: isDarkMode ? Colors.transparent : Colors.grey[50],
          ),
          child: TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: TextStyle(
              color:
                  isDarkMode ? adminAppColors.darkTextPrimary : Colors.black87,
            ),
            decoration: InputDecoration(
              labelText: label,
              prefixText: prefix != null ? "$prefix  " : null,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              labelStyle: TextStyle(
                color: isDarkMode
                    ? adminAppColors.darkTextSecondary
                    : Colors.grey[600],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
