// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:synctrackr/core/constants/app_assets.dart';
// import 'package:synctrackr/core/constants/app_barrels.dart';
// import 'package:synctrackr/core/routes/app_routes.dart';
// import 'package:synctrackr/core/widgets/primary_btn.dart';

// class OtpVerificationScreen extends StatefulWidget {
//   const OtpVerificationScreen({super.key});

//   @override
//   State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
// }

// class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F9FF),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double screenWidth = constraints.maxWidth;

//           // Breakpoints
//           bool isMobile = screenWidth < 600;
//           bool isTablet = screenWidth >= 600 && screenWidth < 1024;
//           bool isDesktop = screenWidth >= 1024 && screenWidth < 1440;
//           bool isLargeDesktop = screenWidth >= 1440;

//           // Responsive values
//           double containerWidth = isMobile
//               ? screenWidth * 1.0
//               : isTablet
//                   ? 500
//                   : isDesktop
//                       ? 600
//                       : 700;

//           double logoWidth = isMobile ? 200 : 300;
//           double logoHeight = isMobile ? 100 : 152;
//           double headingFontSize = isMobile ? 28 : 40;
//           double subTextFontSize = isMobile ? 16 : 20;
//           double pinBoxSize = isMobile ? 45 : 50;
//           double buttonFontSize = isMobile ? 14 : 16;

//           return Stack(
//             children: [
//               Positioned.fill(
//                 child: Image.asset(
//                   AppAssets.backgroundWave,
//                   width: double.infinity,
//                   height: double.infinity,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               Center(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(25),
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                     child: Container(
//                       width: containerWidth,
//                       padding: const EdgeInsets.all(30),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.4),
//                         borderRadius: BorderRadius.circular(25),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.6),
//                           width: 4,
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Image.asset(
//                               AppAssets.logo,
//                               width: logoWidth,
//                               height: logoHeight,
//                             ),
//                           ),
//                           const SizedBox(height: 30),
//                           Text.rich(
//                             TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: AppStrings.Otp,
//                                   style: TextStyle(
//                                     fontSize: headingFontSize,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: AppStrings.verification,
//                                   style: TextStyle(
//                                     fontSize: headingFontSize,
//                                     fontWeight: FontWeight.w600,
//                                     color: const Color(0xFF3B82F6),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             textAlign: TextAlign.start,
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             "We will send you a one time password on this Mobile Number +91-12989200823",
//                             style: GoogleFonts.poppins(
//                               fontSize: subTextFontSize,
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           PinCodeTextField(
//                             appContext: context,
//                             length: 4,
//                             keyboardType: TextInputType.number,
//                             animationDuration:
//                                 const Duration(milliseconds: 300),
//                             enableActiveFill: false,
//                             autoDisposeControllers: false,
//                             beforeTextPaste: (text) => true,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             pinTheme: PinTheme(
//                               shape: PinCodeFieldShape.box,
//                               borderRadius: BorderRadius.circular(6),
//                               fieldHeight: pinBoxSize,
//                               fieldWidth: pinBoxSize,
//                               activeColor: Colors.black,
//                               selectedColor: Colors.black,
//                             ),
//                             separatorBuilder: (context, index) =>
//                                 const SizedBox(width: 15),
//                             onChanged: (value) {},
//                           ),
//                           const SizedBox(height: 20),
//                           PrimaryButton(
//                             text: "Next",
//                             fontSize: buttonFontSize,
//                             onPressed: () {
//                               Get.toNamed(AppRoutes.profile);
//                             },
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             "For security reasons, this page will time out in 180 seconds",
//                             style: GoogleFonts.poppins(
//                               fontSize: isMobile ? 14 : 16,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Text.rich(
//                               TextSpan(
//                                 children: [
//                                   const TextSpan(
//                                     text: "Didn't receive OTP? ",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: "Resend OTP",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF3B82F6),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:synctrackr/admin/screens/checkedout_complete.dart';
import 'package:synctrackr/core/constants/app_barrels.dart';
import 'package:synctrackr/core/routes/app_routes.dart';
import 'package:synctrackr/core/widgets/primary_btn.dart';

class AdminOtpVerificationScreen extends StatefulWidget {
  const AdminOtpVerificationScreen({super.key});

  @override
  State<AdminOtpVerificationScreen> createState() => _AdminOtpVerificationScreenState();
}

class _AdminOtpVerificationScreenState extends State<AdminOtpVerificationScreen> {
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
          bool isLargeDesktop = screenWidth >= 1440;

          double containerWidth = isMobile
              ? screenWidth * 1.0
              : isTablet
                  ? 500
                  : isDesktop
                      ? 600
                      : 700;

          double logoWidth = isMobile ? 200 : 300;
          double logoHeight = isMobile ? 100 : 152;
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
                            "We will send you a one time password on this Mobile Number +91-12989200823",
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
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 20),
                          PrimaryButton(
                            text: "Submit",
                            fontSize: buttonFontSize,
                            onPressed: () {
                              Get.to(ManualCheckOutScreen);
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "For security reasons, this page will time out in 180 seconds",
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 14 : 16,
                              color: theme.textTheme.bodyMedium!.color,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
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
                                    text: "Resend OTP",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        // color: theme.colorScheme.primary,
                                        color: isDark
                                            ? Color(0xff4682B4)
                                            : Color(0xff4682b4)),
                                  ),
                                ],
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
