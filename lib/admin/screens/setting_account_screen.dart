import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/setting_account_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';
import 'package:synctrackr/admin/widgets/notification_bar.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SettingsAccountView extends StatefulWidget {
  const SettingsAccountView({super.key});

  @override
  State<SettingsAccountView> createState() => _SettingsAccountViewState();
}

class _SettingsAccountViewState extends State<SettingsAccountView> {
  final controller = Get.put(AccountSettingsController());
  final MainController mainController = Get.find();
  final ApiService apiService = ApiService();

  // State variables for editability - initially all fields are editable
  bool isNameEditable = false;
  bool isEmailEditable = false;
  bool isPhoneEditable = false;

  // Loading and error states
  bool isLoading = true;
  bool isSaving = false;
  String? errorMessage;

  // Company data
  Map<String, dynamic>? companyData;
  String? uploadedLogoUrl;

  // Original data for comparison
  String? originalName;
  String? originalEmail;
  String? originalPhone;

  @override
  void initState() {
    super.initState();
    loadCompanyData(isRetry: false);
  }

  Future<void> loadCompanyData({bool isRetry = true}) async {
    if (!isRetry) {
      await _loadFromCache();
    }

    if (isRetry) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });
    }

    try {
      final companyId = await SessionManager.getCompanyId();
      if (companyId == null || companyId.isEmpty) {
        if (companyData == null) {
          setState(() {
            errorMessage = 'Company ID not found. Please log in again.';
            isLoading = false;
          });
        }
        return;
      }

      final result = await apiService.getCompany(companyId);

      if (result['success'] == true && result['data'] != null) {
        final data = result['data'];
        await _updateAndCache(data);
      } else if (companyData == null) {
        setState(() {
          errorMessage = result['message'] ?? 'Failed to load company data';
          isLoading = false;
        });
      }
    } catch (e) {
      if (companyData == null) {
        setState(() {
          errorMessage = 'Network error: ${e.toString()}';
          isLoading = false;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('companyData');
    if (cachedData != null) {
      setState(() {
        companyData = json.decode(cachedData);
        _populateFields(companyData!);
        isLoading = false; // Show cached data immediately
      });
    }
  }

  Future<void> _updateAndCache(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('companyData', json.encode(data));
    if (mounted) {
      setState(() {
        companyData = data;
        _populateFields(data);
      });
    }
  }

  void _populateFields(Map<String, dynamic> data) {
    originalName = data['companyName'] ?? '';
    originalEmail = data['email'] ?? '';
    originalPhone = data['phone'] ?? '';
    controller.nameController.text = originalName!;
    controller.emailController.text = originalEmail!;
    controller.phoneController.text = originalPhone!;
    uploadedLogoUrl = data['companyLogo'];
  }

  // Test method to directly call API with company ID 1
  Future<void> testDirectApiCall() async {
    try {
      print('DEBUG: Testing direct API call with company ID 1');
      final result = await apiService.getCompany('1');
      print('DEBUG: Direct API test result = $result');

      if (result['success'] == true && result['data'] != null) {
        final data = result['data'];
        print('DEBUG: Direct API test - Company data = $data');
        print('DEBUG: Direct API test - Name: ${data['companyName']}, Email: ${data['email']}, Phone: ${data['phone']}');
      } else {
        print('DEBUG: Direct API test failed: ${result['message']}');
      }
    } catch (e) {
      print('DEBUG: Direct API test exception: $e');
    }
  }

  Future<void> saveCompanyChanges() async {
    // Input validation
    final companyName = controller.nameController.text.trim();
    final email = controller.emailController.text.trim();
    final phone = controller.phoneController.text.trim();

    // Validate company name
    if (companyName.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Company name cannot be empty',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (companyName.length < 2) {
      Get.snackbar(
        'Validation Error',
        'Company name must be at least 2 characters long',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // Validate email
    if (email.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Email cannot be empty',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      Get.snackbar(
        'Validation Error',
        'Please enter a valid email address',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // Validate phone
    if (phone.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Phone number cannot be empty',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (phone.length < 10) {
      Get.snackbar(
        'Validation Error',
        'Phone number must be at least 10 digits',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // Check if any data has changed
    if (originalName == companyName &&
        originalEmail == email &&
        originalPhone == phone &&
        uploadedLogoUrl == companyData?['companyLogo']) {
      Get.snackbar(
        'No Changes',
        'No changes detected to save',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      final companyId = await SessionManager.getCompanyId();
      if (companyId == null) {
        Get.snackbar(
          'Error',
          'Session expired. Please log in again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final result = await apiService.updateCompany(
        companyId: companyId,
        companyName: companyName,
        email: email,
        phone: phone,
        companyLogo: uploadedLogoUrl,
      );

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          'Company details updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Reload data to reflect changes
        await loadCompanyData();
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Failed to update company details',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Network error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  Future<void> uploadLogo(String filePath) async {
    try {
      final companyId = await SessionManager.getCompanyId();
      if (companyId == null) return;

      final result = await apiService.uploadCompanyLogo(
        companyId: companyId,
        filePath: filePath,
      );

      if (result['success'] == true) {
        setState(() {
          uploadedLogoUrl = result['logoUrl'];
        });
        Get.snackbar(
          'Success',
          'Logo uploaded successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Failed to upload logo',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Network error occurred',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(() {
              final isDarkMode = mainController.isDarkMode.value;
    
              // Show loading state
              if (isLoading) {
                return Container(
                  width: double.infinity,
                  height: 400,
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isDarkMode
                                ? adminAppColors.primary
                                : Color(0xFF4C6FFF),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Loading company details...',
                          style: GoogleFonts.lexend(
                            color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
    
              // Show error state
              if (errorMessage != null) {
                return Container(
                  width: double.infinity,
                  height: 400,
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error Loading Data',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Retry button removed as per request
                      ],
                    ),
                  ),
                );
              }
    
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
                          Row(
                            children: [
                              Text(
                                "Your Logo",
                                style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xFF212529)),
                              ),
                              if (uploadedLogoUrl != null) ...[
                                const SizedBox(width: 16),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isDarkMode
                                          ? adminAppColors.secondary
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      uploadedLogoUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(
                                          Icons.business,
                                          color: isDarkMode
                                              ? Colors.white70
                                              : Colors.grey.shade400,
                                          size: 20,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ],
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
                            onTap: () async {
                              final result = await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );
                              if (result != null && result.files.isNotEmpty) {
                                final filePath = result.files.first.path;
                                if (filePath != null) {
                                  await uploadLogo(filePath);
                                }
                              }
                            },
                            selectedFile: controller.selectedFile,
                          ),
                          const SizedBox(height: 16),
                          buildEditableTextField(
                            "Name",
                            controller.nameController,
                            hintText: "Company pvt. ltd.",
                            isEditable: isNameEditable,
                            onEditToggle: () => setState(() => isNameEditable = !isNameEditable),
                          ),
                          const SizedBox(height: 16),
                          buildEditableTextField(
                            "Email Id",
                            controller.emailController,
                            hintText: "admin@company.com",
                            isEditable: isEmailEditable,
                            onEditToggle: () => setState(() => isEmailEditable = !isEmailEditable),
                          ),
                          const SizedBox(height: 16),
                          buildEditablePhoneField(
                            "Phone Number",
                            controller.phoneController,
                            hintText: "9811234567",
                            isEditable: isPhoneEditable,
                            onEditToggle: () => setState(() => isPhoneEditable = !isPhoneEditable),
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
                            onPressed: () {
                              // Reset all edit states to non-editable (show pencil icons)
                              setState(() {
                                isNameEditable = false;
                                isEmailEditable = false;
                                isPhoneEditable = false;
                              });
                              // Reload original data
                              loadCompanyData();
                            },
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
                            onPressed: saveCompanyChanges,
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
            })));
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
            inactiveTrackColor:isDarkMode?Colors.black12: const Color(0xFFADB5BD),
            inactiveThumbColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildEditableTextField(
    String label,
    TextEditingController controller, {
    String? hintText,
    required bool isEditable,
    required VoidCallback onEditToggle,
  }) {
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
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                enabled: isEditable,
                style: GoogleFonts.lexend(
                    color: isEditable
                        ? (isDarkMode ? Colors.white : Colors.black)
                        : (isDarkMode ? Colors.white60 : Colors.grey.shade600)),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: GoogleFonts.lexend(
                      color: isDarkMode ? Colors.white70 : Color(0xFF6C757D)),
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
                        color: isEditable
                            ? (isDarkMode ? adminAppColors.primary : const Color(0xFF4C6FFF))
                            : (isDarkMode ? adminAppColors.secondary : const Color(0xFFDEE2E6))),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode ? adminAppColors.secondary : const Color(0xFFDEE2E6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? adminAppColors.primary
                            : const Color(0xFF4C6FFF)),
                  ),
                  filled: true,
                  fillColor: isEditable
                      ? (isDarkMode
                          ? adminAppColors.darkSecondaryBackground.withOpacity(0.5)
                          : Colors.white)
                      : (isDarkMode
                          ? adminAppColors.darkSecondaryBackground.withOpacity(0.3)
                          : Colors.grey.shade50),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onEditToggle,
              icon: Icon(
                isEditable ? Icons.check : Icons.edit_outlined,
                color: isEditable
                    ? Colors.green
                    : (isDarkMode ? Colors.white70 : Color(0xFFADB5BD)),
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildEditablePhoneField(
    String label,
    TextEditingController controller, {
    String? hintText,
    required bool isEditable,
    required VoidCallback onEditToggle,
  }) {
    return Obx(() {
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
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isEditable
                      ? (isDarkMode
                          ? adminAppColors.darkSecondaryBackground.withOpacity(0.5)
                          : Colors.white)
                      : (isDarkMode
                          ? adminAppColors.darkSecondaryBackground.withOpacity(0.3)
                          : Colors.grey.shade50),
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(8)),
                  border: Border(
                    top: BorderSide(
                        color: isEditable
                            ? (isDarkMode ? adminAppColors.primary : Color(0xFF4C6FFF))
                            : (isDarkMode ? adminAppColors.secondary : Color(0xFFDEE2E6))),
                    bottom: BorderSide(
                        color: isEditable
                            ? (isDarkMode ? adminAppColors.primary : Color(0xFF4C6FFF))
                            : (isDarkMode ? adminAppColors.secondary : Color(0xFFDEE2E6))),
                    left: BorderSide(
                        color: isEditable
                            ? (isDarkMode ? adminAppColors.primary : Color(0xFF4C6FFF))
                            : (isDarkMode ? adminAppColors.secondary : Color(0xFFDEE2E6))),
                  ),
                ),
                child: Text(
                  "+91",
                  style: GoogleFonts.lexend(
                      color: isEditable
                          ? (isDarkMode ? Colors.white : Color(0xFF6C757D))
                          : (isDarkMode ? Colors.white60 : Colors.grey.shade500)),
                ),
              ),
              const SizedBox(width: 1),
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: isEditable,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.lexend(
                      color: isEditable
                          ? (isDarkMode ? Colors.white : Colors.black)
                          : (isDarkMode ? Colors.white60 : Colors.grey.shade600)),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: GoogleFonts.lexend(
                        color: isDarkMode ? Color(0xFFADB5BD) : Color(0xFF6C757D)),
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
                          color: isEditable
                              ? (isDarkMode ? adminAppColors.primary : Color(0xFF4C6FFF))
                              : (isDarkMode ? adminAppColors.secondary : Color(0xFFDEE2E6))),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8)),
                      borderSide: BorderSide(
                          color: isDarkMode ? adminAppColors.secondary : Color(0xFFDEE2E6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8)),
                      borderSide: const BorderSide(color: adminAppColors.secondary),
                    ),
                    filled: true,
                    fillColor: isEditable
                        ? (isDarkMode
                            ? adminAppColors.darkSecondaryBackground.withOpacity(0.5)
                            : Colors.white)
                        : (isDarkMode
                            ? adminAppColors.darkSecondaryBackground.withOpacity(0.3)
                            : Colors.grey.shade50),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onEditToggle,
                icon: Icon(
                  isEditable ? Icons.check : Icons.edit_outlined,
                  color: isEditable
                      ? Colors.green
                      : (isDarkMode ? Colors.white70 : Color(0xFFADB5BD)),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      );
    });
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
                      ImageIcon(
                        const AssetImage(AllImages.bulkUploadIcon),
                        size: 32,
                        color: isDarkMode? adminAppColors.secondary:adminAppColors.primary,
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
