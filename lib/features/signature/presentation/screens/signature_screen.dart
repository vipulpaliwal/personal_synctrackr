// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:signature/signature.dart';
// import 'package:synctrackr/core/constants/app_assets.dart';

// class SignatureScreen extends StatefulWidget {
//   const SignatureScreen({super.key});

//   @override
//   State<SignatureScreen> createState() => _SignatureScreenState();
// }

// class _SignatureScreenState extends State<SignatureScreen> {
//   final SignatureController _signatureController = SignatureController(
//     penStrokeWidth: 2,
//     penColor: Colors.black,
//     exportBackgroundColor: Colors.white,
//   );

//   @override
//   Widget build(BuildContext context) {
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
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(25),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                 child: Container(
//                   width: 646,
//                   padding: const EdgeInsets.all(40),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.4),
//                     borderRadius: BorderRadius.circular(25),
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.6),
//                       width: 4,
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           'assets/images/logo.png',
//                           width: 300,
//                           height: 152,
//                         ),
//                         const SizedBox(height: 20),

//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text.rich(
//                             TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: "Signature - ",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 28,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: "Agree to Terms",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 28,
//                                     fontWeight: FontWeight.w600,
//                                     color: const Color(0xFF3B82F6),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 8),

//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text.rich(
//                             TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: "SyncTrackr ",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: const Color(0xFF3B82F6),
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: "Mutual Non-Disclosure Consent",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 12),

//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             '''
// 1. Visitors (vendors/interviewees) entering the SyncTrackr facility for business discussions must treat all information and activities observed as strictly confidential. Disclosure of such information may:
//    • Violate SyncTrackr's confidentiality agreements or laws.
//    • Harm SyncTrackr or its clients’ business or competitiveness.
// 2. Cameras and recording devices are strictly prohibited on-site.
// 3. Visitor badges must be worn visibly at all times.
// 4. SyncTrackr collects personal details (e.g., name, address, phone number, government ID) for business purposes and ensures their protection as per legal and regulatory standards.

// By signing into SyncTrackr Visitor Management, you consent to these terms.
// ''',
//                             style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               height: 1.5,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         Container(
//                           height: 130,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.black26),
//                           ),
//                           child: Signature(
//                             controller: _signatureController,
//                             backgroundColor: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         Row(
//                           children: [
//                             SizedBox(
//                               width: 140,
//                               height: 54,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.red[100],
//                                   foregroundColor: Colors.red,
//                                   shape: RoundedRectangleBorder(
//                                     side: const BorderSide(
//                                         color: Colors.red, width: 1.5),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 14),
//                                 ),
//                                 onPressed: () {
//                                   _signatureController.clear();
//                                 },
//                                 child: const Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text("Retry"),
//                                     SizedBox(width: 6),
//                                     Icon(
//                                       Icons.refresh,
//                                       size: 20,
//                                       color: Colors.red,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             SizedBox(
//                               width: 406,
//                               height: 54,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue,
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 14),
//                                 ),
//                                 onPressed: () {
//                                   if (_signatureController.isNotEmpty) {
//                                     // Add your Save & Next logic
//                                   }
//                                 },
//                                 child: const Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text("Request Check In"),
//                                     SizedBox(width: 6),
//                                     Icon(
//                                       Icons.arrow_forward,
//                                       size: 18,
//                                       color: Colors.white,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
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

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:signature/signature.dart';
// import 'package:synctrackr/core/constants/app_assets.dart';

// import '../../../../core/routes/app_routes.dart';

// class SignatureScreen extends StatefulWidget {
//   const SignatureScreen({super.key});

//   @override
//   State<SignatureScreen> createState() => _SignatureScreenState();
// }

// class _SignatureScreenState extends State<SignatureScreen> {
//   final SignatureController _signatureController = SignatureController(
//     penStrokeWidth: 2,
//     penColor: Colors.black,
//     exportBackgroundColor: Colors.white,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F9FF),
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               AppAssets.backgroundWave,
//               fit: BoxFit.fill,
//             ),
//           ),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final isMobile = constraints.maxWidth < 600;
//               final isTablet =
//                   constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
//               final isDesktop = constraints.maxWidth >= 1024;

//               double containerWidth = isMobile
//                   ? constraints.maxWidth * 1
//                   : isTablet
//                       ? 600
//                       : 646;
//               double padding = isMobile ? 20 : 40;
//               double titleFontSize = isMobile ? 20 : 28;
//               double subtitleFontSize = isMobile ? 14 : 16;
//               double buttonHeight = isMobile ? 48 : 54;
//               double signatureBoxHeight = isMobile ? 100 : 130;
//               double logoWidth = isMobile ? 200 : 300;
//               double logoHeight = isMobile ? 100 : 152;

//               return Center(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(25),
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                     child: Container(
//                       width: containerWidth,
//                       padding: EdgeInsets.all(padding),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.4),
//                         borderRadius: BorderRadius.circular(25),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.6),
//                           width: 4,
//                         ),
//                       ),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               'assets/images/logo.png',
//                               width: logoWidth,
//                               height: logoHeight,
//                             ),
//                             const SizedBox(height: 20),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text.rich(
//                                 TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: "Signature - ",
//                                       style: GoogleFonts.poppins(
//                                         fontSize: titleFontSize,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text: "Agree to Terms",
//                                       style: GoogleFonts.poppins(
//                                         fontSize: titleFontSize,
//                                         fontWeight: FontWeight.w600,
//                                         color: const Color(0xFF3B82F6),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text.rich(
//                                 TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: "SyncTrackr ",
//                                       style: GoogleFonts.poppins(
//                                         fontSize: subtitleFontSize,
//                                         fontWeight: FontWeight.w600,
//                                         color: const Color(0xFF3B82F6),
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text: "Mutual Non-Disclosure Consent",
//                                       style: GoogleFonts.poppins(
//                                         fontSize: subtitleFontSize,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 '''
// 1. Visitors (vendors/interviewees) entering the SyncTrackr facility for business discussions must treat all information and activities observed as strictly confidential. Disclosure of such information may:
//    • Violate SyncTrackr's confidentiality agreements or laws.
//    • Harm SyncTrackr or its clients’ business or competitiveness.
// 2. Cameras and recording devices are strictly prohibited on-site.
// 3. Visitor badges must be worn visibly at all times.
// 4. SyncTrackr collects personal details (e.g., name, address, phone number, government ID) for business purposes and ensures their protection as per legal and regulatory standards.

// By signing into SyncTrackr Visitor Management, you consent to these terms.
// ''',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: isMobile ? 12 : 14,
//                                   color: Colors.black87,
//                                   height: 1.5,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             Container(
//                               height: signatureBoxHeight,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(color: Colors.black26),
//                               ),
//                               child: Signature(
//                                 controller: _signatureController,
//                                 backgroundColor: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             isMobile
//                                 ? Column(
//                                     children: [
//                                       SizedBox(
//                                         width: double.infinity,
//                                         height: buttonHeight,
//                                         child: ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.red[100],
//                                             foregroundColor: Colors.red,
//                                             shape: RoundedRectangleBorder(
//                                               side: const BorderSide(
//                                                   color: Colors.red,
//                                                   width: 1.5),
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                             ),
//                                           ),
//                                           onPressed: () {
//                                             _signatureController.clear();
//                                           },
//                                           child: const Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text("Retry"),
//                                               SizedBox(width: 6),
//                                               Icon(Icons.refresh,
//                                                   size: 20, color: Colors.red),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 10),
//                                       SizedBox(
//                                         width: double.infinity,
//                                         height: buttonHeight,
//                                         child: ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.blue,
//                                             foregroundColor: Colors.white,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                             ),
//                                           ),
//                                           onPressed: () {
//                                             if (_signatureController
//                                                 .isNotEmpty) {
//                                               // Save & Next logic
//                                             }
//                                           },
//                                           child: const Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text("Request Check In"),
//                                               SizedBox(width: 6),
//                                               Icon(Icons.arrow_forward,
//                                                   size: 18,
//                                                   color: Colors.white),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 : Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 140,
//                                         height: buttonHeight,
//                                         child: ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.red[100],
//                                             foregroundColor: Colors.red,
//                                             shape: RoundedRectangleBorder(
//                                               side: const BorderSide(
//                                                   color: Colors.red,
//                                                   width: 1.5),
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                             ),
//                                           ),
//                                           onPressed: () {
//                                             _signatureController.clear();
//                                           },
//                                           child: const Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text("Retry"),
//                                               SizedBox(width: 6),
//                                               Icon(Icons.refresh,
//                                                   size: 20, color: Colors.red),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Expanded(
//                                         child: SizedBox(
//                                           height: buttonHeight,
//                                           child: ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Colors.blue,
//                                               foregroundColor: Colors.white,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               if (_signatureController
//                                                   .isNotEmpty) {
//                                                 // Save & Next logic
//                                                 Get.toNamed(AppRoutes.approved);
//                                               }
//                                               // Get.toNamed(AppRoutes.approved);
//                                             },
//                                             child: const Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Text("Request Check In"),
//                                                 SizedBox(width: 6),
//                                                 Icon(Icons.arrow_forward,
//                                                     size: 18,
//                                                     color: Colors.white),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
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
import 'package:signature/signature.dart';
import 'package:synctrackr/core/constants/app_assets.dart';
import 'package:synctrackr/core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F172A) : const Color(0xFFF5F9FF),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.backgroundWave,
              fit: BoxFit.fill,
              // color: isDark ? Colors.black.withOpacity(0.4) : null,
              // colorBlendMode: isDark ? BlendMode.darken : BlendMode.dst,
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              final isTablet =
                  constraints.maxWidth >= 600 && constraints.maxWidth < 1024;

              double containerWidth = isMobile
                  ? constraints.maxWidth * 1
                  : isTablet
                      ? 600
                      : 646;
              double padding = isMobile ? 20 : 40;
              double titleFontSize = isMobile ? 20 : 28;
              double subtitleFontSize = isMobile ? 14 : 16;
              double buttonHeight = isMobile ? 48 : 54;
              double signatureBoxHeight = isMobile ? 100 : 130;
              double logoWidth = isMobile ? 200 : 300;
              double logoHeight = isMobile ? 100 : 152;

              return Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      width: containerWidth,
                      padding: EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withOpacity(0.5)
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isDark
                              ? Colors.white
                              : Colors.white.withOpacity(0.6),
                          width: 4,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              // 'assets/images/logo.png',
                              isDark ? AppAssets.logoDark : AppAssets.logo,
                              width: logoWidth,
                              height: logoHeight,
                              // color: isDark ? Colors.white : null,
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Signature - ",
                                      style: GoogleFonts.poppins(
                                        fontSize: titleFontSize,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? AppColors.darkPrimaryBlue
                                            : Colors.black87,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Agree to Terms",
                                      style: GoogleFonts.poppins(
                                        fontSize: titleFontSize,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? AppColors.background
                                            : AppColors.darkAdmin,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "SyncTrackr ",
                                      style: GoogleFonts.poppins(
                                        fontSize: subtitleFontSize,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? AppColors.darkPrimaryBlue
                                            : AppColors.primaryBlue,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Mutual Non-Disclosure Consent",
                                      style: GoogleFonts.poppins(
                                        fontSize: subtitleFontSize,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '''
1. Visitors (vendors/interviewees) entering the SyncTrackr facility for business discussions must treat all information and activities observed as strictly confidential. Disclosure of such information may:
   • Violate SyncTrackr's confidentiality agreements or laws.
   • Harm SyncTrackr or its clients’ business or competitiveness.
2. Cameras and recording devices are strictly prohibited on-site.
3. Visitor badges must be worn visibly at all times.
4. SyncTrackr collects personal details (e.g., name, address, phone number, government ID) for business purposes and ensures their protection as per legal and regulatory standards.

By signing into SyncTrackr Visitor Management, you consent to these terms.
''',
                                style: GoogleFonts.poppins(
                                  fontSize: isMobile ? 12 : 14,
                                  color: isDark
                                      ? Colors.grey[300]
                                      : Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: signatureBoxHeight,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: isDark ? Colors.grey[900] : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color:
                                      isDark ? Colors.white24 : Colors.black26,
                                ),
                              ),
                              child: Signature(
                                controller: _signatureController,
                                backgroundColor:
                                    isDark ? Colors.grey[900]! : Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // ✅ Buttons
                            isMobile
                                ? Column(
                                    children: [
                                      _retryButton(buttonHeight, isDark),
                                      const SizedBox(height: 10),
                                      _requestButton(buttonHeight, isDark),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      SizedBox(
                                          width: 140,
                                          height: buttonHeight,
                                          child: _retryButton(
                                              buttonHeight, isDark)),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: SizedBox(
                                          height: buttonHeight,
                                          child: _requestButton(
                                              buttonHeight, isDark),
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // 🔴 Retry Button
  Widget _retryButton(double buttonHeight, bool isDark) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[100],
        foregroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () => _signatureController.clear(),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Retry"),
          SizedBox(width: 6),
          Icon(Icons.refresh, size: 20, color: Colors.red),
        ],
      ),
    );
  }

  // 🔵 Request Button
  Widget _requestButton(double buttonHeight, bool isDark) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isDark ? AppColors.darkPrimaryBlue : AppColors.primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        if (_signatureController.isNotEmpty) {
          Get.toNamed(AppRoutes.approved);
        }
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Request Check In",
          ),
          SizedBox(width: 6),
          Icon(Icons.arrow_forward, size: 18, color: Colors.white),
        ],
      ),
    );
  }
}
