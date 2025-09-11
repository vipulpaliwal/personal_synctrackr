import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/visitor_head_add_person_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'dart:io';

import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';

// Main Widget
class VisitorHeadAddPerson extends StatelessWidget {
  final VisitorController controller = Get.put(VisitorController());

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

  VisitorHeadAddPerson({super.key});

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
              const CommonHeader(title: "Add Person"),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: isDarkMode ? adminAppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDarkMode
                        ? adminAppColors.secondary
                        : Colors.grey[300]!,
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
                child: Form(
                  key: controller.formKey,
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
                      const SizedBox(height: 4),
                      Text(
                        "Let's finish the profile of the head person",
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode
                              ? adminAppColors.darkTextSecondary
                              : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 20),

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
                                } else if (controller
                                        .selectedAvatarIndex.value !=
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

                              const SizedBox(height: 12),

                              // Upload Image Button
                              GestureDetector(
                                onTap: () => controller.pickImage(),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
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
                                      const SizedBox(width: 4),
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

                          const SizedBox(width: 20),

                          // Vertical divider line
                          Container(
                            width: 1,
                            height: 120,
                            color: isDarkMode
                                ? adminAppColors.darkBorder
                                : Colors.grey[300]!,
                          ),

                          const SizedBox(width: 20),

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
                                const SizedBox(height: 12),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    const double avatarSize = 60;
                                    const double spacing = 12;
                                    final int itemsPerRow =
                                        (constraints.maxWidth /
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
                                                onTap: () => controller
                                                    .selectAvatar(index),
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
                                                            : Colors
                                                                .transparent,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage:
                                                          AssetImage(
                                                              avatarImagePaths[
                                                                  index]),
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

                      const SizedBox(height: 25),

                      // Form Fields
                      _buildTextFormField(
                        controller: controller.nameController,
                        label: "Full Name",
                        isDarkMode: isDarkMode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        controller: controller.mobileNumberController,
                        label: "Phone",
                        prefix: "+91",
                        keyboardType: TextInputType.phone,
                        isDarkMode: isDarkMode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        controller: controller.emailController,
                        label: "Email Id",
                        keyboardType: TextInputType.emailAddress,
                        isDarkMode: isDarkMode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address';
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        controller: controller.passwordController,
                        label: "Password",
                        isDarkMode: isDarkMode,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        controller: controller.deptController,
                        label: "Department",
                        isDarkMode: isDarkMode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a department';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        controller: controller.designationController,
                        label: "Designation",
                        isDarkMode: isDarkMode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a designation';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
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
                      // Obx(() => Row(
                      //       children: [
                      //         Radio<String>(
                      //           title: const Text('Staff'),
                      //           value: 'staff',
                      //           groupValue: controller.role.value,
                      //           onChanged: (value) {
                      //             if (value != null) {
                      //               controller.role.value = value;
                      //             }
                      //           },
                      //         ),
                      //         RadioListTile<String>(
                      //           title: const Text('Admin'),
                      //           value: 'admin',
                      //           groupValue: controller.role.value,
                      //           onChanged: (value) {
                      //             if (value != null) {
                      //               controller.role.value = value;
                      //             }
                      //           },
                      //         ),
                      //       ],
                      //     )),

                      Obx(() => Row(
                            children: [
                              Radio<String>(
                                value: 'staff',
                                groupValue: controller.role.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.role.value = value;
                                  }
                                },
                              ),
                              const Text('Staff Person'),

                              const SizedBox(
                                  width: 20), // thoda gap dono ke beech

                              Radio<String>(
                                value: 'admin',
                                groupValue: controller.role.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.role.value = value;
                                  }
                                },
                              ),
                              const Text('Admin'),
                            ],
                          )),

                      const SizedBox(height: 30),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.submitForm(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDarkMode
                                ? adminAppColors.darkMainButton
                                : adminAppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
                                  color:
                                      isDarkMode ? Colors.black : Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.arrow_forward,
                                  color:
                                      isDarkMode ? Colors.black : Colors.white,
                                  size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    String? prefix,
    TextInputType? keyboardType,
    required bool isDarkMode,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(
        color: isDarkMode ? adminAppColors.darkTextPrimary : Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefix != null ? "$prefix  " : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? adminAppColors.primary : Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? adminAppColors.primary : Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? adminAppColors.primary : adminAppColors.primary,
          ),
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.transparent : Colors.grey[50],
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        labelStyle: TextStyle(
          color:
              isDarkMode ? adminAppColors.darkTextSecondary : Colors.grey[600],
        ),
        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
      validator: validator,
    );
  }
}
