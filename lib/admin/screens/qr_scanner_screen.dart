import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:synctrackr/admin/routes/app_routes.dart';
import 'package:synctrackr/admin/services/api_services.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  String? scannedData;
  bool isScanning = true;
  final MobileScannerController controller = MobileScannerController();
  final ApiService _apiService = ApiService();
  String? _visitorStatus;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (!isScanning) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? rawValue = barcodes.first.rawValue;

      if (rawValue != null) {
        controller.stop();
        isScanning = false;

        try {
          // Attempt to decode the JSON from the QR code
          final Map<String, dynamic> qrData = json.decode(rawValue);
          
          // Extract the visitor ID
          final dynamic visitorId = qrData['id'];

          if (visitorId != null) {
            setState(() {
              scannedData = "Visitor ID: $visitorId";
            });
            _handleScannedData(visitorId.toString());
          } else {
            // Handle cases where 'id' is not in the JSON
            _showErrorAndReset('QR code does not contain a visitor ID.');
          }
        } catch (e) {
          // Handle cases where the QR code is not valid JSON
          // Assume it might be a plain ID string as a fallback
          setState(() {
            scannedData = rawValue;
          });
          _handleScannedData(rawValue);
        }
      }
    }
  }

  void _showErrorAndReset(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    setState(() {
      scannedData = null;
      isScanning = true;
      _visitorStatus = null;
    });
    controller.start();
  }

  Future<void> _handleScannedData(String visitorId) async {
    try {
      // Show a loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing...')),
      );

      final visitorDetails = await _apiService.getEnrichedVisitorIfAny(visitorId);
      
      if (visitorDetails != null && visitorDetails['data'] != null) {
        final visitor = visitorDetails['data'];
        final status = visitor['status']?.toString() ?? 'pending'; // Default to pending if null

        bool success = false;
        String message;
        bool isCheckIn = false;

        if (status == 'checked-in') {
          // If visitor is checked-in, check them out
          success = await _apiService.manualCheckout(visitorId);
          message = 'Checked Out';
          isCheckIn = false;
        } else {
          // For any other status (pending, checked-out, etc.), check them in
          success = await _apiService.manualCheckin(visitorId);
          message = 'Checked In';
          isCheckIn = true;
        }
        
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        if (success) {
          Get.offAndToNamed(
            adminAppRoutes.manualCheckoutComplete,
            arguments: {
              'message': message,
              'isCheckIn': isCheckIn,
            },
          );
        } else {
          _showErrorAndReset(isCheckIn ? 'Check-in failed' : 'Check-out failed');
        }

      } else {
        _showErrorAndReset('Visitor not found');
      }
    } catch (e) {
      _showErrorAndReset('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              controller: controller,
              onDetect: _onDetect,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black12,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (scannedData != null)
                      Text(
                        "✅ Scanned: $scannedData",
                        style: const TextStyle(fontSize: 18, color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    if (_visitorStatus != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Status: $_visitorStatus",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (scannedData == null)
                      const Text(
                        "📷 Point the camera at a QR code",
                        style: TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: scannedData != null
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  scannedData = null;
                  isScanning = true;
                  _visitorStatus = null;
                });
                controller.start();
              },
              label: const Text("Scan Again"),
              icon: const Icon(Icons.qr_code_scanner),
            )
          : null,
    );
  }
}
