// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/core/constants/app_assets.dart';
// import 'package:synctrackr/core/constants/app_colors.dart';
// import 'package:synctrackr/core/widgets/primary_btn.dart';

// import '../../../../core/routes/app_routes.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   bool laterAppointment = false;
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F9FF),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double screenWidth = constraints.maxWidth;

//           bool isMobile = screenWidth < 600;
//           bool isTablet = screenWidth >= 600 && screenWidth < 1024;
//           bool isDesktop = screenWidth >= 1024;

//           double containerWidth = isMobile
//               ? screenWidth * 1.0
//               : isTablet
//                   ? 600
//                   : 700;

//           double logoWidth = isMobile ? 180 : 300;
//           double logoHeight = isMobile ? 100 : 152;
//           double headingFontSize = isMobile ? 26 : 40;
//           double subTextFontSize = isMobile ? 16 : 20;
//           double labelFontSize = isMobile ? 12 : 14;
//           double buttonFontSize = isMobile ? 14 : 16;

//           return Stack(
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
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(25),
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                     child: Container(
//                       width: containerWidth,
//                       padding: const EdgeInsets.all(30),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(25),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.6),
//                           width: 4,
//                         ),
//                       ),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Center(
//                               child: Image.asset(
//                                 'assets/images/logo.png',
//                                 width: logoWidth,
//                                 height: logoHeight,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Text(
//                               "Profile",
//                               style: TextStyle(
//                                 fontSize: headingFontSize,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Text(
//                               "Let's complete your profile",
//                               style: GoogleFonts.poppins(
//                                 fontSize: subTextFontSize,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             buildTextField("Full Name"),
//                             const SizedBox(height: 10),
//                             buildTextField("Email Id"),
//                             const SizedBox(height: 10),
//                             buildTextField("Company"),
//                             const SizedBox(height: 10),
//                             buildTextField("Profession"),
//                             const SizedBox(height: 15),

//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "A Later Appointment Date",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: labelFontSize,
//                                         ),
//                                       ),
//                                       Text(
//                                         "This can be used to request a later appointment time.",
//                                         style: TextStyle(
//                                           fontSize: labelFontSize - 2,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Switch(
//                                   value: laterAppointment,
//                                   activeColor: Colors.white,
//                                   activeTrackColor: AppColors.primaryBlue,
//                                   // inactiveThumbColor: Colors.black,
//                                   inactiveTrackColor: Colors.white,
//                                   trackOutlineColor:
//                                       WidgetStateProperty.resolveWith<Color?>(
//                                     (states) => !laterAppointment
//                                         ? Colors.blue
//                                         : Colors.transparent,
//                                   ),
//                                   thumbColor:
//                                       MaterialStateProperty.resolveWith<Color>(
//                                     (states) {
//                                       if (states
//                                           .contains(MaterialState.selected)) {
//                                         return Colors.white;
//                                       }
//                                       return Colors.black;
//                                     },
//                                   ),
//                                   materialTapTargetSize:
//                                       MaterialTapTargetSize.shrinkWrap,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       laterAppointment = value;
//                                     });
//                                   },
//                                 )
//                               ],
//                             ),

//                             // Date & Time Pickers
//                             if (laterAppointment) ...[
//                               const SizedBox(height: 10),
//                               Row(
//                                 children: [
//                                   // Date Picker
//                                   Expanded(
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         final date = await showDatePicker(
//                                           context: context,
//                                           initialDate: DateTime.now(),
//                                           firstDate: DateTime.now(),
//                                           lastDate: DateTime(2100),
//                                         );
//                                         if (date != null) {
//                                           setState(() {
//                                             selectedDate = date;
//                                           });
//                                         }
//                                       },
//                                       child: buildPickerField(
//                                         label: selectedDate == null
//                                             ? "Date"
//                                             : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
//                                         icon: Icons.calendar_today,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   // Time Picker
//                                   Expanded(
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         final time = await showTimePicker(
//                                           context: context,
//                                           initialTime: TimeOfDay.now(),
//                                         );
//                                         if (time != null) {
//                                           setState(() {
//                                             selectedTime = time;
//                                           });
//                                         }
//                                       },
//                                       child: buildPickerField(
//                                         label: selectedTime == null
//                                             ? "Time"
//                                             : selectedTime!.format(context),
//                                         icon: Icons.access_time,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],

//                             const SizedBox(height: 20),

//                             // Next Button
//                             PrimaryButton(
//                               text: "Next",
//                               fontSize: buttonFontSize,
//                               onPressed: () {
//                                 Get.toNamed(AppRoutes.uploadid);
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Reusable TextField
//   Widget buildTextField(String hint) {
//     return TextField(
//       style: const TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade400),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade400),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.blue),
//         ),
//       ),
//     );
//   }

//   // Reusable Picker (Date & Time)
//   Widget buildPickerField({required String label, required IconData icon}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 14)),
//           Icon(icon, size: 18, color: Colors.black54),
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool laterAppointment = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0D1B2A) : const Color(0xFFF5F9FF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;

          bool isMobile = screenWidth < 600;
          bool isTablet = screenWidth >= 600 && screenWidth < 1024;

          double containerWidth = isMobile
              ? screenWidth * 1.0
              : isTablet
                  ? 600
                  : 700;

          double logoWidth = isMobile ? 180 : 300;
          double logoHeight = isMobile ? 100 : 152;
          double headingFontSize = isMobile ? 26 : 40;
          double subTextFontSize = isMobile ? 16 : 20;
          double labelFontSize = isMobile ? 12 : 14;
          double buttonFontSize = isMobile ? 14 : 16;

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
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withOpacity(0.4)
                            : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          // color: Colors.white.withOpacity(0.6),
                          color: isDark
                              ? Colors.white
                              : Colors.white.withOpacity(0.6),
                          width: 4,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                isDark ? AppAssets.logoDark : AppAssets.logo,
                                width: isMobile ? 180 : 300,
                                height: isMobile ? 90 : 152,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: headingFontSize,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              "Let's complete your profile",
                              style: GoogleFonts.poppins(
                                fontSize: subTextFontSize,
                                fontWeight: FontWeight.normal,
                                color: isDark ? Colors.white60 : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 20),
                            buildTextField("Full Name", isDark),
                            const SizedBox(height: 10),
                            buildTextField("Email Id", isDark),
                            const SizedBox(height: 10),
                            buildTextField("Company", isDark),
                            const SizedBox(height: 10),
                            buildTextField("Profession", isDark),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "A Later Appointment Date",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: labelFontSize,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "This can be used to request a later appointment time.",
                                        style: TextStyle(
                                          fontSize: labelFontSize - 2,
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: laterAppointment,
                                  activeColor: Colors.white,
                                  activeTrackColor: AppColors.primaryBlue,
                                  inactiveTrackColor: Colors.white,
                                  trackOutlineColor:
                                      WidgetStateProperty.resolveWith<Color?>(
                                    (states) => !laterAppointment
                                        ? Colors.blue
                                        : Colors.transparent,
                                  ),
                                  thumbColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return Colors.white;
                                      }
                                      return Colors.black;
                                    },
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (value) {
                                    setState(() {
                                      laterAppointment = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            if (laterAppointment) ...[
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100),
                                        );
                                        if (date != null) {
                                          setState(() {
                                            selectedDate = date;
                                          });
                                        }
                                      },
                                      child: buildPickerField(
                                        label: selectedDate == null
                                            ? "Date"
                                            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                        icon: Icons.calendar_today,
                                        isDark: isDark,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (time != null) {
                                          setState(() {
                                            selectedTime = time;
                                          });
                                        }
                                      },
                                      child: buildPickerField(
                                        label: selectedTime == null
                                            ? "Time"
                                            : selectedTime!.format(context),
                                        icon: Icons.access_time,
                                        isDark: isDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 20),
                            PrimaryButton(
                              text: "Next",
                              fontSize: buttonFontSize,
                              onPressed: () {
                                Get.toNamed(AppRoutes.uploadid);
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
          );
        },
      ),
    );
  }

  // Reusable TextField
  Widget buildTextField(String hint, bool isDark) {
    return TextField(
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14,
          color: isDark ? Colors.white70 : Colors.black54,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            // color: isDark ? Colors.white54 : Colors.grey.shade400
            color: isDark ? AppColors.primaryBlue : Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            // color: isDark ? Colors.white54 : Colors.grey.shade400
            color: isDark ? AppColors.primaryBlue : Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primaryBlue),
        ),
      ),
    );
  }

  // Reusable Picker (Date & Time)
  Widget buildPickerField({
    required String label,
    required IconData icon,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(
          // color: isDark ? Colors.white54 : Colors.grey.shade400
          color: isDark ? AppColors.primaryBlue : Colors.black,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          Icon(icon, size: 18, color: isDark ? Colors.white70 : Colors.black54),
        ],
      ),
    );
  }
}
