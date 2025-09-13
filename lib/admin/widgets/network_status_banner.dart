// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/controllers/network_controller.dart';
// import 'package:synctrackr/admin/utils/colors.dart';

// class NetworkStatusBanner extends StatelessWidget {
//   const NetworkStatusBanner({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final NetworkController networkController = Get.put(NetworkController());

//     return Obx(() {
//       if (networkController.isOffline.value) {
//         return Container(
//           width: double.infinity,
//           color: Colors.red,
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.wifi_off, color: Colors.white, size: 16),
//               const SizedBox(width: 8),
//               Text(
//                 'Check your network connection',
//                 style: GoogleFonts.lexend(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         );
//       } else {
//         return const SizedBox.shrink();
//       }
//     });
//   }
// }


import 'dart:ui'; // 👈 Needed for ImageFilter
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/network_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';

class NetworkStatusBanner extends StatelessWidget {
  const NetworkStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final NetworkController networkController = Get.put(NetworkController());

    return Obx(() {
      if (networkController.isOffline.value) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10), // rounded corners
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // blur effect
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.withOpacity(0.4),
                    Colors.redAccent.withOpacity(0.25),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.redAccent.withOpacity(0.5),
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Check your network connection',
                    style: GoogleFonts.lexend(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
