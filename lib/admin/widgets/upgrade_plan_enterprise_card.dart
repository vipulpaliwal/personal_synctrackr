// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:synctrackr/admin/controllers/main_controller.dart';
// import 'package:synctrackr/admin/utils/colors.dart';

// class EnterpriseCardWidget extends GetView<MainController> {
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 128,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         gradient: const LinearGradient(
//           colors: [Color(0xFFFDE8F1), Color(0xFFF9B8D8)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Container(
//         margin: const EdgeInsets.all(1.5),
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10.5),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Flexible(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "Enterprise Plan",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF212529),
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         "Available",
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     "Personalized Prices | Completely Customized to Your Company",
//                     style: TextStyle(color: Color(0xFF6C757D), fontSize: 10),
//                   ),
//                   Text(
//                     "A visitor management system that can grow with your business and be fully customized to fit your needs.",
//                     style: TextStyle(color: Color(0xFF6C757D), fontSize: 10),
//                   ),
//                 ],
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF4C6FFF),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               ),
//               child: const Text("Connect with Us"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/utils/colors.dart';

class EnterpriseCardWidget extends GetView {
  final bool isDarkMode;
  const EnterpriseCardWidget({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: isDarkMode
            ? const LinearGradient(
                colors: [Color(0xFF8C52FF), Color(0xFF5CE1E6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Color(0xFFFDE8F1), Color(0xFFF9B8D8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
      ),
      child: Container(
        margin: const EdgeInsets.all(1.5),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDarkMode
              ? adminAppColors.darkCard
              : adminAppColors.cardBackground,
          borderRadius: BorderRadius.circular(10.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Enterprise Plan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? adminAppColors.darkTextPrimary
                              : adminAppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Available",
                        style: TextStyle(
                          color: isDarkMode ? Colors.red.shade400 : Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Personalized Prices | Completely Customized to Your Company",
                    style: TextStyle(
                        color: isDarkMode
                            ? adminAppColors.darkTextSecondary
                            : adminAppColors.textSecondary,
                        fontSize: 10),
                  ),
                  Text(
                    "A visitor management system that can grow with your business and be fully customized to fit your needs.",
                    style: TextStyle(
                        color: isDarkMode
                            ? adminAppColors.darkTextSecondary
                            : adminAppColors.textSecondary,
                        fontSize: 10),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode
                    ? adminAppColors.darkMainButton
                    : adminAppColors.primary,
                foregroundColor: isDarkMode ? Colors.black : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text("Connect with Us"),
            ),
          ],
        ),
      ),
    );
  }
}
