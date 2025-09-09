// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:desktop_drop/desktop_drop.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/controllers/main_controller.dart';
// import 'package:synctrackr/admin/controllers/others_controller.dart';
// import 'package:synctrackr/admin/screens/others_checkIN_screen.dart';
// import 'package:synctrackr/admin/utils/colors.dart';
// import 'package:synctrackr/admin/utils/responsive.dart';
// import 'package:synctrackr/admin/widgets/bulk_pass_section.dart';
// import 'package:synctrackr/admin/widgets/common_header.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

// class OthersScreen extends StatefulWidget {
//   OthersScreen({super.key});

//   @override
//   State<OthersScreen> createState() => _OthersScreenState();
// }

// class _OthersScreenState extends State<OthersScreen> {
//   final OthersController controller = Get.put(OthersController());

//   double getBorderWidth(BuildContext context) {
//     if (Responsive.isDesktop(context)) {
//       return 1.0;
//     } else if (Responsive.isTablet(context)) {
//       return 2.0;
//     }
//     return 1.0; // fallback mobile etc.
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         const SliverAppBar(
//           pinned: true,
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.white54,
//           elevation: 0,
//           scrolledUnderElevation: 0.0,
//           flexibleSpace: CommonHeader(title: "Others"),
//         ),
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildStatsCards(context),
//                 const SizedBox(height: 32),
//                 _buildOptionsSection(),
//                 const SizedBox(height: 24),
//                 _buildBulkUploadSection(),
//                 const SizedBox(height: 24),
//                 const BulkPassSection(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatsCards(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         bool isTabletOrWeb = constraints.maxWidth > 768;
//         return Row(
//           children: [
//             Expanded(
//               child: _buildStatCard(
//                 'Customize Your Check-In Point',
//                 Icons.add,
//                 isTabletOrWeb,
//                 () {
//                   Get.find<MainController>().othersCheckinScreen();
//                 },
//                 const Color(0xFFF0F6FF),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: _buildStatCard(
//                 'Edit COVID-19 safety compliance',
//                 Icons.add,
//                 isTabletOrWeb,
//                 () {
//                   Get.find<MainController>().othersComplianceScreen();
//                 },
//                 const Color(0xFFEFF1FD),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: _buildStatCard(
//                 'Event E-Pass Bulk Generator',
//                 Icons.add,
//                 isTabletOrWeb,
//                 () {
//                   Get.find<MainController>().othersEpassGenerator();
//                 },
//                 const Color(0xFFF0F6FF),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildStatCard(String title, IconData icon, bool isTabletOrWeb,
//       VoidCallback ontap, Color bgColor) {
//     return GestureDetector(
//       onTap: ontap,
//       child: Container(
//         height: 120,
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: AppColors.primary,width:getBorderWidth(context) ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             FittedBox(
//               fit: BoxFit.scaleDown,
//               child: Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.lexend(
//                   color: Colors.black87,
//                   fontSize: isTabletOrWeb ? 18 : 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Icon(icon, size: isTabletOrWeb ? 30 : 24, color: Colors.black87),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOptionsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: AppColors.background,
//             border: Border.all(color: AppColors.primary, width: 1.5),
//             borderRadius: BorderRadius.circular(20),

//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _sectionTitle("Check-In Form Advanced Options"),
//               SizedBox(width: 15,),
//               _buildToggleOption('Need a mobile number with OTP?', true),
//                SizedBox(width: 12,),
//               _buildToggleOption('Is it necessary to keep ID proof?', false),
//             ],
//           ),
//         ),
//         SizedBox(height: 20,),
//         Container(
//           padding: EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: AppColors.background,
//             border: Border.all(color: AppColors.primary, width: 1.5),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _sectionTitle("Safety and Health Compliance"),
//               _buildToggleOption('Do you want to see Compliances ?', true),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title,
//             style: GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildToggleOption(String title, bool value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(child: Text(title, style: GoogleFonts.lexend(fontSize: 14))),
//         Switch(
//             value: value, onChanged: (_) {}, activeColor: Colors.blue.shade600),
//       ],
//     );
//   }

//   Widget _buildBulkUploadSection() {
//     return Obx(() {
//       final fileName = controller.file.value?.path.split('/').last ?? '';

//       final filePickerBox = Container(
//         padding: const EdgeInsets.all(20),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: AppColors.mainBackground,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: controller.file.value == null
//             ? Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children:  [
//                   Icon(Icons.cloud_upload_outlined,
//                       color: Colors.blue, size: 40),
//                   SizedBox(width: 8),
//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(text: 'Drag your file(s) or ',style: GoogleFonts.lexend(
// fontWeight: FontWeight.w300,
// fontSize: 14,
//                         )),
//                         TextSpan(
//                           text: 'browse',
//                           style: GoogleFonts.lexend(
//                               color: Colors.blue, fontWeight: FontWeight.bold),
//                         ),
//                          TextSpan(
//                           text: '  Max 10 MB Files are allowed',
//                           style: GoogleFonts.lexend(
//                                fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 14, color: Colors.black54),
//                   ),
//                 ],
//               )
//             : Text('File selected: $fileName'),
//       );

//       final uploadBox = DottedBorder(
//         options: RectDottedBorderOptions(
//         color: AppColors.primary,
//         strokeWidth: 1.5,
//         dashPattern: const [6, 6],
//         ),

//         child: InkWell(

//           onTap: controller.pickFile,
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(minHeight: 60),
//             child: filePickerBox,
//           ),
//         ),
//       );
//           onTap: controller.pickFile,
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(minHeight: 60),
//             child: filePickerBox,
//           ),
//         ),
//       );

//       final innerContent = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//            Text(
//             'Bulk Upload (CSV/Excel)',
//             style: GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 20),
//           kIsWeb
//               ? DropTarget(
//                   onDragDone: (detail) {
//                     if (detail.files.isNotEmpty) {
//                       controller.onFileDrop(detail.files.first.path);
//                     }
//                   },
//                   onDragEntered: (_) => controller.dragging.value = true,
//                   onDragExited: (_) => controller.dragging.value = false,
//                   child: uploadBox,
//                 )
//               : uploadBox,
//           const SizedBox(height: 8),
//           Text(
//             'Only support .csv, .xlsx and .xls files',
//             style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
//           ),
//         ],
//       );

//       return Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.primary),
//           color: controller.dragging.value
//               ? Colors.blue.withOpacity(0.1)
//               : AppColors.background,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: innerContent,
//       );
//     });
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/others_controller.dart';
import 'package:synctrackr/admin/screens/others_checkIN_screen.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/responsive.dart';
import 'package:synctrackr/admin/widgets/bulk_pass_section.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class OthersScreen extends StatefulWidget {
  const OthersScreen({super.key});

  @override
  State<OthersScreen> createState() => _OthersScreenState();
}

class _OthersScreenState extends State<OthersScreen> {
  final OthersController controller = Get.put(OthersController());

  double getBorderWidth(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 1.0;
    } else if (Responsive.isTablet(context)) {
      return 2.0;
    }
    return 1.0; // fallback mobile etc.
  }

  double getTextSize(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 14.0;
    } else if (Responsive.isTablet(context)) {
      return 10.0;
    }
    return 10.0; // fallback mobile etc.
  }

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    final isDarkMode = mainController.isDarkMode.value;
    return Container(
        child: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor:
              isDarkMode ? Colors.black.withOpacity(0.1) : Colors.white54,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          flexibleSpace: CommonHeader(title: "Others"),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatsCards(context),
                const SizedBox(height: 32),
                _buildOptionsSection(),
                const SizedBox(height: 24),
                _buildBulkUploadSection(),
                const SizedBox(height: 24),
                const BulkPassSection(),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildStatsCards(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTabletOrWeb = constraints.maxWidth > 768;
        return Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Customize Your Check-In Point',
                Icons.add,
                isTabletOrWeb,
                () {
                  Get.find<MainController>().othersCheckinScreen();
                },
                const Color(0xFFF0F6FF),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Edit COVID-19 safety compliance',
                Icons.add,
                isTabletOrWeb,
                () {
                  Get.find<MainController>().othersComplianceScreen();
                },
                const Color(0xFFEFF1FD),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Event E-Pass Bulk Generator',
                Icons.add,
                isTabletOrWeb,
                () {
                  Get.find<MainController>().othersEpassGenerator();
                },
                const Color(0xFFF0F6FF),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(String title, IconData icon, bool isTabletOrWeb,
      VoidCallback ontap, Color bgColor) {
    MainController mainController = Get.find();
    final isDarkMode = mainController.isDarkMode.value;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? adminAppColors.darkSecondaryBackground : bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isDarkMode
                  ? adminAppColors.secondary
                  : adminAppColors.primary,
              width: getBorderWidth(context)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  color: isDarkMode ? Colors.white : Colors.black87,
                  fontSize: isTabletOrWeb ? 18 : 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Icon(icon,
                size: isTabletOrWeb ? 30 : 24,
                color: isDarkMode ? Colors.white : Colors.black87),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsSection() {
    MainController mainController = Get.find();
    final isDarkMode = mainController.isDarkMode.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isDarkMode
                ? adminAppColors.darkMainBackground
                : adminAppColors.background,
            border: Border.all(
                color: isDarkMode
                    ? adminAppColors.secondary
                    : adminAppColors.primary,
                width: getBorderWidth(context)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Check-In Form Advanced Options"),
              SizedBox(
                width: 15,
              ),
              _buildToggleOption('Need a mobile number with OTP?', true),
              SizedBox(
                width: 12,
              ),
              _buildToggleOption('Is it necessary to keep ID proof?', false),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isDarkMode
                ? adminAppColors.darkMainBackground
                : adminAppColors.background,
            border: Border.all(
                color: isDarkMode
                    ? adminAppColors.secondary
                    : adminAppColors.primary,
                width: getBorderWidth(context)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Safety and Health Compliance"),
              _buildToggleOption('Do you want to see Compliances ?', true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    MainController mainController = Get.find();
    final isDarkMode = mainController.isDarkMode.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black)),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildToggleOption(String title, bool value) {
    MainController mainController = Get.find();
    final isDarkMode = mainController.isDarkMode.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(title,
                style: GoogleFonts.lexend(
                    fontSize: 14,
                    color: isDarkMode ? Colors.white : Colors.black))),
        Switch(
            value: value, onChanged: (_) {}, activeColor: Colors.blue.shade600),
      ],
    );
  }

  Widget _buildBulkUploadSection() {
    MainController mainController = Get.find();
    final isDarkMode = mainController.isDarkMode.value;
    return Obx(() {
      final fileName = controller.file.value?.path.split('/').last ?? '';

      final filePickerBox = Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode
              ? adminAppColors.darkSecondaryBackground
              : adminAppColors.mainBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: controller.file.value == null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined,
                      color: Colors.blue, size: 40),
                  SizedBox(width: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Drag your file(s) or ',
                            style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w400,
                                fontSize: getTextSize(context),
                                color:
                                    isDarkMode ? Colors.white : Colors.black)),
                        TextSpan(
                          text: 'browse',
                          style: GoogleFonts.lexend(
                              fontSize: getTextSize(context),
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '  Max 10 MB Files are allowed',
                          style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w300,
                              fontSize: getTextSize(context),
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.white : Colors.black54),
                  ),
                ],
              )
            : Text('File selected: $fileName',
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
      );

      final uploadBox = DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: const Radius.circular(8),
          color: isDarkMode ? adminAppColors.secondary : adminAppColors.primary,
          strokeWidth: getBorderWidth(context),
          dashPattern: const [6, 6],
        ),
        child: InkWell(
          onTap: controller.pickFile,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 60),
            child: filePickerBox,
          ),
        ),
      );

      final innerContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bulk Upload (CSV/Excel)',
            style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 20),
          kIsWeb
              ? DropTarget(
                  onDragDone: (detail) {
                    if (detail.files.isNotEmpty) {
                      controller.onFileDrop(detail.files.first.path);
                    }
                  },
                  onDragEntered: (_) => controller.dragging.value = true,
                  onDragExited: (_) => controller.dragging.value = false,
                  child: uploadBox,
                )
              : uploadBox,
          const SizedBox(height: 8),
          Text(
            'Only support .csv, .xlsx and .xls files',
            style: GoogleFonts.lexend(fontSize: 12, color: Colors.grey),
          ),
        ],
      );

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
              color: isDarkMode
                  ? adminAppColors.secondary
                  : adminAppColors.primary,
              width: getBorderWidth(context)),
          color: controller.dragging.value
              ? Colors.blue.withOpacity(0.1)
              : isDarkMode
                  ? adminAppColors.darkMainBackground
                  : adminAppColors.background,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: innerContent,
      );
    });
  }
}
