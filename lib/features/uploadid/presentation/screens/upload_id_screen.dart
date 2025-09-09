// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/foundation.dart';
// import 'package:synctrackr/core/constants/app_assets.dart';

// import '../../../../core/routes/app_routes.dart';

// class UploadIdScreen extends StatefulWidget {
//   const UploadIdScreen({super.key});

//   @override
//   State<UploadIdScreen> createState() => _UploadIdScreenState();
// }

// class _UploadIdScreenState extends State<UploadIdScreen> {
//   String? selectedProof;
//   final TextEditingController idController = TextEditingController();

//   CameraController? _cameraController;
//   List<CameraDescription>? _cameras;
//   XFile? _capturedImage;
//   bool _isCameraInitialized = false;

//   Future<void> _initializeCamera() async {
//     try {
//       _cameras = await availableCameras();
//       final frontCamera = _cameras!.firstWhere(
//         (camera) => camera.lensDirection == CameraLensDirection.front,
//         orElse: () => _cameras!.first,
//       );

//       _cameraController = CameraController(
//         frontCamera,
//         ResolutionPreset.medium,
//         enableAudio: false,
//       );

//       await _cameraController!.initialize();
//       setState(() {
//         _isCameraInitialized = true;
//       });
//     } catch (e) {
//       print("Camera init error: $e");
//     }
//   }

//   Future<void> _captureImage() async {
//     if (_cameraController != null && _cameraController!.value.isInitialized) {
//       final image = await _cameraController!.takePicture();
//       setState(() {
//         _capturedImage = image;
//       });
//     }
//   }

//   void _retryCapture() async {
//     setState(() {
//       _capturedImage = null;
//       _isCameraInitialized = false;
//     });
//     await _initializeCamera();
//   }

//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final bool isSmallScreen = screenWidth < 600;

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
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxWidth: 700,
//                     maxHeight: screenHeight * 0.95,
//                   ),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.4),
//                       borderRadius: BorderRadius.circular(25),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.6),
//                         width: 4,
//                       ),
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       vertical: isSmallScreen ? 20 : 40,
//                       horizontal: isSmallScreen ? 16 : 24,
//                     ),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Image.asset(
//                               'assets/images/logo.png',
//                               width: isSmallScreen ? 160 : 200,
//                               height: isSmallScreen ? 80 : 100,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Icon(
//                                   Icons.image,
//                                   size: 80,
//                                   color: Colors.grey,
//                                 );
//                               },
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           Text(
//                             "ID Proof",
//                             style: GoogleFonts.poppins(
//                               fontSize: isSmallScreen ? 26 : 36,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             "Click & Upload your ID Proof",
//                             style: GoogleFonts.poppins(
//                               fontSize: isSmallScreen ? 16 : 20,
//                               height: 1.6,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//                           DropdownButtonFormField<String>(
//                             value: selectedProof,
//                             decoration: InputDecoration(
//                               hintText: "Select ID Proof",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 14,
//                                 vertical: 12,
//                               ),
//                             ),
//                             items:
//                                 ["Passport", "Driving License", "Aadhar Card"]
//                                     .map(
//                                       (proof) => DropdownMenuItem(
//                                         value: proof,
//                                         child: Text(proof),
//                                       ),
//                                     )
//                                     .toList(),
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedProof = value;
//                               });
//                             },
//                           ),
//                           const SizedBox(height: 20),
//                           TextField(
//                             controller: idController,
//                             decoration: InputDecoration(
//                               hintText: "Enter ID no.",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 14,
//                                 vertical: 12,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 24),

//                           // Camera container
//                           SizedBox(
//                             height: isSmallScreen ? 200 : 250,
//                             width: double.infinity,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[200],
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               clipBehavior: Clip.antiAlias,
//                               child: _capturedImage != null
//                                   ? kIsWeb
//                                       ? Image.network(
//                                           _capturedImage!.path,
//                                           fit: BoxFit.cover,
//                                           width: double.infinity,
//                                           height: double.infinity,
//                                         )
//                                       : Image.file(
//                                           File(_capturedImage!.path),
//                                           fit: BoxFit.cover,
//                                           width: double.infinity,
//                                           height: double.infinity,
//                                         )
//                                   : _isCameraInitialized
//                                       ? Stack(
//                                           children: [
//                                             Positioned.fill(
//                                               child: CameraPreview(
//                                                   _cameraController!),
//                                             ),
//                                             Positioned(
//                                               bottom: 16,
//                                               right: 16,
//                                               child: ElevatedButton.icon(
//                                                 onPressed: _captureImage,
//                                                 icon: const Icon(
//                                                     Icons.camera_alt),
//                                                 label: const Text("Capture"),
//                                                 style: ElevatedButton.styleFrom(
//                                                   backgroundColor:
//                                                       Colors.black54,
//                                                   foregroundColor: Colors.white,
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       : Center(
//                                           child: ElevatedButton.icon(
//                                             onPressed: _initializeCamera,
//                                             icon: const Icon(Icons.camera),
//                                             label: const Text("Open Camera"),
//                                           ),
//                                         ),
//                             ),
//                           ),

//                           const SizedBox(height: 20),
//                           Row(
//                             children: [
//                               Expanded(
//                                 flex: 2,
//                                 child: SizedBox(
//                                   height: 50,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.red[100],
//                                       foregroundColor: Colors.red,
//                                       shape: RoundedRectangleBorder(
//                                         side: const BorderSide(
//                                           color: Colors.red,
//                                           width: 1.5,
//                                         ),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                     ),
//                                     onPressed: _retryCapture,
//                                     child: FittedBox(
//                                       fit: BoxFit.scaleDown,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: const [
//                                           Text("Retry"),
//                                           SizedBox(width: 6),
//                                           Icon(Icons.refresh, size: 20),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 flex: 5,
//                                 child: SizedBox(
//                                   height: 50,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.blue,
//                                       foregroundColor: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       // Save & Next logic here
//                                       Get.toNamed(AppRoutes.meetingwith);
//                                     },
//                                     child: FittedBox(
//                                       fit: BoxFit.scaleDown,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: const [
//                                           Text("Save & Next"),
//                                           SizedBox(width: 6),
//                                           Icon(
//                                             Icons.arrow_forward,
//                                             size: 18,
//                                             color: Colors.white,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/foundation.dart';
// import 'package:synctrackr/core/constants/app_assets.dart';

// import '../../../../core/routes/app_routes.dart';

// class UploadIdScreen extends StatefulWidget {
//   const UploadIdScreen({super.key});

//   @override
//   State<UploadIdScreen> createState() => _UploadIdScreenState();
// }

// class _UploadIdScreenState extends State<UploadIdScreen> {
//   String? selectedProof;
//   final TextEditingController idController = TextEditingController();

//   CameraController? _cameraController;
//   List<CameraDescription>? _cameras;
//   XFile? _capturedImage;
//   bool _isCameraInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     try {
//       _cameras = await availableCameras();
//       final frontCamera = _cameras!.firstWhere(
//         (camera) => camera.lensDirection == CameraLensDirection.front,
//         orElse: () => _cameras!.first,
//       );

//       _cameraController = CameraController(
//         frontCamera,
//         ResolutionPreset.medium,
//         enableAudio: false,
//       );

//       await _cameraController!.initialize();
//       setState(() {
//         _isCameraInitialized = true;
//       });
//     } catch (e) {
//       print("Camera init error: $e");
//     }
//   }

//   Future<void> _captureImage() async {
//     if (_cameraController != null && _cameraController!.value.isInitialized) {
//       final image = await _cameraController!.takePicture();
//       setState(() {
//         _capturedImage = image;
//       });
//     }
//   }

//   void _retryCapture() async {
//     setState(() {
//       _capturedImage = null;
//       _isCameraInitialized = false;
//     });
//     await _initializeCamera();
//   }

//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final bool isSmallScreen = screenWidth < 600;

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
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxWidth: 700,
//                     maxHeight: screenHeight * 0.95,
//                   ),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.4),
//                       borderRadius: BorderRadius.circular(25),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.6),
//                         width: 4,
//                       ),
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       vertical: isSmallScreen ? 20 : 40,
//                       horizontal: isSmallScreen ? 16 : 24,
//                     ),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Image.asset(
//                               'assets/images/logo.png',
//                               width: isSmallScreen ? 160 : 200,
//                               height: isSmallScreen ? 80 : 100,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Icon(
//                                   Icons.image,
//                                   size: 80,
//                                   color: Colors.grey,
//                                 );
//                               },
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           Text(
//                             "ID Proof",
//                             style: GoogleFonts.poppins(
//                               fontSize: isSmallScreen ? 26 : 36,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             "Click & Upload your ID Proof",
//                             style: GoogleFonts.poppins(
//                               fontSize: isSmallScreen ? 16 : 20,
//                               height: 1.6,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//                           DropdownButtonFormField<String>(
//                             value: selectedProof,
//                             decoration: InputDecoration(
//                               hintText: "Select ID Proof",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 14,
//                                 vertical: 12,
//                               ),
//                             ),
//                             items:
//                                 ["Passport", "Driving License", "Aadhar Card"]
//                                     .map(
//                                       (proof) => DropdownMenuItem(
//                                         value: proof,
//                                         child: Text(proof),
//                                       ),
//                                     )
//                                     .toList(),
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedProof = value;
//                               });
//                             },
//                           ),
//                           const SizedBox(height: 20),
//                           TextField(
//                             controller: idController,
//                             decoration: InputDecoration(
//                               hintText: "Enter ID no.",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 14,
//                                 vertical: 12,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 24),

//                           // Camera container
//                           SizedBox(
//                             height: isSmallScreen ? 200 : 250,
//                             width: double.infinity,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[200],
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               clipBehavior: Clip.antiAlias,
//                               child: _capturedImage != null
//                                   ? kIsWeb
//                                       ? Image.network(
//                                           _capturedImage!.path,
//                                           fit: BoxFit.cover,
//                                           width: double.infinity,
//                                           height: double.infinity,
//                                         )
//                                       : Image.file(
//                                           File(_capturedImage!.path),
//                                           fit: BoxFit.cover,
//                                           width: double.infinity,
//                                           height: double.infinity,
//                                         )
//                                   : _isCameraInitialized
//                                       ? CameraPreview(_cameraController!)
//                                       : const Center(
//                                           child: CircularProgressIndicator(),
//                                         ),
//                             ),
//                           ),

//                           const SizedBox(height: 20),
//                           Row(
//                             children: [
//                               Expanded(
//                                 flex: 2,
//                                 child: SizedBox(
//                                   height: 50,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: _capturedImage == null
//                                           ? Colors.blue
//                                           : Colors.red[100],
//                                       foregroundColor: _capturedImage == null
//                                           ? Colors.white
//                                           : Colors.red,
//                                       shape: RoundedRectangleBorder(
//                                         side: _capturedImage == null
//                                             ? BorderSide.none
//                                             : const BorderSide(
//                                                 color: Colors.red,
//                                                 width: 1.5,
//                                               ),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                     ),
//                                     onPressed: _capturedImage == null
//                                         ? _captureImage
//                                         : _retryCapture,
//                                     child: FittedBox(
//                                       fit: BoxFit.scaleDown,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(_capturedImage == null
//                                               ? "Capture"
//                                               : "Retry"),
//                                           const SizedBox(width: 6),
//                                           Icon(
//                                             _capturedImage == null
//                                                 ? Icons.camera_alt
//                                                 : Icons.refresh,
//                                             size: 20,
//                                             color: _capturedImage == null
//                                                 ? Colors.white
//                                                 : Colors.red,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 flex: 5,
//                                 child: SizedBox(
//                                   height: 50,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.blue,
//                                       foregroundColor: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       // Save & Next logic here
//                                       Get.toNamed(AppRoutes.meetingwith);
//                                     },
//                                     child: FittedBox(
//                                       fit: BoxFit.scaleDown,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: const [
//                                           Text("Save & Next"),
//                                           SizedBox(width: 6),
//                                           Icon(
//                                             Icons.arrow_forward,
//                                             size: 18,
//                                             color: Colors.white,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:synctrackr/core/constants/app_assets.dart';
import 'package:synctrackr/core/constants/app_colors.dart';

import '../../../../core/routes/app_routes.dart';

class UploadIdScreen extends StatefulWidget {
  const UploadIdScreen({super.key});

  @override
  State<UploadIdScreen> createState() => _UploadIdScreenState();
}

class _UploadIdScreenState extends State<UploadIdScreen> {
  String? selectedProof;
  final TextEditingController idController = TextEditingController();

  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  XFile? _capturedImage;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      final frontCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print("Camera init error: $e");
    }
  }

  Future<void> _captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      final image = await _cameraController!.takePicture();
      setState(() {
        _capturedImage = image;
      });
    }
  }

  void _retryCapture() async {
    setState(() {
      _capturedImage = null;
      _isCameraInitialized = false;
    });
    await _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isSmallScreen = screenWidth < 600;

    return Scaffold(
      // backgroundColor: isDark ? Colors.black : const Color(0xFFF5F9FF),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.backgroundWave,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
              // color: isDark ? Colors.black.withOpacity(0.7) : null,
              // colorBlendMode: isDark ? BlendMode.darken : null,
            ),
          ),
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 700,
                    maxHeight: screenHeight * 0.95,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.black.withOpacity(0.6)
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isDark
                            ? Colors.white
                            : Colors.white.withOpacity(0.6),
                        width: 2,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: isSmallScreen ? 20 : 40,
                      horizontal: isSmallScreen ? 16 : 24,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              isDark ? AppAssets.logoDark : AppAssets.logo,
                              width: isSmallScreen ? 180 : 300,
                              height: isSmallScreen ? 90 : 152,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "ID Proof",
                            style: GoogleFonts.poppins(
                              fontSize: isSmallScreen ? 26 : 36,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Click & Upload your ID Proof",
                            style: GoogleFonts.poppins(
                              fontSize: isSmallScreen ? 16 : 20,
                              height: 1.6,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // DropdownButtonFormField<String>(
                          //   dropdownColor:
                          //       isDark ? Colors.black87 : Colors.white,
                          //   value: selectedProof,
                          //   decoration: InputDecoration(
                          //     hintText: "Select ID Proof",
                          //     hintStyle: TextStyle(
                          //       color: isDark ? Colors.white70 : Colors.black54,
                          //     ),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(12),
                          //     ),
                          //     filled: true,
                          //     fillColor: isDark ? Colors.black54 : Colors.white,
                          //     contentPadding: const EdgeInsets.symmetric(
                          //       horizontal: 14,
                          //       vertical: 12,
                          //     ),
                          //   ),
                          //   items:
                          //       ["Passport", "Driving License", "Aadhar Card"]
                          //           .map(
                          //             (proof) => DropdownMenuItem(
                          //               value: proof,
                          //               child: Text(
                          //                 proof,
                          //                 style: TextStyle(
                          //                   color: isDark
                          //                       ? Colors.white
                          //                       : Colors.black87,
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //           .toList(),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedProof = value;
                          //     });
                          //   },
                          // ),
                          // const SizedBox(height: 20),
                          // TextField(
                          //   controller: idController,
                          //   style: TextStyle(
                          //       color: isDark ? Colors.white : Colors.black87),
                          //   decoration: InputDecoration(
                          //     hintText: "Enter ID no.",
                          //     hintStyle: TextStyle(
                          //       color: isDark ? Colors.white70 : Colors.black54,
                          //     ),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(12),
                          //       borderSide: BorderSide(
                          //         color: isDark
                          //             ? AppColors.primaryBlue
                          //             : Colors.black,
                          //       ),
                          //     ),
                          //     filled: true,
                          //     fillColor: isDark ? Colors.black54 : Colors.white,
                          //     contentPadding: const EdgeInsets.symmetric(
                          //       horizontal: 14,
                          //       vertical: 12,
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(height: 24),
                          DropdownButtonFormField<String>(
                            dropdownColor:
                                isDark ? Colors.black87 : Colors.white,
                            value: selectedProof,
                            decoration: InputDecoration(
                              // hintText: "Select ID Proof",
                              // hintStyle: TextStyle(
                              //   color: isDark
                              //       ? AppColors.primaryBlue
                              //       : Colors.black54,
                              // ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? AppColors.primaryBlue
                                      : Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? AppColors.primaryBlue
                                      : Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? AppColors.primaryBlue
                                      : Colors.black,
                                  width: 1.5,
                                ),
                              ),
                              filled: true,
                              fillColor: isDark ? Colors.black54 : Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                            ),
                            hint: Text(
                              // 👈 yaha style apply hoga
                              "Select ID Proof",
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.primaryBlue
                                    : Colors.black54,
                              ),
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.primaryBlue,
                            ),
                            items:
                                ["Passport", "Driving License", "Aadhar Card"]
                                    .map(
                                      (proof) => DropdownMenuItem(
                                        value: proof,
                                        child: Text(
                                          proof,
                                          style: TextStyle(
                                            color: isDark
                                                ? AppColors.primaryBlue
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedProof = value;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          TextField(
                            controller: idController,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText: "Enter ID no.",
                              hintStyle: TextStyle(
                                color: isDark
                                    ? AppColors.primaryBlue
                                    : Colors.black54,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? AppColors.primaryBlue
                                      : Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? AppColors.primaryBlue
                                      : Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? AppColors.primaryBlue
                                      : Colors.black,
                                  width: 1.5,
                                ),
                              ),
                              filled: true,
                              fillColor: isDark ? Colors.black54 : Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),

                          // Camera container
                          SizedBox(
                            height: isSmallScreen ? 200 : 250,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    isDark ? Colors.white10 : Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: _capturedImage != null
                                  ? kIsWeb
                                      ? Image.network(
                                          _capturedImage!.path,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                      : Image.file(
                                          File(_capturedImage!.path),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                  : _isCameraInitialized
                                      ? CameraPreview(_cameraController!)
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _capturedImage == null
                                          // ? AppColors.darkPrimaryBlue
                                          ? isDark
                                              ? AppColors.darkPrimaryBlue
                                              : AppColors.primaryBlue
                                          : Colors.red[100],
                                      foregroundColor: _capturedImage == null
                                          ? Colors.white
                                          : Colors.red,
                                      shape: RoundedRectangleBorder(
                                        side: _capturedImage == null
                                            ? BorderSide.none
                                            : const BorderSide(
                                                color: Colors.red,
                                                width: 1.5,
                                              ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: _capturedImage == null
                                        ? _captureImage
                                        : _retryCapture,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(_capturedImage == null
                                              ? "Capture"
                                              : "Retry"),
                                          const SizedBox(width: 6),
                                          Icon(
                                            _capturedImage == null
                                                ? Icons.camera_alt
                                                : Icons.refresh,
                                            size: 20,
                                            color: _capturedImage == null
                                                ? Colors.white
                                                : Colors.red,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isDark
                                          ? AppColors.darkPrimaryBlue
                                          : AppColors.primaryBlue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.meetingwith);
                                    },
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text("Save & Next"),
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
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
