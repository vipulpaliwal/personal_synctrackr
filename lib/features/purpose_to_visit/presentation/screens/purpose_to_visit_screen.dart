// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/core/constants/app_barrels.dart';
// import 'package:synctrackr/core/routes/app_routes.dart';
// import 'package:synctrackr/core/widgets/custom_btn.dart';
// import 'package:synctrackr/core/widgets/primary_btn.dart';

// class PurposeToVisitScreen extends StatefulWidget {
//   const PurposeToVisitScreen({super.key});

//   @override
//   State<PurposeToVisitScreen> createState() => _PurposeToVisitScreenState();
// }

// class _PurposeToVisitScreenState extends State<PurposeToVisitScreen> {
//   final List<String> purposes = ["Meeting", "Delivery", "Interview", "Vender"];
//   String? selectedPurpose;

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final bool isMobile = screenWidth < 600;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F9FF),
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
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(isMobile ? 0 : 20),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(25),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                   child: Container(
//                     width: screenWidth < 500
//                         // ? screenWidth * 0.95
//                         ? double.infinity
//                         : screenWidth < 800
//                             ? 500
//                             : 600,
//                     padding: const EdgeInsets.all(30),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.4),
//                       borderRadius: BorderRadius.circular(25),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.6),
//                         width: 3,
//                       ),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Image.asset(
//                             AppAssets.logo,
//                             width: 200,
//                             height: 100,
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: AppStrings.chooseYour,
//                                     style: GoogleFonts.poppins(
//                                       fontSize: screenWidth < 500 ? 22 : 28,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: AppStrings.purpose,
//                                     style: GoogleFonts.poppins(
//                                       fontSize: screenWidth < 500 ? 22 : 28,
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF3B82F6),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               textAlign: TextAlign.start,
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               AppStrings.purposetoVisit,
//                               textAlign: TextAlign.start,
//                               style: GoogleFonts.poppins(
//                                 fontSize: screenWidth < 500 ? 14 : 16,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 30),

//                         // Responsive Purpose Grid
//                         GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: purposes.length,
//                           gridDelegate:
//                               SliverGridDelegateWithMaxCrossAxisExtent(
//                             maxCrossAxisExtent: 250,
//                             mainAxisExtent: 60,
//                             crossAxisSpacing: 20,
//                             mainAxisSpacing: 20,
//                           ),
//                           itemBuilder: (_, index) {
//                             final purpose = purposes[index];
//                             final isSelected = selectedPurpose == purpose;

//                             return GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedPurpose = purpose;
//                                 });
//                               },
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: isSelected
//                                       ? const Color(0xFF2F69FF)
//                                       : const Color(0xFFE0E0E0),
//                                   border: Border.all(
//                                     color: isSelected
//                                         ? Colors.white
//                                         : const Color(0xFF2F69FF),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Text(
//                                   purpose,
//                                   style: TextStyle(
//                                     color: isSelected
//                                         ? Colors.white
//                                         : const Color(0xFF171A25),
//                                     fontSize: screenWidth < 500 ? 14 : 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),

//                         const SizedBox(height: 30),

//                         // Next Button
//                         PrimaryButton(
//                           text: "Next",
//                           fontSize: isMobile ? 14 : 16,
//                           onPressed: () {
//                             Get.toNamed(AppRoutes.mobile);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
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
import 'package:synctrackr/core/widgets/primary_btn.dart';

class PurposeToVisitScreen extends StatefulWidget {
  const PurposeToVisitScreen({super.key});

  @override
  State<PurposeToVisitScreen> createState() => _PurposeToVisitScreenState();
}

class _PurposeToVisitScreenState extends State<PurposeToVisitScreen> {
  final List<String> purposes = ["Meeting", "Delivery", "Interview", "Vender"];
  String? selectedPurpose;

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
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 0 : 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: screenWidth < 500
                        ? double.infinity
                        : screenWidth < 800
                            ? 500
                            : 600,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Logo
                        Center(
                          child: Image.asset(
                            isDark ? AppAssets.logoDark : AppAssets.logo,
                            width: 200,
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // ✅ Title
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppStrings.chooseYour,
                                    style: GoogleFonts.poppins(
                                      fontSize: screenWidth < 500 ? 22 : 28,
                                      fontWeight: FontWeight.w600,
                                      color: textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                  TextSpan(
                                    text: AppStrings.purpose,
                                    style: GoogleFonts.poppins(
                                      fontSize: screenWidth < 500 ? 22 : 28,
                                      fontWeight: FontWeight.w600,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppStrings.purposetoVisit,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth < 500 ? 14 : 16,
                                fontWeight: FontWeight.normal,
                                color: textTheme.bodyMedium?.color ??
                                    theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // ✅ Purpose Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: purposes.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250,
                            mainAxisExtent: 60,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (_, index) {
                            final purpose = purposes[index];
                            final isSelected = selectedPurpose == purpose;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPurpose = purpose;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: isSelected
                                      ? theme.primaryColor
                                      : (isDark
                                          ? Color(0xff292929)
                                          : const Color(0xFFE0E0E0)),
                                  border: Border.all(
                                    color: isDark
                                        ? AppColors.darkPrimaryBlue
                                        : (isSelected
                                            ? Colors.white
                                            : theme.primaryColor),
                                    width: 1,
                                  ),
                                ),
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(10),
                                //   color: isSelected
                                //       ? theme.primaryColor
                                //       : (isDark
                                //           ? Colors.grey.shade800
                                //           : const Color(0xFFE0E0E0)),
                                //   border: isDark
                                //       ? null
                                //       : Border.all(
                                //           color: isSelected
                                //               ? Colors.white
                                //               : theme.primaryColor,
                                //           width: 1,
                                //         ),
                                // ),
                                child: Text(
                                  purpose,
                                  style: TextStyle(
                                    color: isSelected
                                        // ? Colors.white
                                        ? (isDark ? Colors.black : Colors.white)
                                        : (isDark
                                            ? Colors.white
                                            : const Color(0xFF171A25)),
                                    fontSize: screenWidth < 500 ? 14 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),

                        // ✅ Next Button
                        PrimaryButton(
                          text: "Next",
                          fontSize: isMobile ? 14 : 16,
                          onPressed: () {
                            Get.toNamed(AppRoutes.mobile);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
