import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/routes/app_routes.dart';
import 'package:synctrackr/core/constants/app_assets.dart';
import 'package:synctrackr/core/constants/app_colors.dart';

class ManualCheckOutScreen extends StatefulWidget {
  const ManualCheckOutScreen({super.key});

  @override
  State<ManualCheckOutScreen> createState() => _ManualCheckOutScreenState();
}

class _ManualCheckOutScreenState extends State<ManualCheckOutScreen> {
  Timer? _autoExitTimer;
  int _remainingSeconds = 5;

  @override
  void initState() {
    super.initState();
    _startAutoExitCountdown();
  }

  void _startAutoExitCountdown() {
    _autoExitTimer?.cancel();
    _autoExitTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        }
        if (_remainingSeconds == 0) {
          _autoExitTimer?.cancel();
          // Navigate back to main screen - binding will handle controller recreation
           Get.offNamed(adminAppRoutes.main);
          // Get.until((route)=> Get.currentRoute == adminAppRoutes.main);
        }
      });
    });
  }

  @override
  void dispose() {
    _autoExitTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final args = Get.arguments as Map<String, dynamic>?;
    final message = args?['message']?.toString() ?? 'Checked Out';
    final isCheckIn = args?['isCheckIn'] == true;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0A0F1E) : const Color(0xFFF5F9FF),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.backgroundWave,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
              // color: isDark ? Colors.black.withOpacity(0.3) : null,
              // colorBlendMode: isDark ? BlendMode.darken : null,
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: 646,
                  height: 650,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.black.withOpacity(0.4)
                        : Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color:
                          isDark ? Colors.white : Colors.white.withOpacity(0.6),
                      width: 4,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        // 'assets/images/logo.png',
                        isDark ? AppAssets.logoDark : AppAssets.logo,
                        width: 300,
                        height: 152,
                        // color: isDark ? Colors.white : null,
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message,
                            style: GoogleFonts.poppins(
                              color: Colors.green[600],
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            isCheckIn
                                ? "Successfully checked in"
                                : "Successfully checked out",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? const Color(0xffF1FFE5)
                              : const Color(0xFFF4FFEC),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF43B000),
                                // color: isDark
                                //     ? Color(0xffF1FFE5)
                                //     : Color(0xFF43B000),
                                width: 3,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                size: 42,
                                color: Color(0xFF43B000),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _autoExitTimer?.cancel();
                            // Navigate back to main screen - binding will handle controller recreation
                            Get.offNamed(adminAppRoutes.main);
                            // Get.until((route)=> Get.currentRoute == adminAppRoutes.main);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark
                                ? AppColors.darkPrimaryBlue
                                : const Color(0xFF3B82F6),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Exit "),
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
                        "Automatic Exit in $_remainingSeconds Seconds",
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ],
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
