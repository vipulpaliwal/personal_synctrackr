// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:camera/camera.dart';
// import 'package:synctrackr/core/constants/app_assets.dart';
// import '../../../../core/routes/app_routes.dart';

// class UploadPhotoScreen extends StatefulWidget {
//   const UploadPhotoScreen({super.key});

//   @override
//   State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
// }

// class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
//   CameraController? _cameraController;
//   List<CameraDescription> _cameras = [];
//   XFile? _capturedImage;
//   bool _isCameraInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     initCamera();
//   }

//   Future<void> initCamera() async {
//     try {
//       _cameras = await availableCameras();
//       final frontCamera = _cameras.firstWhere(
//         (camera) => camera.lensDirection == CameraLensDirection.front,
//         orElse: () => _cameras.first,
//       );
//       _cameraController = CameraController(
//         frontCamera,
//         ResolutionPreset.medium,
//         enableAudio: false,
//       );
//       await _cameraController!.initialize();
//       if (mounted) {
//         setState(() => _isCameraInitialized = true);
//       }
//     } catch (e) {
//       debugPrint("Camera Error: $e");
//     }
//   }

//   Future<void> capturePhoto() async {
//     if (!_cameraController!.value.isInitialized) return;
//     try {
//       final image = await _cameraController!.takePicture();
//       setState(() {
//         _capturedImage = image;
//       });
//     } catch (e) {
//       debugPrint("Capture Error: $e");
//     }
//   }

//   void _retryCapture() async {
//     setState(() {
//       _capturedImage = null;
//       _isCameraInitialized = false;
//     });
//     await initCamera();
//   }

//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

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
//               // padding: const EdgeInsets.all(16),
//               padding: MediaQuery.of(context).size.width > 600
//                   ? const EdgeInsets.all(16)
//                   : EdgeInsets.zero,
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 750),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(25),
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.4),
//                         borderRadius: BorderRadius.circular(25),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.6),
//                           width: 3,
//                         ),
//                       ),
//                       child: LayoutBuilder(
//                         builder: (context, constraints) {
//                           final isWide = constraints.maxWidth > 600;
//                           final imageSize =
//                               isWide ? 280.0 : screenSize.width * 0.6;

//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Center(
//                                 child: Image.asset(
//                                   'assets/images/logo.png',
//                                   width: isWide ? 240 : 180,
//                                   height: isWide ? 120 : 90,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               Text.rich(
//                                 TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: "Your ",
//                                       style: TextStyle(
//                                         fontSize: isWide ? 36 : 28,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text: "Photo",
//                                       style: TextStyle(
//                                         fontSize: isWide ? 36 : 28,
//                                         fontWeight: FontWeight.w600,
//                                         color: const Color(0xFF3B82F6),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 "Click Selfie & Upload Your Photo",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: isWide ? 18 : 16,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               Center(
//                                 child: Container(
//                                   width: imageSize,
//                                   height: imageSize,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: Colors.blue,
//                                       width: 4,
//                                     ),
//                                   ),
//                                   child: ClipOval(
//                                     child: _capturedImage != null
//                                         ? (kIsWeb
//                                             ? Image.network(
//                                                 _capturedImage!.path,
//                                                 fit: BoxFit.cover,
//                                               )
//                                             : Image.file(
//                                                 File(_capturedImage!.path),
//                                                 fit: BoxFit.cover,
//                                               ))
//                                         : _isCameraInitialized
//                                             ? CameraPreview(_cameraController!)
//                                             : const Center(
//                                                 child:
//                                                     CircularProgressIndicator()),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 20),

//                               /// Buttons Row
//                               _buildButtonsRow(),
//                             ],
//                           );
//                         },
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

//   Widget _buildButtonsRow() {
//     return Row(
//       children: [
//         Expanded(
//           flex: 1,
//           child: ElevatedButton(
//             onPressed: _capturedImage == null ? capturePhoto : _retryCapture,
//             style: ElevatedButton.styleFrom(
//               backgroundColor:
//                   _capturedImage == null ? Colors.blue : Colors.red[100],
//               foregroundColor:
//                   _capturedImage == null ? Colors.white : Colors.red,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 side: _capturedImage == null
//                     ? BorderSide.none
//                     : const BorderSide(color: Colors.red),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(_capturedImage == null ? "Click Photo" : "Retry"),
//                 const SizedBox(width: 6),
//                 Icon(
//                   _capturedImage == null ? Icons.camera_alt : Icons.refresh,
//                   size: 20,
//                   color: _capturedImage == null ? Colors.white : Colors.red,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           flex: 3,
//           child: ElevatedButton(
//             onPressed: () => Get.toNamed(AppRoutes.compliance),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Save & Next"),
//                 SizedBox(width: 6),
//                 Icon(Icons.arrow_forward, size: 20, color: Colors.white),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:synctrackr/core/constants/app_assets.dart';
import 'package:synctrackr/core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  XFile? _capturedImage;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      _cameras = await availableCameras();
      final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first,
      );
      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      if (mounted) {
        setState(() => _isCameraInitialized = true);
      }
    } catch (e) {
      debugPrint("Camera Error: $e");
    }
  }

  Future<void> capturePhoto() async {
    if (!_cameraController!.value.isInitialized) return;
    try {
      final image = await _cameraController!.takePicture();
      setState(() {
        _capturedImage = image;
      });
    } catch (e) {
      debugPrint("Capture Error: $e");
    }
  }

  void _retryCapture() async {
    setState(() {
      _capturedImage = null;
      _isCameraInitialized = false;
    });
    await initCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F9FF),
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
              padding: MediaQuery.of(context).size.width > 600
                  ? const EdgeInsets.all(16)
                  : EdgeInsets.zero,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 750),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        // color: Colors.white.withOpacity(0.4),
                        color: isDark
                            ? Colors.black.withOpacity(0.4)
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          // color: Colors.white.withOpacity(0.6),
                          color: isDark
                              ? Colors.white
                              : Colors.white.withOpacity(0.6),
                          width: 3,
                        ),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 600;
                          final imageSize =
                              isWide ? 280.0 : screenSize.width * 0.6;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  isDark ? AppAssets.logoDark : AppAssets.logo,
                                  width: isWide ? 240 : 180,
                                  height: isWide ? 120 : 90,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Your ",
                                      style: TextStyle(
                                          fontSize: isWide ? 36 : 28,
                                          fontWeight: FontWeight.w600,
                                          // color: Colors.black87,
                                          color: isDark
                                              ? AppColors.background
                                              : AppColors.darkBackground),
                                    ),
                                    TextSpan(
                                      text: "Photo",
                                      style: TextStyle(
                                          fontSize: isWide ? 36 : 28,
                                          fontWeight: FontWeight.w600,
                                          // color: const Color(0xFF3B82F6),
                                          color: isDark
                                              ? AppColors.darkPrimaryBlue
                                              : AppColors.primaryBlue),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Click Selfie & Upload Your Photo",
                                style: GoogleFonts.poppins(
                                    fontSize: isWide ? 18 : 16,
                                    // color: Colors.black87,
                                    color: isDark
                                        ? AppColors.background
                                        : AppColors.darkAdmin),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Container(
                                  width: imageSize,
                                  height: imageSize,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      // color: Colors.blue,
                                      color: isDark
                                          ? AppColors.darkPrimaryBlue
                                          : AppColors.primaryBlue,
                                      width: 4,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: _capturedImage != null
                                        ? (kIsWeb
                                            ? Image.network(
                                                _capturedImage!.path,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(_capturedImage!.path),
                                                fit: BoxFit.cover,
                                              ))
                                        : _isCameraInitialized
                                            ? CameraPreview(_cameraController!)
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              /// Buttons Row
                              _buildButtonsRow(),
                            ],
                          );
                        },
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

  Widget _buildButtonsRow() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;

        // Responsive ratios
        final isMobile = totalWidth < 400;
        final retryBtnWidth = isMobile ? totalWidth * 0.35 : totalWidth * 0.25;
        final saveBtnWidth = isMobile ? totalWidth * 0.61 : totalWidth * 0.70;

        return Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: retryBtnWidth,
              child: ElevatedButton(
                onPressed:
                    _capturedImage == null ? capturePhoto : _retryCapture,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(isMobile ? 48 : 52),
                  backgroundColor: _capturedImage == null
                      ? isDark
                          ? AppColors.darkPrimaryBlue
                          : AppColors.primaryBlue
                      : Colors.red[100],
                  foregroundColor:
                      _capturedImage == null ? Colors.white : Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: _capturedImage == null
                        ? BorderSide.none
                        : const BorderSide(color: Colors.red),
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_capturedImage == null ? "Capture" : "Retry"),
                      const SizedBox(width: 4),
                      Icon(
                        _capturedImage == null
                            ? Icons.camera_alt
                            : Icons.refresh,
                        size: 20,
                        color:
                            _capturedImage == null ? Colors.white : Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: saveBtnWidth,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.compliance),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(isMobile ? 48 : 52),
                  backgroundColor: isDark
                      ? AppColors.darkPrimaryBlue
                      : AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Save & Next"),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 20, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
