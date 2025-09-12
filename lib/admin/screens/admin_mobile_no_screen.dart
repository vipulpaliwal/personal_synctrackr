import 'dart:ui';
import 'package:get/get.dart';
import 'package:synctrackr/admin/screens/admin_otp_verification_screen.dart';
import 'package:synctrackr/core/constants/app_barrels.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/core/widgets/primary_btn.dart';

class AdminMobileNoScreen extends StatefulWidget {
  const AdminMobileNoScreen({super.key});

  @override
  State<AdminMobileNoScreen> createState() => _MobileNoScreenState();
}

class _MobileNoScreenState extends State<AdminMobileNoScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isSubmitting = false;
  String? _errorText;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  bool _isValidPhone(String input) {
    final digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
    return digitsOnly.length >= 10 && digitsOnly.length <= 15;
  }

  Future<void> _requestOtp() async {
    final raw = _phoneController.text.trim();
    final phone = raw.replaceAll(RegExp(r'[^0-9]'), '');

    setState(() {
      _errorText = null;
    });

    if (!_isValidPhone(phone)) {
      setState(() {
        _errorText = 'Enter a valid mobile number (10-15 digits).';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final api = ApiService();
      final resp = await api.sendOtp(phone: phone);
      final token = resp['token']?.toString() ?? '';
      if (token.isEmpty) {
        Get.snackbar('Error', 'Failed to initiate OTP. Please try again.');
        return;
      }
      final args = Get.arguments as Map<String, dynamic>?;
      final visitorId =
          args != null ? (args['visitorId']?.toString() ?? '') : '';
      Get.to(const AdminOtpVerificationScreen(), arguments: {
        'visitorId': visitorId,
        'phone': phone,
        'otpToken': token,
      });
    } catch (e) {
      Get.snackbar(
        'Network Error',
        'Unable to request OTP. Please check your connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F172A) : const Color(0xFFF5F9FF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;

          bool isMobile = screenWidth < 600;
          bool isTablet = screenWidth >= 600 && screenWidth < 1024;
          bool isDesktop = screenWidth >= 1024 && screenWidth < 1440;
          bool isLargeDesktop =
              screenWidth >= 1440; // ignore: unused_local_variable

          double containerWidth = isMobile
              ? screenWidth * 1.0
              : isTablet
                  ? 500
                  : isDesktop
                      ? 600
                      : 700;

          double logoWidth =
              isMobile ? 200 : 300; // ignore: unused_local_variable
          double logoHeight =
              isMobile ? 100 : 152; // ignore: unused_local_variable

          double headingFontSize = isMobile ? 28 : 40;
          double subTextFontSize = isMobile ? 16 : 20;
          double buttonFontSize = isMobile ? 14 : 16;

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppAssets.backgroundWave,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      width: containerWidth,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withOpacity(0.3)
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isDark
                              ? Colors.white
                              : Colors.white.withOpacity(0.6),
                          width: 4,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              isDark ? AppAssets.logoDark : AppAssets.logo,
                              width: isMobile ? 180 : 300,
                              height: isMobile ? 90 : 152,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppStrings.your,
                                      style: TextStyle(
                                        fontSize: headingFontSize,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                    TextSpan(
                                      text: AppStrings.mobile,
                                      style: TextStyle(
                                        fontSize: headingFontSize,
                                        fontWeight: FontWeight.w600,
                                        // color: const Color(0xFF3B82F6),
                                        color: isDark
                                            ? AppColors.darkPrimaryBlue
                                            : Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: AppStrings.No,
                                      style: TextStyle(
                                        fontSize: headingFontSize,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                AppStrings.pYourno,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  fontSize: subTextFontSize,
                                  fontWeight: FontWeight.normal,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: isDark
                                          ? AppColors.primaryBlue
                                          : Colors.black,
                                    ),
                                  ),
                                  child: Text(
                                    "+91",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isDark
                                          ? AppColors.primaryBlue
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: _phoneController,
                                    style: TextStyle(
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: "Phone",
                                      errorText: _errorText,
                                      hintStyle: TextStyle(
                                        color: isDark
                                            ? AppColors.primaryBlue
                                            : Colors.black54,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 14),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                          color: isDark
                                              ? AppColors.primaryBlue
                                              : Colors.black,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                            color: isDark
                                                ? AppColors.primaryBlue
                                                : Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                            color: isDark
                                                ? AppColors.primaryBlue
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          PrimaryButton(
                            text:
                                _isSubmitting ? "Requesting..." : "Request Otp",
                            fontSize: buttonFontSize,
                            onPressed: () {
                              if (_isSubmitting) return;
                              _requestOtp();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
