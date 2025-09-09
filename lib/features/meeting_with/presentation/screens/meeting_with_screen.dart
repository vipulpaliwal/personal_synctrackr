// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MeetingWithScreen extends StatefulWidget {
//   const MeetingWithScreen({super.key});

//   @override
//   State<MeetingWithScreen> createState() => _MeetingWithScreenState();
// }

// class _MeetingWithScreenState extends State<MeetingWithScreen> {
//   final List<Map<String, String>> contacts = [
//     {
//       "name": "Satya Prakash Singh",
//       "role": "Founder",
//       "image": "assets/images/id_card.jpg"
//     },
//     {
//       "name": "Rohit Shah",
//       "role": "Manager",
//       "image": "assets/images/id_card.jpg"
//     },
//     {
//       "name": "Satyendra Nagar",
//       "role": "Site Engineer",
//       "image": "assets/images/id_card.jpg"
//     },
//     {
//       "name": "Vishal Tiwari",
//       "role": "Tech Head",
//       "image": "assets/images/id_card.jpg"
//     },
//   ];

//   int selectedIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F9FF),
//       body: Stack(
//         children: [
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
//                   height: 850,
//                   padding: const EdgeInsets.all(40),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.4),
//                     borderRadius: BorderRadius.circular(25),
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.6),
//                       width: 4,
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Logo
//                       Center(
//                         child: Image.asset(
//                           'assets/images/logo.png',
//                           width: 300,
//                           height: 152,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       // Title
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text.rich(
//                             TextSpan(
//                               children: [
//                                 const TextSpan(
//                                   text: "Meeting With ",
//                                   style: TextStyle(
//                                     fontSize: 40,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 const TextSpan(
//                                   text: "?",
//                                   style: TextStyle(
//                                     fontSize: 40,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xFF3B82F6),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             textAlign: TextAlign.start,
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             "Select your contact parson name",
//                             style: GoogleFonts.poppins(
//                               fontSize: 20,
//                               fontWeight: FontWeight.normal,
//                               height: 1.6,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       TextField(
//                         // controller: idController,
//                         decoration: InputDecoration(
//                           suffixIcon: Icon(Icons.search),
//                           hintText: "Search Contact Parson Name",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 14,
//                             vertical: 12,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Expanded(
//                         child: ListView.separated(
//                           itemCount: contacts.length,
//                           separatorBuilder: (context, index) =>
//                               const SizedBox(height: 10),
//                           itemBuilder: (context, index) {
//                             final contact = contacts[index];
//                             return InkWell(
//                               borderRadius: BorderRadius.circular(12),
//                               onTap: () {
//                                 setState(() {
//                                   selectedIndex = index;
//                                 });
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 10),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: selectedIndex == index
//                                         ? Colors.blue
//                                         : Colors.transparent,
//                                     width: 2,
//                                   ),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 22,
//                                       backgroundImage:
//                                           AssetImage(contact['image']!),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Expanded(
//                                       child: Text(
//                                         contact['name']!,
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ),
//                                     Text(
//                                       contact['role']!,
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),

//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF2F69FF),
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: const [
//                               Text(
//                                 "Next",
//                                 style: TextStyle(fontSize: 15),
//                               ),
//                               SizedBox(width: 8),
//                               Icon(
//                                 Icons.arrow_forward,
//                                 size: 20,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
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
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/core/constants/app_assets.dart';

// import '../../../../core/routes/app_routes.dart';

// class MeetingWithScreen extends StatefulWidget {
//   const MeetingWithScreen({super.key});

//   @override
//   State<MeetingWithScreen> createState() => _MeetingWithScreenState();
// }

// class _MeetingWithScreenState extends State<MeetingWithScreen> {
//   final List<Map<String, String?>> contacts = [
//     {
//       "name": "Satya Prakash Singh",
//       "role": "Founder",
//       "image": "assets/images/id_card.jpg"
//     },
//     {
//       "name": "Rohit Shah",
//       "role": "Manager",
//       "image": "assets/images/id_card.jpg"
//     },
//     {
//       "name": "Satyendra Nagar",
//       "role": "Site Engineer",
//       "image": "assets/images/id_card.jpg"
//     },
//     {
//       "name": "Vishal Tiwari",
//       "role": "Tech Head",
//       "image": "assets/images/id_card.jpg"
//     },
//   ];

//   int selectedIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     // Determine layout breakpoints
//     final isMobile = screenWidth <= 600;
//     final isTablet = screenWidth > 600 && screenWidth <= 1024;
//     final isDesktop = screenWidth > 1024;

//     // Responsive Sizes
//     double containerWidth = screenWidth * 0.9;
//     double maxContainerWidth = 600;

//     double logoWidth = isMobile
//         ? 140
//         : isTablet
//             ? 200
//             : 300;
//     double logoHeight = isMobile
//         ? 80
//         : isTablet
//             ? 110
//             : 150;

//     double titleFont = isMobile
//         ? 26
//         : isTablet
//             ? 32
//             : 40;
//     double subTitleFont = isMobile
//         ? 14
//         : isTablet
//             ? 18
//             : 20;
//     double textFont = isMobile
//         ? 13
//         : isTablet
//             ? 15
//             : 16;

//     double spacing = isMobile ? 10 : 20;

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
//               padding: EdgeInsets.all(isMobile ? 0 : 16),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   maxWidth: maxContainerWidth,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(25),
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                     child: Container(
//                       padding: EdgeInsets.all(isMobile ? 20 : 30),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.4),
//                         borderRadius: BorderRadius.circular(25),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.6),
//                           width: 4,
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Logo
//                           Center(
//                             child: Image.asset(
//                               'assets/images/logo.png',
//                               width: logoWidth,
//                               height: logoHeight,
//                             ),
//                           ),
//                           SizedBox(height: spacing),
//                           // Title
//                           Text.rich(
//                             TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: "Meeting With ",
//                                   style: TextStyle(
//                                     fontSize: titleFont,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: "?",
//                                   style: TextStyle(
//                                     fontSize: titleFont,
//                                     fontWeight: FontWeight.w600,
//                                     color: const Color(0xFF3B82F6),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: spacing / 2),
//                           Text(
//                             "Select your contact person name",
//                             style: GoogleFonts.poppins(
//                               fontSize: subTitleFont,
//                               fontWeight: FontWeight.normal,
//                               height: 1.4,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           SizedBox(height: spacing),
//                           // Search
//                           TextField(
//                             decoration: InputDecoration(
//                               suffixIcon: const Icon(Icons.search),
//                               hintText: "Search Contact Person Name",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               filled: true,
//                               fillColor: Colors.transparent,
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 14,
//                                 vertical: 12,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: spacing),
//                           // Contact List
//                           ListView.separated(
//                             physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: contacts.length,
//                             separatorBuilder: (context, index) =>
//                                 const SizedBox(height: 10),
//                             itemBuilder: (context, index) {
//                               final contact = contacts[index];
//                               return InkWell(
//                                 borderRadius: BorderRadius.circular(12),
//                                 onTap: () {
//                                   setState(() {
//                                     selectedIndex = index;
//                                   });
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 10),
//                                   decoration: BoxDecoration(
//                                     color: selectedIndex == index
//                                         ? Colors.white
//                                         : Colors.transparent,
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                       color: selectedIndex == index
//                                           ? Colors.blue
//                                           : Colors.transparent,
//                                       width: 2,
//                                     ),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 22,
//                                         backgroundImage:
//                                             AssetImage(contact['image']!),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Expanded(
//                                         child: Text(
//                                           contact['name']!,
//                                           style: GoogleFonts.poppins(
//                                             fontSize: textFont,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         contact['role']!,
//                                         style: GoogleFonts.poppins(
//                                           fontSize: textFont - 1,
//                                           color: Colors.blue,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           SizedBox(height: spacing),
//                           // Button
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Get.toNamed(AppRoutes.uploadphoto);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF2F69FF),
//                                 foregroundColor: Colors.white,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 16),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: const [
//                                   Text("Next", style: TextStyle(fontSize: 15)),
//                                   SizedBox(width: 8),
//                                   Icon(
//                                     Icons.arrow_forward,
//                                     size: 20,
//                                     color: Colors.white,
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
import 'package:synctrackr/core/widgets/primary_btn.dart';
import '../../../../core/routes/app_routes.dart';

class MeetingWithScreen extends StatefulWidget {
  const MeetingWithScreen({super.key});

  @override
  State<MeetingWithScreen> createState() => _MeetingWithScreenState();
}

class _MeetingWithScreenState extends State<MeetingWithScreen> {
  final List<Map<String, String?>> contacts = [
    {
      "name": "Satya Prakash Singh",
      "role": "Founder",
      "image": "assets/images/id_card.jpg"
    },
    {
      "name": "Rohit Shah",
      "role": "Manager",
      "image": "assets/images/id_card.jpg"
    },
    {
      "name": "Satyendra Nagar",
      "role": "Site Engineer",
      "image": "assets/images/id_card.jpg"
    },
    {
      "name": "Vishal Tiwari",
      "role": "Tech Head",
      "image": "assets/images/id_card.jpg"
    },
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;
    final isTablet = screenWidth > 600 && screenWidth <= 1024;

    // Dark theme check
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Colors
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? AppColors.primaryBlue : Colors.black87;
    final cardColor =
        isDark ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.4);
    final borderColor = isDark ? Colors.white30 : Colors.white.withOpacity(0.6);
    final highlightColor = Colors.blue;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0D1B2A) : const Color(0xFFF5F9FF),
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
              padding: EdgeInsets.all(isMobile ? 0 : 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: EdgeInsets.all(isMobile ? 20 : 30),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: borderColor,
                          width: 3,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo
                          Center(
                            child: Image.asset(
                              // 'assets/images/logo.png',
                              isDark ? AppAssets.logoDark : AppAssets.logo,
                              width: isMobile
                                  ? 140
                                  : isTablet
                                      ? 200
                                      : 300,
                              height: isMobile
                                  ? 80
                                  : isTablet
                                      ? 110
                                      : 150,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Title
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Meeting With ",
                                  style: TextStyle(
                                    fontSize: isMobile
                                        ? 26
                                        : isTablet
                                            ? 32
                                            : 40,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                                ),
                                TextSpan(
                                  text: "?",
                                  style: TextStyle(
                                      fontSize: isMobile
                                          ? 26
                                          : isTablet
                                              ? 32
                                              : 40,
                                      fontWeight: FontWeight.w600,
                                      // color: highlightColor,
                                      color: isDark
                                          ? AppColors.darkPrimaryBlue
                                          : AppColors.primaryBlue),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Select your contact person name",
                            style: GoogleFonts.poppins(
                              fontSize: isMobile
                                  ? 14
                                  : isTablet
                                      ? 18
                                      : 20,
                              fontWeight: FontWeight.normal,
                              height: 1.4,
                              color: subTextColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Search
                          TextField(
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search,
                                  color: isDark
                                      ? AppColors.background
                                      : AppColors.darkAdmin),
                              hintText: "Search Contact Person Name",
                              hintStyle: TextStyle(color: subTextColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: highlightColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: subTextColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: highlightColor, width: 1.5),
                              ),
                              filled: true,
                              fillColor: isDark ? Colors.black45 : Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Contact List
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: contacts.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final contact = contacts[index];
                              return InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? (isDark
                                            ? AppColors.textDark
                                            : Colors.white)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: selectedIndex == index
                                          // ? highlightColor
                                          ? isDark
                                              ? AppColors.darkPrimaryBlue
                                              : highlightColor
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 22,
                                        backgroundImage:
                                            AssetImage(contact['image']!),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          contact['name']!,
                                          style: GoogleFonts.poppins(
                                            fontSize: isMobile
                                                ? 13
                                                : isTablet
                                                    ? 15
                                                    : 16,
                                            fontWeight: FontWeight.w500,
                                            color: textColor,
                                            // color: isDark
                                            //     ? AppColors.darkPrimaryBlue
                                            //     : textColor
                                          ),
                                        ),
                                      ),
                                      Text(
                                        contact['role']!,
                                        style: GoogleFonts.poppins(
                                          fontSize: isMobile
                                              ? 12
                                              : isTablet
                                                  ? 14
                                                  : 15,
                                          // color: highlightColor,
                                          color: isDark
                                              ? AppColors.darkPrimaryBlue
                                              : textColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          // Button
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       Get.toNamed(AppRoutes.uploadphoto);
                          //     },
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: highlightColor,
                          //       foregroundColor: Colors.white,
                          //       padding:
                          //           const EdgeInsets.symmetric(vertical: 16),
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(8),
                          //       ),
                          //     ),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: const [
                          //         Text("Next", style: TextStyle(fontSize: 15)),
                          //         SizedBox(width: 8),
                          //         Icon(Icons.arrow_forward,
                          //             size: 20, color: Colors.white),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          PrimaryButton(
                            text: "Next",
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
