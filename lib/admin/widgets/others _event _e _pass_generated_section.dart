import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/services/api_services.dart';
import 'package:synctrackr/admin/config/api_config.dart';

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
        search: _search,
      );
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
                : adminAppColors.primary,
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
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 38,
                    child: TextField(
                      style: GoogleFonts.lexend(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: const Icon(Icons.search, size: 18),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? adminAppColors.secondary
                                : const Color(0xFFCBD5E1),
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() => _search = val);
                        _loadData();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 38,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    icon: const Icon(Icons.filter_list, size: 16),
                    label: const Text("Filter", style: TextStyle(fontSize: 13)),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 38,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    icon: const Icon(Icons.download, size: 16),
                    label: const Text("Export", style: TextStyle(fontSize: 13)),
                    onPressed: _exportCsv,
                  ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: _page > 1
                      ? () {
                          setState(() => _page--);
                          _loadData();
                        }
                      : null,
                  child: const Text("Previous"),
                ),
                const SizedBox(width: 8),
                for (int i = 1; i <= 4; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            i == _page ? Colors.blue : Colors.transparent,
                        foregroundColor:
                            i == _page ? Colors.white : Colors.black,
                        minimumSize: const Size(34, 34),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        setState(() => _page = i);
                        _loadData();
                      },
                      child: Text("$i"),
                    ),
                  ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    setState(() => _page++);
                    _loadData();
                  },
                  child: const Text("Next"),
                ),
              ],
            ),
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
            IconButton(
              icon: const Icon(Icons.print, color: Colors.blue),
              onPressed: () {
                // TODO: implement print logic
              },
            ),
          ),
        ],
      );
    }).toList();
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
