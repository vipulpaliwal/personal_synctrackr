// import 'dart:ui';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class EPassScreen extends StatefulWidget {
//   const EPassScreen({super.key});

//   @override
//   State<EPassScreen> createState() => _EPassScreenState();
// }

// class _EPassScreenState extends State<EPassScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F9FF),
//       body: Stack(
//         children: [
//           // Background wave
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/lines_wave.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Center(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(25),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                 child: Container(
//                   width: 646,
//                   height: 1000,
//                   padding: const EdgeInsets.all(40),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.4),
//                     borderRadius: BorderRadius.circular(25),
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.6),
//                       width: 4,
//                     ),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 12,
//                         offset: Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       // Logo
//                       Image.asset(
//                         'assets/images/logo.png',
//                         width: 300,
//                         height: 152,
//                       ),
//                       const SizedBox(height: 10),

//                       // Title
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: "Visitor ",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 40,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: "E-PASS",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 40,
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF3B82F6),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               "Scan your pass on arrival for a faster, smoother check-in",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w300,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 6,
//                               offset: Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 20, horizontal: 20),
//                         child: Column(
//                           children: [
//                             Text(
//                               'Scan OR Tap to Check in',
//                               style: GoogleFonts.poppins(fontSize: 12),
//                             ),
//                             const SizedBox(height: 16),
//                             QrImageView(
//                               data: 'https://example.com/checkin',
//                               size: 180,
//                               backgroundColor: Colors.white,
//                             ),
//                             const SizedBox(height: 16),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 6),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Date of Pass Generation:',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   Text(
//                                     'May 23 2025 05:07 PM IST',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: 510,
//                         child: const DottedLine(
//                           dashLength: 6,
//                           dashGapLength: 4,
//                           lineThickness: 1.5,
//                           dashColor: Colors.black,
//                         ),
//                       ),

//                       Container(
//                         // height: 200,
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 6,
//                               offset: Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Visitor ID B03D7282",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 Text(
//                                   "May 25 2025 01:00 PM IST",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Profile image
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(100),
//                                   child: Image.asset(
//                                     'assets/images/profile.jpg',
//                                     width: 56,
//                                     height: 56,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 // Name and contact
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Devesh Rajpoot",
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text(
//                                         "From Prisa Enterprises",
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 20,
//                                           color: Colors.black87,
//                                         ),
//                                       ),
//                                       Text(
//                                         "Devesh@prisaenterprises.com",
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 16,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       Text(
//                                         "+91 7456854498",
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 16,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       "Meeting with",
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 20,
//                                         color: Colors.black87,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     Text(
//                                       "Karim Fares",
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 20,
//                                         // fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 16),
//                                     Text(
//                                       "Vendor",
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
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
// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:synctrackr/core/constants/app_assets.dart';

// class EPassScreen extends StatefulWidget {
//   const EPassScreen({super.key});

//   @override
//   State<EPassScreen> createState() => _EPassScreenState();
// }

// class _EPassScreenState extends State<EPassScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double screenWidth = constraints.maxWidth;
//         bool isMobile = screenWidth < 600;
//         bool isTablet = screenWidth >= 600 && screenWidth < 1024;
//         bool isDesktop = screenWidth >= 1024;

//         double containerWidth = isMobile
//             ? screenWidth * 1.0
//             : isTablet
//                 ? screenWidth * 0.8
//                 : 646;

//         double qrSize = isMobile ? 140 : 180;
//         double titleFontSize = isMobile ? 26 : 40;
//         double subTextFontSize = isMobile ? 14 : 18;

//         return Scaffold(
//           backgroundColor: const Color(0xFFF5F9FF),
//           body: Stack(
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
//                 child: SingleChildScrollView(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(25),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                       child: Container(
//                         width: containerWidth,
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.4),
//                           borderRadius: BorderRadius.circular(25),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.6),
//                             width: 4,
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Center(
//                               child: Image.asset(
//                                 'assets/images/logo.png',
//                                 width: isMobile ? 200 : 300,
//                                 height: isMobile ? 100 : 152,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: "Visitor ",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: titleFontSize,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: "E-PASS",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: titleFontSize,
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF3B82F6),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               "Scan your pass on arrival for a faster, smoother check-in",
//                               style: GoogleFonts.poppins(
//                                 fontSize: subTextFontSize,
//                                 fontWeight: FontWeight.w300,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Container(
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Colors.black12,
//                                     blurRadius: 6,
//                                     offset: Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                               padding: const EdgeInsets.all(20),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     'Scan OR Tap to Check in',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: isMobile ? 10 : 12,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 16),
//                                   QrImageView(
//                                     data: 'https://example.com/checkin',
//                                     size: qrSize,
//                                     backgroundColor: Colors.white,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   isMobile
//                                       ? Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Date of Pass Generation:',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 12 : 16,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             Text(
//                                               'May 23 2025 05:07 PM IST',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 12 : 16,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       : Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Flexible(
//                                               child: Text(
//                                                 'Date of Pass Generation:',
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: GoogleFonts.poppins(
//                                                   fontSize: isMobile ? 12 : 16,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(width: 12),
//                                             Flexible(
//                                               child: Text(
//                                                 'May 23 2025 05:07 PM IST',
//                                                 overflow: TextOverflow.ellipsis,
//                                                 textAlign: TextAlign.right,
//                                                 style: GoogleFonts.poppins(
//                                                   fontSize: isMobile ? 12 : 16,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                 ],
//                               ),
//                             ),
//                             const DottedLine(
//                               dashLength: 6,
//                               dashGapLength: 4,
//                               lineThickness: 1.5,
//                               dashColor: Colors.black,
//                             ),
//                             Container(
//                               width: double.infinity,
//                               padding: const EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Colors.black12,
//                                     blurRadius: 6,
//                                     offset: Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   isMobile
//                                       ? Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Visitor ID B03D7282",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             Text(
//                                               "May 25 2025 01:00 PM IST",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       : Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Flexible(
//                                               child: Text(
//                                                 "Visitor ID B03D7282",
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: GoogleFonts.poppins(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(width: 8),
//                                             Flexible(
//                                               child: Text(
//                                                 "May 25 2025 01:00 PM IST",
//                                                 overflow: TextOverflow.ellipsis,
//                                                 textAlign: TextAlign.right,
//                                                 style: GoogleFonts.poppins(
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                   const SizedBox(height: 12),
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                         child: Image.asset(
//                                           'assets/images/profile.jpg',
//                                           width: isMobile ? 48 : 56,
//                                           height: isMobile ? 48 : 56,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Devesh Rajpoot",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 20 : 24,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               "From Prisa Enterprises",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 16 : 20,
//                                                 color: Colors.black87,
//                                               ),
//                                             ),
//                                             Text(
//                                               "Devesh@prisaenterprises.com",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 14 : 16,
//                                               ),
//                                             ),
//                                             Text(
//                                               "+91 7456854498",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 14 : 16,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 12),
//                                             Text(
//                                               "Meeting with",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 18 : 20,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               "Karim Fares",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 18 : 20,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 12),
//                                             Text(
//                                               "Vendor",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 16 : 18,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// import 'dart:ui';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:synctrackr/core/constants/app_assets.dart';

// class EPassScreen extends StatefulWidget {
//   const EPassScreen({super.key});

//   @override
//   State<EPassScreen> createState() => _EPassScreenState();
// }

// class _EPassScreenState extends State<EPassScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double screenWidth = constraints.maxWidth;
//         bool isMobile = screenWidth < 600;
//         bool isTablet = screenWidth >= 600 && screenWidth < 1024;
//         bool isDesktop = screenWidth >= 1024;

//         double containerWidth = isMobile
//             ? screenWidth * 1.0
//             : isTablet
//                 ? screenWidth * 0.8
//                 : 646;

//         double qrSize = isMobile ? 140 : 180;
//         double titleFontSize = isMobile ? 26 : 40;
//         double subTextFontSize = isMobile ? 14 : 18;

//         return Scaffold(
//           backgroundColor: const Color(0xFFF5F9FF),
//           body: Stack(
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
//                 child: SingleChildScrollView(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(25),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                       child: Container(
//                         width: containerWidth,
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.4),
//                           borderRadius: BorderRadius.circular(25),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.6),
//                             width: 4,
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Center(
//                               child: Image.asset(
//                                 'assets/images/logo.png',
//                                 width: isMobile ? 200 : 300,
//                                 height: isMobile ? 100 : 152,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: "Visitor ",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: titleFontSize,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: "E-PASS",
//                                     style: GoogleFonts.poppins(
//                                       fontSize: titleFontSize,
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF3B82F6),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               "Scan your pass on arrival for a faster, smoother check-in",
//                               style: GoogleFonts.poppins(
//                                 fontSize: subTextFontSize,
//                                 fontWeight: FontWeight.w300,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Container(
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Colors.black12,
//                                     blurRadius: 6,
//                                     offset: Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                               padding: const EdgeInsets.all(20),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     'Scan OR Tap to Check in',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: isMobile ? 10 : 12,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 16),
//                                   QrImageView(
//                                     data: 'https://example.com/checkin',
//                                     size: qrSize,
//                                     backgroundColor: Colors.white,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   isMobile
//                                       ? Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Date of Pass Generation:',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 12,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             Text(
//                                               'May 23 2025 05:07 PM IST',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 12,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       : Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Flexible(
//                                               child: Text(
//                                                 'Date of Pass Generation:',
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: GoogleFonts.poppins(
//                                                   fontSize: 16,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(width: 12),
//                                             Flexible(
//                                               child: Text(
//                                                 'May 23 2025 05:07 PM IST',
//                                                 overflow: TextOverflow.ellipsis,
//                                                 textAlign: TextAlign.right,
//                                                 style: GoogleFonts.poppins(
//                                                   fontSize: 16,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                 ],
//                               ),
//                             ),
//                             const DottedLine(
//                               dashLength: 6,
//                               dashGapLength: 4,
//                               lineThickness: 1.5,
//                               dashColor: Colors.black,
//                             ),
//                             Container(
//                               width: double.infinity,
//                               padding: const EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Colors.black12,
//                                     blurRadius: 6,
//                                     offset: Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   isMobile
//                                       ? Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Visitor ID B03D7282",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             Text(
//                                               "May 25 2025 01:00 PM IST",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       : Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Flexible(
//                                               child: Text(
//                                                 "Visitor ID B03D7282",
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: GoogleFonts.poppins(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(width: 8),
//                                             Flexible(
//                                               child: Text(
//                                                 "May 25 2025 01:00 PM IST",
//                                                 overflow: TextOverflow.ellipsis,
//                                                 textAlign: TextAlign.right,
//                                                 style: GoogleFonts.poppins(
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                   const SizedBox(height: 12),
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                         child: Image.asset(
//                                           'assets/images/profile.jpg',
//                                           width: isMobile ? 48 : 56,
//                                           height: isMobile ? 48 : 56,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Devesh Rajpoot",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 20 : 24,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               "From Prisa Enterprises",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 16 : 20,
//                                                 color: Colors.black87,
//                                               ),
//                                             ),
//                                             Text(
//                                               "Devesh@prisaenterprises.com",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 14 : 16,
//                                               ),
//                                             ),
//                                             Text(
//                                               "+91 7456854498",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: isMobile ? 14 : 16,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       if (!isMobile)
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                               "Meeting with",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               "Karim Fares",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 18,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 8),
//                                             Text(
//                                               "Vendor",
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                     ],
//                                   ),
//                                   if (isMobile) const SizedBox(height: 12),
//                                   if (isMobile)
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Meeting with",
//                                           style: GoogleFonts.poppins(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                         Text(
//                                           "Karim Fares",
//                                           style: GoogleFonts.poppins(
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           "Vendor",
//                                           style: GoogleFonts.poppins(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                                 "Also, you will receive this pass through the mail.")
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:ui';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:synctrackr/core/constants/app_assets.dart';
import 'package:synctrackr/core/constants/app_colors.dart';

class EPassScreen extends StatefulWidget {
  const EPassScreen({super.key});

  @override
  State<EPassScreen> createState() => _EPassScreenState();
}

class _EPassScreenState extends State<EPassScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        bool isMobile = screenWidth < 600;
        bool isTablet = screenWidth >= 600 && screenWidth < 1024;

        double containerWidth = isMobile
            ? screenWidth * 1.0
            : isTablet
                ? screenWidth * 0.8
                : 646;

        double qrSize = isMobile ? 140 : 180;
        double titleFontSize = isMobile ? 26 : 40;
        double subTextFontSize = isMobile ? 14 : 18;

        return Scaffold(
          backgroundColor:
              isDark ? const Color(0xFF0F172A) : const Color(0xFFF5F9FF),
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppAssets.backgroundWave,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  // color: isDark ? Colors.black.withOpacity(0.5) : null,
                  // colorBlendMode: isDark ? BlendMode.darken : BlendMode.dst,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: containerWidth,
                        padding: const EdgeInsets.all(20),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                isDark ? AppAssets.logoDark : AppAssets.logo,
                                width: isMobile ? 200 : 300,
                                height: isMobile ? 100 : 152,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Visitor ",
                                    style: GoogleFonts.poppins(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "E-PASS",
                                    style: GoogleFonts.poppins(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF3B82F6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Scan your pass on arrival for a faster, smoother check-in",
                              style: GoogleFonts.poppins(
                                fontSize: subTextFontSize,
                                fontWeight: FontWeight.w300,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: isDark ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Scan OR Tap to Check in',
                                    style: GoogleFonts.poppins(
                                      fontSize: isMobile ? 10 : 12,
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  QrImageView(
                                    data: 'https://example.com/checkin',
                                    size: qrSize,
                                    backgroundColor: Colors.white,
                                  ),
                                  const SizedBox(height: 16),
                                  isMobile
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Date of Pass Generation:',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: isDark
                                                    ? Colors.white70
                                                    : Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'May 23 2025 05:07 PM IST',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'Date of Pass Generation:',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: isDark
                                                      ? Colors.white70
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Flexible(
                                              child: Text(
                                                'May 23 2025 05:07 PM IST',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            const DottedLine(
                              dashLength: 6,
                              dashGapLength: 4,
                              lineThickness: 1.5,
                              dashColor: Colors.grey,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  isMobile
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Visitor ID B03D7282",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "May 25 2025 01:00 PM IST",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: isDark
                                                    ? Colors.white70
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "Visitor ID B03D7282",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Flexible(
                                              child: Text(
                                                "May 25 2025 01:00 PM IST",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: isDark
                                                      ? Colors.white70
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(height: 12),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                          'assets/images/profile.jpg',
                                          width: isMobile ? 48 : 56,
                                          height: isMobile ? 48 : 56,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Devesh Rajpoot",
                                              style: GoogleFonts.poppins(
                                                fontSize: isMobile ? 20 : 24,
                                                fontWeight: FontWeight.w600,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "From Prisa Enterprises",
                                              style: GoogleFonts.poppins(
                                                fontSize: isMobile ? 16 : 20,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              "Devesh@prisaenterprises.com",
                                              style: GoogleFonts.poppins(
                                                fontSize: isMobile ? 14 : 16,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              "+91 7456854498",
                                              style: GoogleFonts.poppins(
                                                fontSize: isMobile ? 14 : 16,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (!isMobile)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Meeting with",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "Karim Fares",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Vendor",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  // color: const Color(0xFF3B82F6),
                                                  color: isDark
                                                      ? AppColors.background
                                                      : AppColors
                                                          .darkBackground),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  if (isMobile) const SizedBox(height: 12),
                                  if (isMobile)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Meeting with",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Karim Fares",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Vendor",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: isDark
                                                  ? AppColors.background
                                                  : AppColors.darkBackground),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Also, you will receive this pass through the mail.",
                              style: GoogleFonts.poppins(
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            )
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
      },
    );
  }
}
