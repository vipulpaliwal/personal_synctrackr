// // import 'dart:ui';
// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:synctrackr/core/constants/app_assets.dart';

// // class CheckoutScreen extends StatelessWidget {
// //   const CheckoutScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final screenSize = MediaQuery.of(context).size;
// //     final isMobile = screenSize.width < 600;
// //     final isTablet = screenSize.width >= 600 && screenSize.width < 1024;
// //     final isDesktop = screenSize.width >= 1024;

// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF5F9FF),
// //       body: Stack(
// //         children: [
// //           Positioned.fill(
// //             child: Image.asset(
// //               AppAssets.backgroundWave,
// //               width: double.infinity,
// //               height: double.infinity,
// //               fit: BoxFit.fill,
// //             ),
// //           ),
// //           Center(
// //             child: ClipRRect(
// //               borderRadius: BorderRadius.circular(25),
// //               child: BackdropFilter(
// //                 filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
// //                 child: Container(
// //                   width: isMobile
// //                       ? screenSize.width * 1.0
// //                       : isTablet
// //                           ? 500
// //                           : 646,
// //                   padding: const EdgeInsets.all(30),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white.withOpacity(0.4),
// //                     borderRadius: BorderRadius.circular(25),
// //                     border: Border.all(
// //                       color: Colors.white.withOpacity(0.6),
// //                       width: 4,
// //                     ),
// //                   ),
// //                   child: SingleChildScrollView(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       children: [
// //                         // Logo
// //                         Image.asset(
// //                           'assets/images/logo.png',
// //                           width: isMobile ? 200 : 300,
// //                           height: isMobile ? 100 : 152,
// //                         ),
// //                         const SizedBox(height: 30),

// //                         Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text.rich(
// //                               TextSpan(
// //                                 children: [
// //                                   TextSpan(
// //                                     text: "Welcome to ",
// //                                     style: TextStyle(
// //                                       fontSize: isMobile ? 28 : 40,
// //                                       fontWeight: FontWeight.w600,
// //                                       color: Colors.black87,
// //                                     ),
// //                                   ),
// //                                   TextSpan(
// //                                     text: "SyncTrackr",
// //                                     style: TextStyle(
// //                                       fontSize: isMobile ? 28 : 40,
// //                                       fontWeight: FontWeight.w600,
// //                                       color: const Color(0xFF3B82F6),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               textAlign: TextAlign.start,
// //                             ),
// //                             const SizedBox(height: 24),
// //                             Text(
// //                               "Streamline your visit for fast, simple & secure to check in with ease. Stay focused on every matters.",
// //                               textAlign: TextAlign.start,
// //                               style: GoogleFonts.poppins(
// //                                 fontSize: isMobile ? 16 : 20,
// //                                 fontWeight: FontWeight.normal,
// //                                 height: 1.6,
// //                                 color: Colors.black87,
// //                               ),
// //                             ),
// //                           ],
// //                         ),

// //                         const SizedBox(height: 40),

// //                         // Check In Button
// //                         SizedBox(
// //                           width: double.infinity,
// //                           child: ElevatedButton(
// //                             onPressed: () {},
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: const Color(0xFF3B82F6),
// //                               foregroundColor: Colors.white,
// //                               padding:
// //                                   const EdgeInsets.symmetric(vertical: 16),
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(8),
// //                               ),
// //                             ),
// //                             child: Text(
// //                               "Check In",
// //                               style: TextStyle(fontSize: isMobile ? 14 : 15),
// //                             ),
// //                           ),
// //                         ),
// //                         const SizedBox(height: 12),

// //                         // Check Out Button
// //                         SizedBox(
// //                           width: double.infinity,
// //                           child: ElevatedButton(
// //                             onPressed: () {},
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: const Color(0xFF3B82F6),
// //                               foregroundColor: Colors.white,
// //                               padding:
// //                                   const EdgeInsets.symmetric(vertical: 16),
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(8),
// //                               ),
// //                             ),
// //                             child: Text(
// //                               "Check Out",
// //                               style: TextStyle(fontSize: isMobile ? 14 : 15),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/core/constants/app_assets.dart';

// class CheckoutScreen extends StatelessWidget {
//   const CheckoutScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final isMobile = screenSize.width < 600;
//     final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

//     return Scaffold(
//       backgroundColor: const Color(0xFF0B1025), // 🔹 Dark background
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               AppAssets.backgroundWave,
//               width: double.infinity,
//               height: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Center(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(25),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                 child: Container(
//                   width: isMobile
//                       ? screenSize.width * 0.95
//                       : isTablet
//                           ? 500
//                           : 646,
//                   padding: const EdgeInsets.all(30),
//                   decoration: BoxDecoration(
//                     color:
//                         Colors.white.withOpacity(0.05), // 🔹 Dark glass effect
//                     borderRadius: BorderRadius.circular(25),
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.2), // 🔹 Subtle border
//                       width: 2,
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Logo
//                         Image.asset(
//                           'assets/images/logo.png',
//                           width: isMobile ? 160 : 220,
//                           height: isMobile ? 80 : 120,
//                         ),
//                         const SizedBox(height: 30),

//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: "Welcome to ",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: isMobile ? 26 : 36,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white, // 🔹 White text
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: "SyncTrackr",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: isMobile ? 26 : 36,
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(
//                                           0xFF3B82F6), // 🔹 Accent blue
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Text(
//                               "Streamline your visit for fast, simple & secure to check in with ease. Stay focused on every matters.",
//                               textAlign: TextAlign.start,
//                               style: GoogleFonts.poppins(
//                                 fontSize: isMobile ? 14 : 18,
//                                 fontWeight: FontWeight.normal,
//                                 height: 1.6,
//                                 color: Colors.white70, // 🔹 Subtle white
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 40),

//                         // Check In Button
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   const Color(0xFF3B82F6), // 🔹 Blue
//                               foregroundColor: Colors.white,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: Text(
//                               "Check In",
//                               style: TextStyle(fontSize: isMobile ? 14 : 16),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 12),

//                         // Check Out Button
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white
//                                   .withOpacity(0.15), // 🔹 Light button
//                               foregroundColor: Colors.white, // 🔹 White text
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 side: const BorderSide(
//                                   color: Color(0xFF3B82F6), // 🔹 Blue outline
//                                   width: 1.5,
//                                 ),
//                               ),
//                             ),
//                             child: Text(
//                               "Check Out",
//                               style: TextStyle(fontSize: isMobile ? 14 : 16),
//                             ),
//                           ),
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
import 'package:synctrackr/core/constants/app_assets.dart';
import 'package:synctrackr/core/constants/app_colors.dart';
import 'package:synctrackr/core/routes/app_routes.dart';
import 'package:synctrackr/core/widgets/primary_btn.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1025), // 🔹 Dark background
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
              // padding: const EdgeInsets.all(8.0),
              padding: EdgeInsets.all(isMobile ? 0 : 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: isMobile
                        ? screenSize.width * 1
                        : isTablet
                            ? 500
                            : 646,
                    padding: const EdgeInsets.all(30),
                    // padding: EdgeInsets.all(isMobile ? 24 : 40),
                    decoration: BoxDecoration(
                      // color:
                      // Colors.white.withOpacity(0.05),
                      color: isDark
                          ? Colors.black.withOpacity(0.4)
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        // color: Colors.white.withOpacity(0.2),
                        color: isDark
                            ? Colors.white
                            : Colors.white.withOpacity(0.6),
                        width: 2,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Logo
                          Image.asset(
                            // 'assets/images/logo.png',
                            isDark ? AppAssets.logoDark : AppAssets.logo,
                            width: isMobile ? 160 : 220,
                            height: isMobile ? 80 : 120,
                          ),
                          const SizedBox(height: 30),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Welcome to ",
                                      style: GoogleFonts.poppins(
                                          fontSize: isMobile ? 26 : 36,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? AppColors.background
                                              : AppColors.darkBackground),
                                    ),
                                    TextSpan(
                                      text: "SyncTrackr",
                                      style: GoogleFonts.poppins(
                                          fontSize: isMobile ? 26 : 36,
                                          fontWeight: FontWeight.w600,
                                          // color: const Color(0xFF3B82F6),
                                          color: isDark
                                              ? AppColors.darkPrimaryBlue
                                              : AppColors.primaryBlue),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Streamline your visit for fast, simple & secure to check in with ease. Stay focused on every matters.",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    fontSize: isMobile ? 14 : 18,
                                    fontWeight: FontWeight.normal,
                                    height: 1.6,
                                    color: isDark
                                        ? AppColors.background
                                        : AppColors.darkBackground),
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),
                          PrimaryButton(
                            text: "Check In",
                            fontSize: isMobile ? 14 : 16,
                            onPressed: () {
                              Get.toNamed(AppRoutes.uploadphoto);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          PrimaryButton(
                            text: "Check Out",
                            fontSize: isMobile ? 14 : 16,
                            onPressed: () {
                              Get.toNamed(AppRoutes.uploadphoto);
                            },
                          ),
                        ],
                      ),
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
