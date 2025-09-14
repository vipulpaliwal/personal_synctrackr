import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/api_config.dart';
import 'package:synctrackr/admin/utils/images.dart';

class BulkPassSection extends StatefulWidget {
  const BulkPassSection({super.key});

  @override
  State<BulkPassSection> createState() => _BulkPassSectionState();
}

class _BulkPassSectionState extends State<BulkPassSection> {
  MainController mainController = Get.find();
  final ApiService _api = ApiService();

  bool _loading = false;
  List<Map<String, dynamic>> _rows = [];
  int _page = 1;
  final int _pageSize = 10;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    try {
      final companyId = await ApiConfig.getCompanyId();
      final resp = await _api.listEpasses(
          companyId: companyId,
          page: _page,
          pageSize: _pageSize,
          search: _search);
      final List<dynamic> data = (resp['data'] ?? []) as List<dynamic>;
      _rows = data.cast<Map<String, dynamic>>();
    } catch (_) {
      _rows = [];
    } finally {
      if (mounted) setState(() => _loading = false);
    }
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
              color: isDarkMode
                  ? adminAppColors.secondary
                  : adminAppColors.primary),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Generated Bulk E-Passes',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Color(0xFF1A1D29),
                  ),
                ),
                Row(
                  children: [
                    ImageIcon(
                      AssetImage(AllImages.arrowRight)
                    )
                  // SizedBox(
                  //   width: 220,
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       hintText: 'Search passes...',
                  //       isDense: true,
                  //       contentPadding:
                  //           EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(6)),
                  //     ),
                  //     onSubmitted: (v) {
                  //       _search = v.trim();
                  //       _page = 1;
                  //       _loadData();
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(width: 8),
                  // IconButton(
                  //   tooltip: 'Refresh',
                  //   onPressed: _loading ? null : _loadData,
                  //   icon: Icon(Icons.refresh,
                  //       color: isDarkMode ? Colors.white : Colors.black),
                  // ),
                  // const SizedBox(width: 4),
                  // IconButton(
                  //   tooltip: 'Export CSV',
                  //   onPressed: _loading ? null : _exportCsv,
                  //   icon: Icon(Icons.download,
                  //       color: isDarkMode ? Colors.white : Colors.black),
                  // ),
                ]),
              ],
            ),

            const SizedBox(height: 8),

            const Text(
              'Generate bulk e-passes for easy visitor management with ease.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),

            const SizedBox(height: 20),

            // Table
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                    ),
                    child: _loading
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ))
                        : DataTable(
                            headingRowColor: WidgetStateProperty.all(
                              isDarkMode
                                  ? adminAppColors.darkSidebar
                                  : const Color(0xFFF8FAFC),
                            ),
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Name',
                                  style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Destination',
                                  style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Contact',
                                  style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Access',
                                  style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Valid From',
                                  style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Valid Until',
                                  style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Status',
                                  style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                            rows: _buildTableRows(),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  List<DataRow> _buildTableRows() {
    return _rows.map((item) {
      return DataRow(
        cells: [
          DataCell(
            Text(
              (item['name'] ?? item['fullName'] ?? '—').toString(),
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1D29),
              ),
            ),
          ),
          DataCell(
            Text(
              (item['location'] ?? item['destination'] ?? '—').toString(),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          DataCell(
            Text(
              (item['contact'] ?? item['mobile'] ?? '—').toString(),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          DataCell(
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                (item['access'] ?? item['accessLevel'] ?? '—').toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue.shade700,
                ),
              ),
            ),
          ),
          DataCell(
            Text(
              (item['validFrom'] ?? item['startDate'] ?? '—').toString(),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          DataCell(
            Text(
              (item['validUntil'] ?? item['endDate'] ?? '—').toString(),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          DataCell(
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor((item['status'] ?? '').toString())
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                (item['status'] ?? '—').toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _getStatusColor((item['status'] ?? '').toString()),
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'expired':
        return Colors.red;
      case 'used':
        return Colors.orange;
      case 'pending':
        return Colors.blue;
      default:
        return Colors.grey;
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
}
