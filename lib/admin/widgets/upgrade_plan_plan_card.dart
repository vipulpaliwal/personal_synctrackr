// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/models/upgrade_plan_plan_model.dart';

// class PlanCardWidget extends StatelessWidget {
//   final Plan plan;
//   final bool isSelected;
//   final bool isAnnualBilling;
//   final VoidCallback onTap;

//   const PlanCardWidget({
//     super.key,
//     required this.plan,
//     required this.isSelected,
//     required this.isAnnualBilling,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final price = isAnnualBilling ? plan.annualPrice : plan.monthlyPrice;

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 200,
//         padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF4C6FFF).withOpacity(0.1) : Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? const Color(0xFF4C6FFF) : Colors.grey.shade300,
//             width: 1.5,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   plan.title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF212529),
//                   ),
//                 ),
//                 if (isSelected)
//                   const Icon(
//                     Icons.check_circle,
//                     color: Color(0xFF4C6FFF),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Text(
//               price,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF212529),
//               ),
//             ),
//             const SizedBox(height: 4),
//             const Text(
//               "View Features",
//               style: TextStyle(
//                 color: Color(0xFF4C6FFF),
//                 fontWeight: FontWeight.w500,
//                 decoration: TextDecoration.none,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               plan.description,
//               style: GoogleFonts.lexend(
//                 color: Color(0xFF6C757D),
//                 fontSize: 10,
//                 fontWeight: FontWeight.w300
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/models/upgrade_plan_plan_model.dart';
import 'package:synctrackr/admin/utils/colors.dart';

class PlanCardWidget extends StatelessWidget {
  final Plan plan;
  final bool isSelected;
  final bool isAnnualBilling;
  final VoidCallback onTap;
  final bool isDarkMode;

  const PlanCardWidget({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.isAnnualBilling,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final price = isAnnualBilling ? plan.annualPrice : plan.monthlyPrice;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode
                  ? adminAppColors.darkSecondaryBackground.withOpacity(0.3)
                  : adminAppColors.primary.withOpacity(0.1))
              : (isDarkMode
                  ? adminAppColors.darkCard
                  : adminAppColors.cardBackground),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isDarkMode
                    ? adminAppColors.secondary
                    : adminAppColors.primary)
                : (isDarkMode
                    ? adminAppColors.secondary
                    : Colors.grey.shade300),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  plan.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : adminAppColors.textPrimary,
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: isDarkMode
                        ? adminAppColors.darkPrimary
                        : adminAppColors.primary,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              price,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? adminAppColors.darkTextPrimary
                    : adminAppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "View Features",
              style: TextStyle(
                color: isDarkMode
                    ? adminAppColors.darkPrimary
                    : adminAppColors.primary,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              plan.description,
              style: GoogleFonts.lexend(
                color: isDarkMode
                    ? adminAppColors.darkTextSecondary
                    : adminAppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
