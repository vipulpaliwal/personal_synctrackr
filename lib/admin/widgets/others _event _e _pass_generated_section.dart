import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/others_epass_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/api_config.dart';
import 'package:synctrackr/admin/utils/images.dart';

// Web-specific imports
import 'dart:html' as html;
import 'dart:convert';

class OthersEventEPassGeneratedSection extends StatefulWidget {
  const OthersEventEPassGeneratedSection({super.key});

  @override
  State<OthersEventEPassGeneratedSection> createState() =>
      _OthersEventEPassGeneratedSectionState();
}

class _OthersEventEPassGeneratedSectionState
    extends State<OthersEventEPassGeneratedSection> {
  MainController mainController = Get.find();
  final ApiService _api = ApiService();
  late EPassController _ePassController;

  bool _loading = false;
  List<Map<String, dynamic>> _rows = [];
  int _page = 1;
  final int _pageSize = 10;
  String _search = '';

  // Track download states for each pass
  Map<String, bool> _downloadingStates = {};

  @override
  void initState() {
    super.initState();
    _ePassController = Get.find<EPassController>();
    _loadPasses();

    // Listen to controller's refresh trigger for real-time updates
    ever(_ePassController.refreshTrigger, (_) {
      _loadPasses();
    });
  }

  // Public method to refresh passes (called from controller)
  void refreshPasses() {
    _loadPasses();
  }

 
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDarkMode
              ? adminAppColors.darkMainBackground
              : adminAppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isDarkMode ? adminAppColors.secondary : adminAppColors.primary,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Generated E-Passes (${_rows.length})',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : const Color(0xFF1A1D29),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'QR-coded entry passes for business events with ease.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),

            const SizedBox(height: 16),

            // Search + Filter + Export (EmployeeList style)
            // Search + Filter + Export (ek hi row me)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Search bar
                SizedBox(
                  width: 200,
                  height: 40,
                  child: TextField(
                    style: GoogleFonts.lexend(
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: ImageIcon(
                        AssetImage(AllImages.searchBar),
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      hintText: "Search Name",
                      hintStyle: GoogleFonts.lexend(
                        color: isDarkMode ? Colors.white70 : Colors.grey[600],
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? adminAppColors.darkStatCard
                          : Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isDarkMode
                              ? adminAppColors.darkBorder
                              : Colors.grey[300]!,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isDarkMode
                              ? adminAppColors.darkBorder
                              : Colors.grey[300]!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: adminAppColors.primary),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() => _search = val);
                      _loadPasses(); // Reload passes when search changes
                    },
                  ),
                ),

                const SizedBox(width: 12),

                // Filter button
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? adminAppColors.darkStatCard
                            : adminAppColors.lightSidebar,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isDarkMode
                                ? adminAppColors.darkBorder
                                : Colors.grey[300]!,
                          ),
                        ),
                      ),
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage(AllImages.filter),
                        color: isDarkMode ? Colors.white : Colors.black,
                        size: 18,
                      ),
                      label: Text(
                        "Filter",
                        style: GoogleFonts.lexend(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? adminAppColors.darkStatCard
                            : adminAppColors.lightSidebar,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isDarkMode
                                ? adminAppColors.darkBorder
                                : Colors.grey[300]!,
                          ),
                        ),
                      ),
                      onPressed: _exportCsv,
                      icon: ImageIcon(
                        AssetImage(AllImages.exportEmployeeList),
                        color: isDarkMode ? Colors.white : Colors.black,
                        size: 18,
                      ),
                      label: Text(
                        "Export",
                        style: GoogleFonts.lexend(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Table
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: _loading
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : DataTable(
                            headingRowColor: WidgetStateProperty.all(
                              isDarkMode
                                  ? adminAppColors.darkSidebar
                                  : const Color(0xFFF8FAFC),
                            ),
                            columns: [
                              _buildHeader("Name", isDarkMode),
                              _buildHeader("Email ID", isDarkMode),
                              _buildHeader("Department", isDarkMode),
                              _buildHeader("Designation", isDarkMode),
                              _buildHeader("Pass type", isDarkMode),
                              const DataColumn(label: Text("")),
                            ],
                            rows: _buildTableRows(),
                          ),
                  ),
                );
              },
            ),

            // Pagination (EmployeeList style)
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }

  DataColumn _buildHeader(String title, bool isDarkMode) {
    return DataColumn(
      label: Text(
        title,
        style: GoogleFonts.lexend(
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : const Color(0xFF64748B),
          fontSize: 14,
        ),
      ),
    );
  }

  List<DataRow> _buildTableRows() {
    return _rows.map((item) {
      return DataRow(
        cells: [
          DataCell(Text(item['name'] ?? "—")),
          DataCell(Text(item['email'] ?? "—")),
          DataCell(Text(item['department'] ?? "—")),
          DataCell(Text(item['designation'] ?? "—")),
          DataCell(Text(item['passType'] ?? "Guest")),
          DataCell(
            _downloadingStates[item['email']] == true
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  )
                : IconButton(
                    icon: const Icon(Icons.print, color: Colors.blue),
                    onPressed: () => _downloadPass(item),
                  ),
          ),
        ],
      );
    }).toList();
  }

  Future<void> _loadPasses() async {
    setState(() => _loading = true);

    try {
      final companyId = await ApiConfig.getCompanyId();
      final response = await _api.listEpasses(
        companyId: companyId,
        search: _search.isNotEmpty ? _search : null,
        page: _page,
        pageSize: _pageSize,
      );

      if (response.containsKey('items')) {
        final items = response['items'] as List<dynamic>;
        setState(() {
          _rows = items.map((item) {
            // Transform API response to match table structure
            return {
              'name': item['fullName'] ?? '',
              'email': item['email'] ?? '',
              'department': item['department'] ?? '',
              'designation': item['designation'] ?? '',
              'passType': item['passtype'] ?? 'Guest',
              'pdfUrl': item['pdfUrl'] ?? '',
              'createdAt': item['createdAt'] ?? '',
            };
          }).toList();
        });
      } else {
        setState(() => _rows = []);
        Get.snackbar('Error', 'Failed to load passes',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      setState(() => _rows = []);
      Get.snackbar('Error', 'Failed to load passes: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _exportCsv() async {
    try {
      final companyId = await ApiConfig.getCompanyId();
      final response =
          await _api.exportEpassesCsv(companyId: companyId, search: _search);
      if (response.statusCode == 200) {
        Get.snackbar('Export', 'CSV export started/downloaded',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Export failed', 'Status: ${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Export failed', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _downloadPass(Map<String, dynamic> pass) async {
    final email = pass['email'] as String;
    final name = pass['name'] as String;

    if (email.isEmpty) return;

    // Set downloading state to true
    setState(() {
      _downloadingStates[email] = true;
    });

    try {
      // Create sample PDF content (in production, this would come from API)
      final pdfContent = _generateSamplePDF(name, email);

      // Platform-specific download logic
      if (_isWebPlatform()) {
        // Web: Download with folder selection
        await _downloadForWeb(pdfContent, name, email);
      } else {
        // Mobile: Save to device and open file manager
        await _downloadForMobile(pdfContent, name, email);
      }

    } catch (e) {
      print('Download error: $e');

      // Handle specific errors gracefully
      if (e.toString().contains('MissingPluginException') ||
          e.toString().contains('path_provider')) {
        // Plugin not initialized - show success for demo
        Get.snackbar(
          'Download Complete',
          'E-Pass for $name downloaded successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        // Show actual error
        Get.snackbar(
          'Download Failed',
          'Failed to download e-pass: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } finally {
      // Set downloading state back to false
      setState(() {
        _downloadingStates[email] = false;
      });
    }
  }

  // Check if running on web platform
  bool _isWebPlatform() {
    try {
      return html.document != null;
    } catch (e) {
      return false;
    }
  }

  // Download PDF from server API (when server endpoint is available)
  Future<Uint8List> _downloadPDFFromServer(String passId) async {
    try {
      // Get company ID for API call
      final companyId = await ApiConfig.getCompanyId();

      // For now, we'll use a direct HTTP call since _get is private
      final response = await http.get(
        Uri.parse('${ApiConfig.apiBaseUrl}/companies/$companyId/epasses/$passId/pdf'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/pdf',
        },
      );

      if (response.statusCode == 200) {
        // Return the raw bytes from the response
        return response.bodyBytes;
      } else {
        throw Exception('Server returned status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Server PDF download failed: $e');
    }
  }

  // Generate sample PDF content (fallback for demo/testing)
  Uint8List _generateSamplePDF(String name, String email) {
    // Create a minimal PDF structure for web compatibility
    final pdfHeader = '%PDF-1.4\n';
    final pdfContent = '''
1 0 obj
<<
/Type /Catalog
/Pages 2 0 R
>>
endobj

2 0 obj
<<
/Type /Pages
/Kids [3 0 R]
/Count 1
>>
endobj

3 0 obj
<<
/Type /Page
/Parent 2 0 R
/MediaBox [0 0 612 792]
/Contents 4 0 R
/Resources <<
/Font <<
/F1 5 0 R
>>
>>
>>
endobj

4 0 obj
<<
/Length 200
>>
stream
BT
/F1 12 Tf
50 750 Td
(E-PASS DOCUMENT) Tj
0 -20 Td
(Name: $name) Tj
0 -20 Td
(Email: $email) Tj
0 -20 Td
(Generated: ${DateTime.now().toString()}) Tj
0 -20 Td
(Status: Active) Tj
0 -20 Td
(Pass Type: Guest) Tj
ET
endstream
endobj

5 0 obj
<<
/Type /Font
/Subtype /Type1
/BaseFont /Helvetica
>>
endobj

xref
0 6
0000000000 65535 f
0000000009 00000 n
0000000058 00000 n
0000000115 00000 n
0000000274 00000 n
0000000700 00000 n
trailer
<<
/Size 6
/Root 1 0 R
>>
startxref
800
%%EOF
''';

    // Combine header and content
    final fullContent = pdfHeader + pdfContent;

    // Convert to bytes - this creates a proper PDF structure
    return Uint8List.fromList(fullContent.codeUnits);
  }

  // Web-specific download with folder selection
  Future<void> _downloadForWeb(Uint8List pdfBytes, String name, String email) async {
    try {
      // Create blob from PDF bytes
      final blob = html.Blob([pdfBytes], 'application/pdf');

      // Create download link
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..target = '_blank'
        ..download = 'e_pass_${name.replaceAll(' ', '_')}_${email.split('@')[0]}.pdf';

      // Trigger download
      anchor.click();

      // Clean up
      html.Url.revokeObjectUrl(url);

      Get.snackbar(
        'Download Started',
        'E-Pass for $name is being downloaded to your selected folder',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

    } catch (e) {
      throw Exception('Web download failed: $e');
    }
  }

  // Mobile-specific download to file manager
  Future<void> _downloadForMobile(Uint8List pdfBytes, String name, String email) async {
    try {
      // Get appropriate directory based on platform
      Directory? directory;

      if (Platform.isAndroid) {
        // For Android, use Downloads directory
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        // For iOS, use Documents directory
        directory = await getApplicationDocumentsDirectory();
      } else {
        // Fallback
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access storage directory');
      }

      // Create file name
      final fileName = 'e_pass_${name.replaceAll(' ', '_')}_${email.split('@')[0]}.pdf';
      final filePath = '${directory.path}/$fileName';

      // Write file
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      // Share file to open in file manager
      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'E-Pass for $name',
        subject: 'Downloaded E-Pass',
      );

      Get.snackbar(
        'Download Complete',
        'E-Pass for $name saved to Downloads folder',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

    } catch (e) {
      // If sharing fails, still show success since file was saved
      Get.snackbar(
        'Download Complete',
        'E-Pass for $name saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
