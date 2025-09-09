// import 'package:flutter/material.dart';

// class PrimaryButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final double fontSize;

//   const PrimaryButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.fontSize = 16,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF2F69FF),
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               text,
//               style: TextStyle(fontSize: fontSize),
//             ),
//             const SizedBox(width: 8),
//             const Icon(
//               Icons.arrow_forward,
//               size: 20,
//               color: Colors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:synctrackr/core/constants/app_barrels.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDark ? AppColors.darkPrimaryBlue : const Color(0xFF2F69FF),
          // foregroundColor: Colors.white,
          foregroundColor: isDark ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: isDark ? Colors.black : Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              size: 20,
              // color: Colors.white,
              color: isDark ? Colors.black : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
