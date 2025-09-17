import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/core/constants/app_assets.dart';
import 'package:synctrackr/core/constants/app_barrels.dart';
import 'package:synctrackr/core/widgets/custom_checkbox.dart';
import 'package:synctrackr/core/widgets/primary_btn.dart';
import '../../../../core/routes/app_routes.dart';

class ComplianceScreen extends StatefulWidget {
  const ComplianceScreen({super.key});

  @override
  State<ComplianceScreen> createState() => _ComplianceScreenState();
}

class _ComplianceScreenState extends State<ComplianceScreen> {
  final List<String> questions = [
    "Have you experienced any COVID-19 symptoms (e.g., fever, cough, new loss of taste/smell) in the last 5 days, or tested positive for COVID-19 in the last 5 days, or been in close contact with someone confirmed to have COVID-19 in the last 5 days?",
    "Are you prepared to wear a well-fitting face mask (covering nose and mouth) throughout your visit, especially in indoor common areas?",
    "Will you use hand sanitizer or wash your hands thoroughly upon entry and regularly throughout your visit?",
    "Are you able to maintain at least 6 feet (2 meters) of physical distance from others not in your immediate visiting party?",
    "Will you immediately notify staff if you develop any COVID-19 symptoms during your visit?",
    "Are you fully vaccinated and, if applicable, boosted against COVID-19 as per current health authority recommendations?",
    "Will you consciously avoid touching your eyes, nose, and mouth during your visit?",
  ];

  final Map<int, String> answers = {};
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0D1B2A) : const Color(0xFFF5F9FF),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.backgroundWave,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: isMobile ? screenSize.width * 1 : 700,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color:
                          isDark ? Colors.white : Colors.white.withOpacity(0.6),
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
                            width: 180,
                            height: 90,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Title
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Safety ",
                                style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    // color: const Color(0xFF3B82F6),
                                    color: isDark
                                        ? AppColors.darkPrimaryBlue
                                        : AppColors.darkBackground),
                              ),
                              TextSpan(
                                text: "Compliance",
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),

                        // Subtitle
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "COVID-19  ",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    // color: const Color(0xFF3B82F6),
                                    color: isDark
                                        ? AppColors.darkPrimaryBlue
                                        : AppColors.darkBackground),
                              ),
                              TextSpan(
                                text: "Health & Safety Compliance",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Questions
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: questions.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${index + 1}. ${questions[index]}",
                                      style: GoogleFonts.poppins(
                                        fontSize: isMobile ? 11 : 13,
                                        color: isDark
                                            ? Colors.white.withOpacity(0.9)
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      // No Option
                                      Column(
                                        children: [
                                          Text("No",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: isDark
                                                      ? Colors.white70
                                                      : Colors.black)),
                                          Radio<String>(
                                            value: "No",
                                            fillColor: WidgetStateProperty
                                                .resolveWith((states) {
                                              if (states.contains(
                                                  WidgetState.selected)) {
                                                // return Colors.blue;
                                                return isDark
                                                    ? AppColors.darkPrimaryBlue
                                                    : AppColors.primaryBlue;
                                              }
                                              return isDark
                                                  ? AppColors.darkPrimaryBlue
                                                  : Colors.black;
                                            }),
                                            groupValue: answers[index],
                                            onChanged: (value) {
                                              setState(() {
                                                answers[index] = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),

                                      // Yes Option
                                      Column(
                                        children: [
                                          Text("Yes",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: isDark
                                                      ? Colors.white70
                                                      : Colors.black)),
                                          Radio<String>(
                                            value: "Yes",
                                            fillColor: WidgetStateProperty
                                                .resolveWith((states) {
                                              if (states.contains(
                                                  WidgetState.selected)) {
                                                // return AppColors.primaryBlue;
                                                return isDark
                                                    ? AppColors.darkPrimaryBlue
                                                    : AppColors.primaryBlue;
                                              }
                                              // return isDark
                                              //     ? Colors.white70
                                              //     : Colors.black;
                                              return isDark
                                                  ? AppColors.darkPrimaryBlue
                                                  : Colors.black;
                                            }),
                                            groupValue: answers[index],
                                            onChanged: (value) {
                                              setState(() {
                                                answers[index] = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),

                        // Terms & Conditions
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCheckbox(
                              value: agreed,
                              onChanged: (val) {
                                setState(() {
                                  agreed = val;
                                });
                              },
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "I agree to the ",
                                      style: GoogleFonts.poppins(
                                        color: isDark
                                            ? AppColors.primaryBlue
                                            : Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Terms & conditions",
                                      style: GoogleFonts.poppins(
                                        color: isDark
                                            ? AppColors.darkPrimaryBlue
                                            : Colors.blue,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        PrimaryButton(
                          text: "Save & Next",
                          fontSize: isMobile ? 14 : 16,
                          onPressed: () {
                            Get.toNamed(AppRoutes.signature);
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
      ),
    );
  }
}
