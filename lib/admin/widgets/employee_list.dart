import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:synctrackr/admin/controllers/employee_list_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeListController controller = Get.put(EmployeeListController());
    final MainController mainController = Get.find<MainController>();

    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      final isLoading = controller.isLoading.value;
      final error = controller.errorMessage.value;
      print(
          "Building EmployeeList with ${controller.filteredResults.length} items");
      final results = controller.getCurrentPageResults();

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode
              ? adminAppColors.darkSidebar
              : adminAppColors.lightSidebar,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isDarkMode ? adminAppColors.secondary : adminAppColors.primary,
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Search
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      color: isDarkMode
                          ? adminAppColors.darkStatCard
                          : adminAppColors.lightSidebar,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: isDarkMode
                              ? adminAppColors.secondary
                              : adminAppColors.primary)),
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
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? adminAppColors.firstStatCard
                          : adminAppColors.lightSidebar,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 12),
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
                // Filter Button
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? adminAppColors.firstStatCard
                            : adminAppColors.lightSidebar,
                        foregroundColor: isDarkMode
                            ? adminAppColors.firstStatCard
                            : adminAppColors.lightSidebar,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isDarkMode
                                ? adminAppColors.secondary
                                : adminAppColors.primary,
                          ),
                        ),
                      ),
                      onPressed: () {},
                      icon: ImageIcon(
                          color: isDarkMode ? Colors.white : Colors.black,
                          AssetImage(AllImages.filter),
                          size: 18),
                      label: Text("Filter",
                          style: GoogleFonts.lexend(
                              color: isDarkMode ? Colors.white : Colors.black)),
                    ),
                    const SizedBox(width: 12),
                    // Export Button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? adminAppColors.firstStatCard
                            : adminAppColors.lightSidebar,
                        foregroundColor: isDarkMode
                            ? adminAppColors.firstStatCard
                            : adminAppColors.lightSidebar,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isDarkMode
                                ? adminAppColors.secondary
                                : adminAppColors.primary,
                          ),
                        ),
                      ),
                      onPressed: () {},
                      icon: ImageIcon(
                          color: isDarkMode ? Colors.white : Colors.black,
                          AssetImage(AllImages.exportEmployeeList),
                          size: 18),
                      label: Text("Export",
                          style: GoogleFonts.lexend(
                              color: isDarkMode ? Colors.white : Colors.black)),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 🔹 Table Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black38 : Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDarkMode
                      ? adminAppColors.darkBorder
                      : Colors.grey[200]!,
                ),
              ),
              child: Row(
                children: [
                  _buildHeaderCell("Name", flex: 3, isDarkMode: isDarkMode),
                  _buildHeaderCell("Purpose", flex: 2, isDarkMode: isDarkMode),
                  _buildHeaderCell("    Status",
                      flex: 2, isDarkMode: isDarkMode),
                  _buildHeaderCell("Signed In",
                      flex: 2, isDarkMode: isDarkMode),
                  _buildHeaderCell("Signed Out",
                      flex: 2, isDarkMode: isDarkMode),
                  _buildHeaderCell("",
                      flex: 1, align: TextAlign.center, isDarkMode: isDarkMode),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 Table Rows
            SizedBox(
              height: 700,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : (error.isNotEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Text(
                              error,
                              style: TextStyle(
                                color:
                                    isDarkMode ? Colors.red[300] : Colors.red,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : (results.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Text(
                                  "No employees found",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemCount: results.length,
                              separatorBuilder: (_, __) => const Divider(),
                              itemBuilder: (context, index) {
                                final result = results[index];
                                return GestureDetector(
                                    onTap: () {
                                      Get.find<MainController>()
                                          .selectVisitor(result);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center, // center align vertically
                                                  children: [
                                                    CircleAvatar(
                                                      radius:
                                                          20, // adjust size if needed
                                                      backgroundImage: (result
                                                                      .photo !=
                                                                  null &&
                                                              result.photo!
                                                                  .isNotEmpty)
                                                          ? NetworkImage(
                                                              result.photo!)
                                                          : const AssetImage(
                                                                  'assets/images/profile.jpg')
                                                              as ImageProvider,
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center, // center align text
                                                        children: [
                                                          Text(
                                                            result.name,
                                                            style: GoogleFonts
                                                                .lexend(
                                                              color: isDarkMode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                            "Host: ${result.host?.name  }",
                                                            style: GoogleFonts
                                                                .lexend(
                                                              color: isDarkMode
                                                                  ? Colors
                                                                      .white70
                                                                  : Colors.grey[
                                                                      600],
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              _buildCell(result.purpose,
                                                  flex: 2,
                                                  isDarkMode: isDarkMode),
                                              _buildStatusCell(result.status,
                                                  flex: 2,
                                                  isDarkMode: isDarkMode),
                                              _buildCell(
                                                  result.signedIn != null
                                                      ? DateFormat('hh:mm a')
                                                          .format(
                                                              result.signedIn!)
                                                      : '---',
                                                  flex: 2,
                                                  isDarkMode: isDarkMode),
                                              _buildCell(
                                                result.signedOut != null
                                                    ? DateFormat('hh:mm a')
                                                        .format(
                                                            result.signedOut!)
                                                    : '---',
                                                isDarkMode: isDarkMode,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.more_horiz,
                                                  color: isDarkMode
                                                      ? Colors.white70
                                                      : Colors.grey[400],
                                                ),
                                              ),
                                            ])));
                              },
                            ))),
            ),

            const SizedBox(height: 20),

            // 🔹 Pagination
            Obx(() {
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
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
                                  : (isDarkMode
                                      ? Colors.white70
                                      : Colors.grey[700]),
                              fontWeight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.normal,
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
                    isEnabled:
                        controller.currentPage.value < controller.totalPages,
                  ),
                ],
              );
            }),
          ],
        ),
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
    final isCheckedIn = status.toLowerCase().contains("checked in") ||
        status.toLowerCase().contains("working");

    Color bg, textColor, borderColor;

    if (isDarkMode) {
      bg = isCheckedIn ? Colors.transparent : Colors.transparent;
      textColor = Colors.white;
      borderColor = Colors.transparent;
    } else {
      bg = isCheckedIn ? Colors.transparent : Colors.transparent;
      textColor = Colors.black;
      borderColor = Colors.transparent;
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
            border: Border.all(color: borderColor),
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
