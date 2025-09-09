import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';

class BulkPassSection extends StatefulWidget {
  const BulkPassSection({super.key});

  @override
  State<BulkPassSection> createState() => _BulkPassSectionState();
}

class _BulkPassSectionState extends State<BulkPassSection> {
  MainController mainController = Get.find();
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                      AssetImage(AllImages.arrowRight),
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
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
                    child: DataTable(
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
                              color:
                                  isDarkMode ? Colors.white : Color(0xFF64748B),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Destination',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w600,
                              color:
                                  isDarkMode ? Colors.white : Color(0xFF64748B),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Contact',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w600,
                              color:
                                  isDarkMode ? Colors.white : Color(0xFF64748B),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Access',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w600,
                              color:
                                  isDarkMode ? Colors.white : Color(0xFF64748B),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Valid From',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w600,
                              color:
                                  isDarkMode ? Colors.white : Color(0xFF64748B),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Valid Until',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w600,
                              color:
                                  isDarkMode ? Colors.white : Color(0xFF64748B),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Status',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w600,
                              color:
                                  isDarkMode ? Colors.white : Color(0xFF64748B),
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
    final List<Map<String, dynamic>> data = [
      {
        'name': 'Abhinav Goel',
        'location': 'Conference Room A',
        'contact': '+91 9876543210',
        'access': 'Level 2',
        'validFrom': '2024-01-15',
        'validUntil': '2024-01-16',
        'status': 'Active',
      },
      {
        'name': 'Rohit Sharma',
        'location': 'Meeting Room B',
        'contact': '+91 9876543211',
        'access': 'Level 1',
        'validFrom': '2024-01-15',
        'validUntil': '2024-01-15',
        'status': 'Expired',
      },
      {
        'name': 'Priya Singh',
        'location': 'Executive Office',
        'contact': '+91 9876543212',
        'access': 'Level 3',
        'validFrom': '2024-01-16',
        'validUntil': '2024-01-20',
        'status': 'Active',
      },
      {
        'name': 'Arjun Patel',
        'location': 'Lobby Area',
        'contact': '+91 9876543213',
        'access': 'Level 1',
        'validFrom': '2024-01-14',
        'validUntil': '2024-01-14',
        'status': 'Used',
      },
      {
        'name': 'Neha Gupta',
        'location': 'Training Room',
        'contact': '+91 9876543214',
        'access': 'Level 2',
        'validFrom': '2024-01-17',
        'validUntil': '2024-01-18',
        'status': 'Pending',
      },
    ];

    return data.map((item) {
      return DataRow(
        cells: [
          DataCell(
            Text(
              item['name'],
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1D29),
              ),
            ),
          ),
          DataCell(
            Text(
              item['location'],
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          DataCell(
            Text(
              item['contact'],
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
                item['access'],
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
              item['validFrom'],
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          DataCell(
            Text(
              item['validUntil'],
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
                color: _getStatusColor(item['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item['status'],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _getStatusColor(item['status']),
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
}
