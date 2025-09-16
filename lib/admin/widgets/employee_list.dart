import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:synctrackr/admin/controllers/employee_list_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';

String capitalizeWords(String text) {
  if (text.isEmpty) {
    return '';
  }
  return text
      .split(' ')
      .map((word) => word.isNotEmpty
          ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
          : '')
      .join(' ');
}

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeListController controller = Get.put(EmployeeListController());
    final MainController mainController = Get.find<MainController>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: mainController.isDarkMode.value
            ? adminAppColors.darkSidebar
            : adminAppColors.lightSidebar,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: mainController.isDarkMode.value
              ? adminAppColors.secondary
              : adminAppColors.primary,
        ),
        boxShadow: [
          BoxShadow(
            color: mainController.isDarkMode.value
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header (Search + Buttons)
          buildHeader(controller, mainController.isDarkMode.value),
          const SizedBox(height: 24),
          // 🔹 Table Header
          buildTableHeader(mainController.isDarkMode.value),
          const SizedBox(height: 8),
          // 🔹 Table Rows
          SizedBox(
            height: 700, // Provide a fixed height for the list
            child: Obx(() {
              final isDarkMode = mainController.isDarkMode.value;
              final isLoading = controller.isLoading.value;
              final error = controller.errorMessage.value;
              final results = controller.getCurrentPageResults();
              final hasData = controller.allResults.isNotEmpty;

              if (!hasData) {
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (error.isNotEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(
                        error,
                        style: TextStyle(
                          color: isDarkMode ? Colors.red[300] : Colors.red,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      "No employees found",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }

              if (results.isEmpty && !isLoading) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      "No employees found",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }

              return ListView.separated(
                itemCount: results.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, thickness: 0.5),
                itemBuilder: (context, index) {
                  final result = results[index];
                  return buildTableRow(result, isDarkMode);
                },
              );
            }),
          ),
          const SizedBox(height: 20),
          // 🔹 Pagination
          buildPagination(controller, mainController.isDarkMode.value),
        ],
      ),
    );
  }

  Widget buildHeader(EmployeeListController controller, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Search
        Container(
          height: 40,
          width: 200,
          child: TextField(
            controller: controller.searchController,
            onChanged: controller.filterResults,
            style: GoogleFonts.lexend(
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
            decoration: InputDecoration(
              prefixIcon: ImageIcon(
                color: isDarkMode ? Colors.white : Colors.black,
                AssetImage(AllImages.searchBar),
              ),
              hintText: "Search Name",
              hintStyle: GoogleFonts.lexend(
                color: isDarkMode ? Colors.white70 : Colors.grey[600],
              ),
              filled: true,
              fillColor:
                  isDarkMode ? adminAppColors.darkStatCard : adminAppColors.lightSidebar,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isDarkMode
                      ? adminAppColors.secondary
                      : adminAppColors.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isDarkMode
                      ? adminAppColors.secondary
                      : adminAppColors.primary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: adminAppColors.primary),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Filter and Export Buttons
        Row(
          children: [
            // Status Filter Dropdown
            Obx(() {
              final selectedStatus = controller.selectedStatus.value;
              final statusOptions = controller.getStatusOptions();

              return Container(
                height: 40,
                width: 180, // Fixed width for consistent dropdown size
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? adminAppColors.darkStatCard
                      : adminAppColors.lightSidebar,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDarkMode
                        ? adminAppColors.secondary
                      : adminAppColors.primary,
                  ),
                ),
                child: DropdownButton<String>(
                  value: selectedStatus.isEmpty ? 'All' : selectedStatus,
                  dropdownColor: isDarkMode
                      ? adminAppColors.darkStatCard
                      : Colors.white,
                  style: GoogleFonts.lexend(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 14,
                  ),
                  underline: const SizedBox.shrink(),
                  icon: const SizedBox.shrink(), // Remove dropdown arrow
                  selectedItemBuilder: (BuildContext context) {
                    return statusOptions.map((String status) {
                      final displayText = selectedStatus.isEmpty
                          ? 'Filter'
                          : controller.getStatusDisplayName(selectedStatus);
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageIcon(
                            color: isDarkMode ? Colors.white : Colors.black,
                            AssetImage(AllImages.filter),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            displayText,
                            style: GoogleFonts.lexend(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                  items: statusOptions.map((String status) {
                    final displayText = status == 'All' && selectedStatus.isEmpty
                        ? 'Filter'
                        : controller.getStatusDisplayName(status);
                    // return DropdownMenuItem<String>(
                    //   value: status,
                    //   child: Container(
                    //     constraints: const BoxConstraints(maxWidth: 200),
                    //     color: isDarkMode
                    //         ? adminAppColors.darkStatCard
                    //         : adminAppColors.lightSidebar,
                    //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    //     child: Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         ImageIcon(
                    //           color: isDarkMode ? Colors.white : Colors.black,
                    //           AssetImage(AllImages.filter),
                    //           size: 16,
                    //         ),
                    //         const SizedBox(width: 8),
                    //         Expanded(
                    //           child: Text(
                    //             displayText,
                    //             style: GoogleFonts.lexend(
                    //               color: isDarkMode ? Colors.white : Colors.black,
                    //               fontSize: 14,
                    //             ),
                    //             overflow: TextOverflow.ellipsis,
                    //             maxLines: 1,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );
                    return DropdownMenuItem<String>(
  value: status,
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageIcon(
          color: isDarkMode ? Colors.white : Colors.black,
          AssetImage(AllImages.filter),
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            displayText,
            style: GoogleFonts.lexend(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    ),
  ),
);

                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      if (newValue == 'All') {
                        controller.clearStatusFilter();
                      } else {
                        controller.updateStatusFilter(newValue);
                      }
                    }
                  },
                ),
              );
            }),
            const SizedBox(width: 12),
            // Export Button (same size as filter)
            Obx(() {
              final isExporting = controller.isExporting.value;
              final selectedStatus = controller.selectedStatus.value;

              return GestureDetector(
                onTap: isExporting ? null : () => controller.exportVisitorsCsv(selectedStatus.isEmpty ? 'All' : selectedStatus),
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isExporting
                        ? (isDarkMode ? adminAppColors.darkStatCard : adminAppColors.lightSidebar)
                        : (isDarkMode ? adminAppColors.darkStatCard : adminAppColors.lightSidebar),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDarkMode
                          ? adminAppColors.secondary
                      : adminAppColors.primary,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isExporting)
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        )
                      else
                        ImageIcon(
                          color: isDarkMode ? Colors.white : Colors.black,
                          AssetImage(AllImages.exportEmployeeList),
                          size: 16,
                        ),
                      const SizedBox(width: 8),
                      Text(
                        isExporting ? "Exporting..." : "Export",
                        style: GoogleFonts.lexend(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget buildTableHeader(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black38 : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? adminAppColors.darkBorder : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          _buildHeaderCell("Name", flex: 3, isDarkMode: isDarkMode),
          _buildHeaderCell("Purpose", flex: 2, isDarkMode: isDarkMode),
          _buildHeaderCell("Status", flex: 2, isDarkMode: isDarkMode),
          _buildHeaderCell("Signed In", flex: 2, isDarkMode: isDarkMode),
          _buildHeaderCell("Signed Out", flex: 2, isDarkMode: isDarkMode),
          _buildHeaderCell("",
              flex: 1, align: TextAlign.center, isDarkMode: isDarkMode),
        ],
      ),
    );
  }

  Widget buildTableRow(Visitor result, bool isDarkMode) {
    return GestureDetector(
      onTap: () => Get.find<MainController>().selectVisitor(result),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        (result.photo != null && result.photo!.isNotEmpty)
                            ? NetworkImage(result.photo!)
                            : const AssetImage('assets/images/profile.jpg')
                                as ImageProvider,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          capitalizeWords(result.name),
                          style: GoogleFonts.lexend(
                            color: isDarkMode ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Host: ${result.host?.name ?? ''}",
                          style: GoogleFonts.lexend(
                            color:
                                isDarkMode ? Colors.white70 : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildCell(result.purpose, flex: 2, isDarkMode: isDarkMode),
            _buildStatusCell(result.status, flex: 2, isDarkMode: isDarkMode),
            _buildCell(
                result.signedIn != null
                    ? DateFormat('hh:mm a').format(result.signedIn!)
                    : '---',
                flex: 2,
                isDarkMode: isDarkMode),
            _buildCell(
              result.signedOut != null
                  ? DateFormat('hh:mm a').format(result.signedOut!)
                  : '---',
              flex: 2,
              isDarkMode: isDarkMode,
            ),
            Expanded(
              flex: 1,
              child: Icon(
                Icons.more_horiz,
                color: isDarkMode ? Colors.white70 : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPagination(EmployeeListController controller, bool isDarkMode) {
    return Obx(() {
      if (controller.totalPages <= 1) {
        return const SizedBox.shrink();
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildPageButton(
            "Previous",
            onTap: controller.previousPage,
            isDarkMode: isDarkMode,
            isEnabled: controller.currentPage.value > 1,
          ),
          const SizedBox(width: 8),
          ...List.generate(controller.totalPages, (i) {
            final page = i + 1;
            final isActive = controller.currentPage.value == page;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () => controller.goToPage(page),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive
                        ? adminAppColors.primary
                        : (isDarkMode
                            ? adminAppColors.darkStatCard
                            : Colors.grey[100]),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isActive
                          ? adminAppColors.primary
                          : (isDarkMode
                              ? adminAppColors.darkBorder
                              : Colors.grey[300]!),
                    ),
                  ),
                  child: Text(
                    "$page",
                    style: GoogleFonts.lexend(
                      color: isActive
                          ? Colors.white
                          : (isDarkMode ? Colors.white70 : Colors.grey[700]),
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(width: 8),
          _buildPageButton(
            "Next",
            onTap: controller.nextPage,
            isDarkMode: isDarkMode,
            isEnabled: controller.currentPage.value < controller.totalPages,
          ),
        ],
      );
    });
  }

  Widget _buildHeaderCell(String text,
      {int flex = 1,
      TextAlign align = TextAlign.left,
      required bool isDarkMode}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: GoogleFonts.lexend(
          color: isDarkMode ? Colors.white70 : Colors.grey[700],
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        textAlign: align,
      ),
    );
  }

  Widget _buildCell(String text, {int flex = 2, required bool isDarkMode}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: GoogleFonts.lexend(
          color: isDarkMode ? Colors.white : Colors.black87,
          fontSize: 14,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildStatusCell(String status,
      {int flex = 2, required bool isDarkMode}) {
    final isCheckedIn =
        status.contains("checked in") || status.contains("working");

    Color bg, textColor;

    if (isCheckedIn) {
      bg = Colors.transparent;
      textColor = isDarkMode ? Colors.white : Colors.black;
    } else {
      bg = Colors.transparent;
      textColor = isDarkMode ? Colors.white : Colors.black;
    }

    return Expanded(
      flex: flex,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: GoogleFonts.lexend(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildPageButton(String text,
      {required VoidCallback onTap,
      required bool isDarkMode,
      bool isEnabled = true}) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isDarkMode ? adminAppColors.darkStatCard : Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isDarkMode ? adminAppColors.darkBorder : Colors.grey[300]!,
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.lexend(
              color: isDarkMode ? Colors.white70 : Colors.grey[700],
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
