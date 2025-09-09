// import 'dart:ui';
// import 'package:get/get.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:synctrackr/core/constants/app_barrels.dart';
// import 'package:synctrackr/core/routes/app_routes.dart';
// import 'package:synctrackr/core/widgets/custom_btn.dart';

// class CheckInScreen extends StatelessWidget {
//   const CheckInScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final bool isMobile = screenWidth < 600;

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               AppAssets.backgroundWave,
//               width: double.infinity,
//               height: double.infinity,
//               fit: BoxFit.fill,
//             ),
//           ),
//           Center(
//             child: Padding(
//               // padding: const EdgeInsets.all(16.0),
//               padding: isMobile ? EdgeInsets.zero :EdgeInsets.all(16.0),
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(25),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                       child: Container(
//                         width: isMobile ? double.infinity : 646,
//                         padding: EdgeInsets.all(isMobile ? 24 : 40),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.4),
//                           borderRadius: BorderRadius.circular(25),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.6),
//                             width: 4,
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // ✅ Logo for all devices
//                             Center(
//                               child: Image.asset(
//                                 AppAssets.logo,
//                                 width: isMobile ? 180 : 300,
//                                 height: isMobile ? 90 : 152,
//                               ),
//                             ),
//                             const SizedBox(height: 24),

//                             // ✅ Heading with app name
//                             RichText(
//                               textAlign: TextAlign.center,
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: AppStrings.welcomeTo,
//                                     style: TextStyle(
//                                       fontSize: isMobile ? 24 : 40,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.textDark,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: AppStrings.appName,
//                                     style: TextStyle(
//                                       fontSize: isMobile ? 24 : 40,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.primaryBlue,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 8),

//                             // ✅ Description
//                             Text(
//                               AppStrings.description,
//                               textAlign: TextAlign.start,
//                               style: GoogleFonts.poppins(
//                                 fontSize: isMobile ? 14 : 20,
//                                 fontWeight: FontWeight.normal,
//                                 height: 1.6,
//                                 color: AppColors.textDark,
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//                             CustomButton(
//                               text: AppStrings.checkIn,
//                               onPressed: () {
//                                 Get.toNamed(AppRoutes.purposetovisit);
//                               },
//                               backgroundColor: AppColors.primaryBlue,
//                               foregroundColor: AppColors.background,
//                               fontSize: isMobile ? 14 : 15,
//                             ),
//                             const SizedBox(height: 12),
//                             CustomButton(
//                               text: AppStrings.checkOut,
//                               onPressed: () {

//                               },
//                               backgroundColor: AppColors.primaryBlue,
//                               foregroundColor: AppColors.background,
//                               fontSize: isMobile ? 14 : 15,
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             const Text(
//                               AppStrings.qrInstruction,
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                   color: AppColors.textDark, fontSize: 20),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Center(
//                               child: Container(
//                                 padding: const EdgeInsets.all(12),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   color: const Color(0xFFF1F4FF),
//                                 ),
//                                 child: QrImageView(
//                                   data:
//                                       'https://example.com',
//                                   size: isMobile ? 180 : 200,
//                                   gapless: true,
//                                   backgroundColor: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:synctrackr/core/constants/app_barrels.dart';
import 'package:synctrackr/core/routes/app_routes.dart';
import 'package:synctrackr/core/widgets/custom_btn.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
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
            child: Padding(
              padding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: isMobile ? double.infinity : 646,
                        padding: EdgeInsets.all(isMobile ? 0 : 40),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.black.withOpacity(0.4) // 🌑 Dark theme
                              : Colors.white.withOpacity(0.4), // ☀️ Light theme
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
                            // ✅ Logo (dark / light)
                            Center(
                              child: Image.asset(
                                isDark ? AppAssets.logoDark : AppAssets.logo,
                                width: isMobile ? 180 : 300,
                                height: isMobile ? 90 : 152,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // ✅ Heading
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppStrings.welcomeTo,
                                    style: TextStyle(
                                      fontSize: isMobile ? 24 : 40,
                                      fontWeight: FontWeight.w600,
                                      color: textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                  TextSpan(
                                    text: AppStrings.appName,
                                    style: TextStyle(
                                      fontSize: isMobile ? 24 : 40,
                                      fontWeight: FontWeight.w600,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),

                            // ✅ Description
                            Text(
                              AppStrings.description,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 14 : 20,
                                fontWeight: FontWeight.normal,
                                height: 1.6,
                                color: textTheme.bodyMedium?.color ??
                                    theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // ✅ Check In Button
                            CustomButton(
                              text: AppStrings.checkIn,
                              onPressed: () {
                                Get.toNamed(AppRoutes.purposetovisit);
                              },
                              backgroundColor: theme.primaryColor,
                              foregroundColor: theme.scaffoldBackgroundColor,
                              fontSize: isMobile ? 14 : 15,
                            ),
                            const SizedBox(height: 12),

                            // ✅ Check Out Button
                            CustomButton(
                              text: AppStrings.checkOut,
                              onPressed: () {
                                Get.toNamed(AppRoutes.checkout);
                              },
                              backgroundColor: theme.primaryColor,
                              foregroundColor: theme.scaffoldBackgroundColor,
                              fontSize: isMobile ? 14 : 15,
                            ),
                            const SizedBox(height: 20),

                            // ✅ QR Instruction
                            Text(
                              AppStrings.qrInstruction,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: textTheme.bodyMedium?.color ??
                                    theme.colorScheme.onSurface,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // ✅ QR Code
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: isDark
                                      ? Colors.black.withOpacity(0.3)
                                      : const Color(0xFFF1F4FF),
                                ),
                                child: QrImageView(
                                  data: 'https://example.com',
                                  size: isMobile ? 180 : 200,
                                  gapless: true,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
