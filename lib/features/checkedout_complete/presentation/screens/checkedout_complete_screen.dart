// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CheckedoutCompleteScreen extends StatefulWidget {
//   const CheckedoutCompleteScreen({super.key});

//   @override
//   State<CheckedoutCompleteScreen> createState() => _CheckedoutCompleteScreenState();
// }

// class _CheckedoutCompleteScreenState extends State<CheckedoutCompleteScreen> {
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
//                   height: 650,
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
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/images/logo.png',
//                         width: 300,
//                         height: 152,
//                       ),
//                       const SizedBox(height: 30),

//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Check Out',
//                             style: GoogleFonts.poppins(
//                               color: Colors.green[600],
//                               fontSize: 40,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             "You have successfully checked out",
//                             style: GoogleFonts.poppins(
//                               fontSize: 20,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//                         ],
//                       ),
                      
//                       Container(
//                         width: 120,
//                         height: 120,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Color(0xFFF4FFEC), 
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(
//                               12), 
//                           child: Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color:
//                                     Color(0xFF43B000), 
//                                 width: 3,
//                               ),
//                             ),
//                             child: const Center(
//                               child: Icon(
//                                 Icons.check,
//                                 size: 42,
//                                 color: Color(0xFF43B000), 
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 40),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF3B82F6),
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text("Exit"),
//                               SizedBox(width: 6),
//                               Icon(
//                                 Icons.arrow_forward,
//                                 size: 18,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text("Automatic Exit in 5 Seconds")
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



import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/core/constants/app_assets.dart';

class CheckedoutCompleteScreen extends StatefulWidget {
  const CheckedoutCompleteScreen({super.key});

  @override
  State<CheckedoutCompleteScreen> createState() => _CheckedoutCompleteScreenState();
}

class _CheckedoutCompleteScreenState extends State<CheckedoutCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final isMobile = screenWidth < 600;
          final isTablet = screenWidth >= 600 && screenWidth < 1024;

          double containerWidth = isMobile
              ? screenWidth * 1.0
              : isTablet
                  ? screenWidth * 0.75
                  : 646;

          double containerHeight = isMobile
              ? screenWidth * 1.3
              : isTablet
                  ? screenWidth * 1.0
                  : 650;

          double headingFontSize = isMobile ? 26 : isTablet ? 32 : 40;
          double subTextFontSize = isMobile ? 14 : 16;
          double iconSize = isMobile ? 32 : 42;
          double circleSize = isMobile ? 90 : 120;

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
                      height: containerHeight,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.6),
                          width: 4,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            width: isMobile ? 180 : 300,
                            height: isMobile ? 80 : 152,
                          ),
                          const SizedBox(height: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Check Out',
                                style: GoogleFonts.poppins(
                                  color: Colors.green[600],
                                  fontSize: headingFontSize,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "You have successfully checked out",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: subTextFontSize,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                          Container(
                            width: circleSize,
                            height: circleSize,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF4FFEC),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFF43B000),
                                    width: 3,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    size: iconSize,
                                    color: const Color(0xFF43B000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B82F6),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Exit"),
                                  SizedBox(width: 6),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Automatic Exit in 5 Seconds",
                            style: GoogleFonts.poppins(
                              fontSize: subTextFontSize,
                              color: Colors.black54,
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
