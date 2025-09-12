import 'dart:ui';
import 'dart:async';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:synctrackr/core/constants/app_barrels.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/core/widgets/primary_btn.dart';

class AdminOtpVerificationScreen extends StatefulWidget {
  const AdminOtpVerificationScreen({super.key});

  @override
  State<AdminOtpVerificationScreen> createState() =>
      _AdminOtpVerificationScreenState();
}

class _AdminOtpVerificationScreenState
    extends State<AdminOtpVerificationScreen> {
  String _otp = '';
  bool _isSubmitting = false;
  String? _otpToken;
  String? _phone;
  Timer? _countdownTimer;
  int _remainingSeconds = 180;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    _otpToken = args != null ? (args['otpToken']?.toString() ?? '') : '';
    _phone = args != null ? (args['phone']?.toString() ?? '') : '';
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        }
        if (_remainingSeconds == 0) {
          _countdownTimer?.cancel();
          if (Get.isOverlaysOpen) return; // avoid navigating during overlays
          if (Get.key.currentContext != null && mounted) {
            Get.back();
          }
        }
      });
    });
  }

  Future<void> _resendOtp() async {
    if (_phone == null || _phone!.isEmpty) {
      Get.snackbar('Error', 'Phone number missing. Go back and enter again.');
      return;
    }
    setState(() {
      _isSubmitting = true;
    });
    try {
      final api = ApiService();
      final resp = await api.sendOtp(phone: _phone!);
      final token = resp['token']?.toString() ?? '';
      if (token.isEmpty) {
        Get.snackbar('Error', 'Failed to resend OTP. Please try again.');
        return;
      }
      _otpToken = token;
      Get.snackbar('OTP Sent', 'A new OTP has been sent to +$_phone');
    } catch (e) {
      Get.snackbar('Resend Failed', e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _submitOtp() async {
    final args = Get.arguments as Map<String, dynamic>?;
    final visitorId = args != null ? (args['visitorId']?.toString() ?? '') : '';
    final token = _otpToken ?? '';

    if (_otp.length < 4) {
      Get.snackbar('Invalid OTP', 'Please enter the 4-digit OTP.');
      return;
    }
    if (token.isEmpty) {
      Get.snackbar(
          'Error', 'Missing verification token. Please request OTP again.');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final api = ApiService();
      // Step 1: Verify OTP
      Map<String, dynamic> verify;
      try {
        verify = await api.verifyOtp(token: token, otp: _otp);
      } catch (e) {
        final msg = e.toString();
        if (msg.contains('HTTP 400')) {
          Get.snackbar('OTP Verification Failed',
              'Invalid or expired OTP. Please request a new one.');
        } else {
          Get.snackbar('OTP Verification Failed', msg);
        }
        return;
      }

      if (verify['success'] != true) {
        Get.snackbar('OTP Verification Failed',
            verify['message']?.toString() ?? 'Invalid OTP');
        return;
      }

      // If visitorId provided, enforce status and attempt manual checkout
      if (visitorId.isNotEmpty) {
        final enriched = await api.getEnrichedVisitorIfAny(visitorId);
        final status = enriched != null
            ? (enriched['data']?['status']?.toString() ?? '')
            : '';
        if (status != 'checked-in') {
          Get.snackbar('Cannot Check Out', 'Visitor is not checked in.');
          return;
        }

        try {
          final ok = await api.manualCheckout(visitorId);
          if (ok) {
            Get.snackbar('Success', 'Visitor checked out manually.');
          } else {
            Get.snackbar(
                'Checkout Failed', 'Could not complete manual check-out.');
          }
        } catch (e) {
          Get.snackbar('Checkout Failed', e.toString());
        }
        return;
      }

      // No visitor context: just success of OTP
      Get.snackbar('Verified', 'Mobile number verified successfully.');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      // backgroundColor: theme.scaffoldBackgroundColor,
      backgroundColor:
          isDark ? const Color(0xFF0D1B2A) : const Color(0xFFF5F9FF),
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
          double pinBoxSize = isMobile ? 45 : 50;
          double buttonFontSize = isMobile ? 14 : 16;

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppAssets.backgroundWave,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  // color: isDark ? Colors.black.withOpacity(0.6) : null,
                  // colorBlendMode: isDark ? BlendMode.darken : null,
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
                            ? Colors.black.withOpacity(0.4)
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isDark
                              ? Colors.white
                              : Colors.black.withOpacity(0.1),
                          width: 2,
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
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.Otp,
                                  style: TextStyle(
                                    fontSize: headingFontSize,
                                    fontWeight: FontWeight.w600,
                                    // color: theme.textTheme.bodyLarge!.color,
                                    color: isDark
                                        ? AppColors.darkPrimaryBlue
                                        : AppColors.primaryBlue,
                                  ),
                                ),
                                TextSpan(
                                  text: AppStrings.verification,
                                  style: TextStyle(
                                    fontSize: headingFontSize,
                                    fontWeight: FontWeight.w600,
                                    // color: theme.colorScheme.primary,
                                    color:
                                        isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            () {
                              final args =
                                  Get.arguments as Map<String, dynamic>?;
                              final phone = args != null
                                  ? (args['phone']?.toString() ?? '')
                                  : '';
                              return phone.isNotEmpty
                                  ? "We sent a one-time password to +91 $phone"
                                  : "Enter the one-time password received on your mobile number";
                            }(),
                            style: GoogleFonts.poppins(
                              fontSize: subTextFontSize,
                              fontWeight: FontWeight.normal,
                              color: theme.textTheme.bodyMedium!.color,
                            ),
                          ),
                          const SizedBox(height: 20),
                          PinCodeTextField(
                            appContext: context,
                            length: 4,
                            keyboardType: TextInputType.number,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: false,
                            autoDisposeControllers: false,
                            beforeTextPaste: (text) => true,
                            mainAxisAlignment: MainAxisAlignment.center,
                            textStyle: TextStyle(
                              color: AppColors.primaryBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(6),
                              fieldHeight: pinBoxSize,
                              fieldWidth: pinBoxSize,
                              // activeColor: theme.colorScheme.primary,
                              activeColor: AppColors.background,
                              // selectedColor: theme.colorScheme.primary,
                              selectedColor: AppColors.background,
                              inactiveColor: theme.dividerColor,
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 15),
                            onChanged: (value) {
                              _otp = value.trim();
                            },
                          ),
                          const SizedBox(height: 20),
                          PrimaryButton(
                            text: _isSubmitting ? "Submitting..." : "Submit",
                            fontSize: buttonFontSize,
                            onPressed: () {
                              if (_isSubmitting) return;
                              _submitOtp();
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "For security reasons, this page will time out in $_remainingSeconds seconds",
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 14 : 16,
                              color: theme.textTheme.bodyMedium!.color,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: _isSubmitting ? null : _resendOtp,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Didn't receive OTP? ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? AppColors.primaryBlue
                                            : AppColors.darkBackground,
                                      ),
                                    ),
                                    TextSpan(
                                      text: _isSubmitting
                                          ? "Sending..."
                                          : "Resend OTP",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? Color(0xff4682B4)
                                              : Color(0xff4682b4)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
