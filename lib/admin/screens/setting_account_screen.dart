import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/setting_account_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/notification_bar.dart';

class SettingsAccountView extends StatelessWidget {
  final controller = Get.put(AccountSettingsController());
  final MainController mainController = Get.find();

  SettingsAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(() {
                  final isDarkMode = mainController.isDarkMode.value;
                  return Container(
                    width: double.infinity,
                    // margin: const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: isDarkMode
                              ? adminAppColors.secondary
                              : adminAppColors.primary),
                      color: isDarkMode
                          ? adminAppColors.darkMainBackground
                          : adminAppColors.background,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Account Information Container
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Account information",
                                style: GoogleFonts.lexend(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xFF212529)),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Update your logo and account details here",
                                style: GoogleFonts.lexend(
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Colors.grey.shade600),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Your Logo",
                                style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xFF212529)),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "This will be displayed on your profile",
                                style: GoogleFonts.lexend(
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Colors.grey.shade600,
                                    fontSize: 12),
                              ),
                              const SizedBox(height: 8),
                              DottedBorderBox(
                                onTap: controller.pickFile,
                                selectedFile: controller.selectedFile,
                              ),
                              const SizedBox(height: 16),
                              buildTextField(
                                "Name",
                                controller.nameController,
                                hintText: "Company pvt. ltd.",
                              ),
                              const SizedBox(height: 16),
                              buildTextField(
                                "Email Id",
                                controller.emailController,
                                hintText: "admin@company.com",
                              ),
                              const SizedBox(height: 16),
                              buildPhoneField(
                                "Phone Number",
                                controller.phoneController,
                                hintText: "9811234567",
                              ),
                            ],
                          ),
                        ),

                        const Divider(color: Color(0xFFE9ECEF), height: 1),

                        // Security Container
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Security",
                                style: GoogleFonts.lexend(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xFF212529)),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Manage preferences securely",
                                style: GoogleFonts.lexend(
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Colors.grey.shade600),
                              ),
                              const SizedBox(height: 16),
                              _buildSecurityItem(
                                "Password",
                                "Change Password",
                                Icons.lock_outline,
                                () {},
                              ),
                              const SizedBox(height: 16),
                              _buildSecurityItem(
                                "Manage Logged Devices",
                                "View all active login",
                                null,
                                () {},
                              ),
                              const SizedBox(height: 16),
                              _buildToggleItem(
                                "Two-Factor Authentication (2FA)",
                                "Extra security via OTP/mail",
                                controller.twoFA,
                                controller.toggle2FA,
                              ),
                              const SizedBox(height: 16),
                              _buildToggleItem(
                                "Login Alerts",
                                "Notify on new/unfamiliar logins",
                                controller.loginAlerts,
                                controller.toggleLoginAlerts,
                              ),
                            ],
                          ),
                        ),

                        const Divider(color: Color(0xFFE9ECEF), height: 1),

                        // Buttons Container
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF212529),
                                  side: const BorderSide(
                                      color: Color(0xFFADB5BD)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                ),
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.lexend(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isDarkMode
                                      ? adminAppColors.darkMainButton
                                      : Color(0xFF4C6FFF),
                                  foregroundColor:
                                      isDarkMode ? Colors.black : Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                ),
                                child: Text("Save Changes",style: GoogleFonts.lexend()),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }))));
  }

  Widget _buildSecurityItem(
      String title, String buttonText, IconData? icon, VoidCallback onPressed) {
    final isDarkMode = mainController.isDarkMode.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.lexend(
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Color(0xFF212529)),
        ),
        SizedBox(
          height: 38,
          child: OutlinedButton.icon(
            onPressed: onPressed,
            icon: icon != null
                ? Icon(icon,
                    size: 16,
                    color: isDarkMode ? Colors.white : const Color(0xFF212529))
                : const SizedBox.shrink(),
            label: Text(
              buttonText,
              style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: isDarkMode ? Colors.white : Color(0xFF212529)),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: isDarkMode
                      ? adminAppColors.secondary
                      : const Color(0xFFADB5BD)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleItem(
      String title, String subtitle, RxBool value, Function(bool) onChanged) {
    final isDarkMode = mainController.isDarkMode.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Color(0xFF212529)),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.lexend(
                  fontSize: 12,
                  color: isDarkMode ? Colors.white70 : Colors.grey.shade600),
            ),
          ],
        ),
        Obx(
          () => Switch(
            value: value.value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF4C6FFF),
            inactiveTrackColor: const Color(0xFFADB5BD),
            inactiveThumbColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {String? hintText}) {
    final isDarkMode = mainController.isDarkMode.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lexend(
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Color(0xFF212529)),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: GoogleFonts.lexend(color: isDarkMode ? Colors.white : Colors.black),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.lexend(
                color: isDarkMode ? Colors.white70 : Color(0xFF6C757D)),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.edit_outlined,
                  color: isDarkMode ? Colors.white70 : Color(0xFFADB5BD)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: isDarkMode
                      ? adminAppColors.secondary
                      : const Color(0xFFDEE2E6)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: isDarkMode
                      ? adminAppColors.secondary
                      : const Color(0xFFDEE2E6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: isDarkMode
                      ? adminAppColors.primary
                      : const Color(0xFF4C6FFF)),
            ),
            filled: true,
            fillColor: isDarkMode
                ? adminAppColors.darkSecondaryBackground.withOpacity(0.5)
                : Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget buildPhoneField(String label, TextEditingController controller,
      {String? hintText}) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.lexend(
                fontWeight: FontWeight.w500, color: Color(0xFF212529)),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? adminAppColors.darkSecondaryBackground.withOpacity(0.5)
                      : Colors.white,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(8)),
                  border: Border(
                    top: BorderSide(
                        color: isDarkMode
                            ? adminAppColors.secondary
                            : Color(0xFFDEE2E6)),
                    bottom: BorderSide(
                        color: isDarkMode
                            ? adminAppColors.secondary
                            : Color(0xFFDEE2E6)),
                    left: BorderSide(
                        color: isDarkMode
                            ? adminAppColors.secondary
                            : Color(0xFFDEE2E6)),
                  ),
                ),
                child: Text(
                  "+91",
                  style: GoogleFonts.lexend(
                      color: isDarkMode ? Colors.white : Color(0xFF6C757D)),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.lexend(),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: GoogleFonts.lexend(
                        color:
                            isDarkMode ? Color(0xFFADB5BD) : Color(0xFF6C757D)),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child:
                          Icon(Icons.edit_outlined, color: Color(0xFFADB5BD)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(8)),
                      borderSide: BorderSide(
                          color: isDarkMode
                              ? adminAppColors.primary
                              : Color(0xFFDEE2E6)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8)),
                      borderSide: BorderSide(
                          color: isDarkMode
                              ? adminAppColors.secondary
                              : Color(0xFFDEE2E6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8)),
                      borderSide: const BorderSide(color: adminAppColors.secondary),
                    ),
                    filled: true,
                    fillColor: isDarkMode
                        ? adminAppColors.darkSecondaryBackground.withOpacity(0.5)
                        : Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
              )
            ],
          )
        ],
      );
    });
  }
}

class DottedBorderBox extends StatelessWidget {
  final VoidCallback onTap;
  final Rx<PlatformFile?> selectedFile;

  const DottedBorderBox({
    super.key,
    required this.onTap,
    required this.selectedFile,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return GestureDetector(
        onTap: onTap,
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: Radius.circular(12),
            color: isDarkMode
                ? adminAppColors.secondary
                : adminAppColors.primary,
            strokeWidth: 1,
            dashPattern: const [6, 6],
          ),
          child: Obx(() {
            if (selectedFile.value != null) {
              return Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? adminAppColors.darkSecondaryBackground.withOpacity(0.5)
                      : adminAppColors.secondary.withBlue(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 32,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedFile.value!.name,
                          style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'File size: ${(selectedFile.value!.size / 1024).toStringAsFixed(2)} KB',
                          style: GoogleFonts.lexend(
                              fontSize: 12, color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    OutlinedButton(
                      onPressed: onTap,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFADB5BD)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: Text(
                        'Change',
                        style: GoogleFonts.lexend(color: Color(0xFF212529)),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? adminAppColors.darkSecondaryBackground.withOpacity(0.5)
                      : adminAppColors.mainBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_upload_outlined,
                        size: 32,
                        color: Color(0xFFADB5BD),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Drag your image(s) or ",
                              style: GoogleFonts.lexend(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.grey.shade600,
                                  fontSize: 14),
                            ),
                            TextSpan(
                              text: "browse",
                              style: GoogleFonts.lexend(
                                color: Color(0xFF4C6FFF),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Max 2 MB files are allowed",
                        style: GoogleFonts.lexend(
                            fontSize: 12,
                            color: isDarkMode
                                ? Colors.white
                                : Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
        ),
      );
    });
  }
}
