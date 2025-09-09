// import 'dart:ui';
// import 'package:get/get.dart';
// import 'package:synctrackr/core/constants/app_barrels.dart';
// import 'package:synctrackr/core/routes/app_routes.dart';
// import 'package:synctrackr/core/widgets/custom_btn.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});

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
//               padding: EdgeInsets.all(isMobile ? 0 : 16.0),
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

//                             // ✅ Visitor Button
//                             CustomButton(
//                               text: AppStrings.visitor,
//                               onPressed: () {
//                                 Get.toNamed(AppRoutes.checkin);
//                               },
//                               backgroundColor: AppColors.primaryBlue,
//                               foregroundColor: AppColors.background,
//                               fontSize: isMobile ? 14 : 15,
//                             ),
//                             const SizedBox(height: 12),

//                             // ✅ Admin Button
//                             CustomButton(
//                               text: AppStrings.admin,
//                               onPressed: () {
//                                 Get.toNamed(AppRoutes.login);
//                               },
//                               backgroundColor: AppColors.Grey,
//                               foregroundColor: AppColors.textDark,
//                               fontSize: isMobile ? 14 : 15,
//                             ),
//                             // SizedBox(
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
import 'package:synctrackr/core/constants/app_barrels.dart';
import 'package:synctrackr/core/routes/app_routes.dart';
import 'package:synctrackr/core/widgets/custom_btn.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
          // 🌊 Background Wave
          Positioned.fill(
            child: Image.asset(
              AppAssets.backgroundWave,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),

          // 🟦 Center Glass Card
          Center(
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 0 : 16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: isMobile ? double.infinity : 646,
                        padding: EdgeInsets.all(isMobile ? 24 : 40),
                        decoration: BoxDecoration(
                          // color: theme.cardColor.withOpacity(0.6),
                          color: isDark
                              ? Colors.black.withOpacity(0.4)
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
                            // 🔄 Dark/Light Logo
                            Center(
                              child: Image.asset(
                                isDark ? AppAssets.logoDark : AppAssets.logo,
                                width: isMobile ? 180 : 300,
                                height: isMobile ? 90 : 152,
                              ),
                            ),
                            const SizedBox(height: 24),

                            //  Heading
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

                            //  Description
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
                            CustomButton(
                              text: AppStrings.visitor,
                              onPressed: () {
                                Get.toNamed(AppRoutes.checkin);
                              },
                              backgroundColor: theme.primaryColor,
                              foregroundColor: theme.scaffoldBackgroundColor,
                              fontSize: isMobile ? 14 : 15,
                            ),
                            const SizedBox(height: 12),

                            CustomButton(
                              text: AppStrings.admin,
                              onPressed: () {
                                Get.toNamed(AppRoutes.login);
                              },
                              backgroundColor: isDark
                                  ? AppColors.darkAdmin
                                  : Colors.grey.shade300,
                              foregroundColor: textTheme.bodyMedium?.color ??
                                  theme.colorScheme.onSurface,
                              fontSize: isMobile ? 14 : 15,
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
