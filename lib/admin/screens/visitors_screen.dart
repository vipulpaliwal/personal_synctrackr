import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/visitors_controller.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/utils/images.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';
import 'package:synctrackr/admin/widgets/custom_pagination.dart';

class VisitorsScreen extends StatelessWidget {
  final VisitorsController controller = Get.put(VisitorsController());

  VisitorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return LayoutBuilder(
        builder: (context, constraints) {
          bool isTabletOrWeb = constraints.maxWidth > 768;
          return Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const CommonHeader(title: "Visitors"),
                    Expanded(
                      child: _buildMainContent(isTabletOrWeb, isDarkMode),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }

  Widget _buildMainContent(bool isTabletOrWeb, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
          // color: isDarkMode ? AppColors.darkBackground : AppColors.background,
          ),
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          _buildStatsCards(isTabletOrWeb, isDarkMode),
          const SizedBox(height: 24),
          _buildEmployeeSection(isTabletOrWeb, isDarkMode),
        ],
      ),
    );
  }

  // Widget _buildStatsCards() {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       bool isWideScreen = constraints.maxWidth > 600;

  //       return isWideScreen
  //           ? Row(
  //               children: [
  //                 Expanded(
  //                     child: _buildStatCard(
  //                         'Total Department', '10', Colors.blue)),
  //                 const SizedBox(width: 16),
  //                 Expanded(
  //                     child: _buildStatCard('Total Heads', '16', Colors.green)),
  //                 const SizedBox(width: 16),
  //                 Expanded(
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       Get.find<MainController>().selectAddVisitorHead();
  //                     },
  //                     child: Container(
  //                       padding: const EdgeInsets.all(16),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(12),
  //                         border: Border.all(color: const Color(0xFFE2E8F0)),
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           const Expanded(
  //                             child: Text(
  //                               'Add Head Person',
  //                               style: TextStyle(
  //                                 color: Color(0xFF64748B),
  //                                 fontSize: 14,
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                             width: 32,
  //                             height: 32,
  //                             decoration: BoxDecoration(
  //                               color: const Color(0xFF3B82F6).withOpacity(0.1),
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                             child: const Icon(
  //                               Icons.add,
  //                               color: Color(0xFF3B82F6),
  //                               size: 18,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             )
  //           : Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                         child: _buildStatCard(
  //                             'Total Department', '10', Colors.blue)),
  //                     const SizedBox(width: 16),
  //                     Expanded(
  //                         child: _buildStatCard(
  //                             'Total Heads', '16', Colors.green)),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 16),
  //                 Container(
  //                   width: double.infinity,
  //                   padding: const EdgeInsets.all(16),
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(12),
  //                     border: Border.all(color: const Color(0xFFE2E8F0)),
  //                   ),
  //                   child: Row(
  //                     children: [
  //                       const Expanded(
  //                         child: Text(
  //                           'Add Head Person',
  //                           style: TextStyle(
  //                             color: Color(0xFF64748B),
  //                             fontSize: 14,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 32,
  //                         height: 32,
  //                         decoration: BoxDecoration(
  //                           color: const Color(0xFF3B82F6).withOpacity(0.1),
  //                           borderRadius: BorderRadius.circular(8),
  //                         ),
  //                         child: const Icon(
  //                           Icons.add,
  //                           color: Color(0xFF3B82F6),
  //                           size: 18,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             );
  //     },
  //   );
  // }

  // Widget _buildStatCard(String title, String value, Color color) {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: const Color(0xFFE2E8F0)),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           title,
  //           style: const TextStyle(
  //             color: Color(0xFF64748B),
  //             fontSize: 14,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           value,
  //           style: TextStyle(
  //             color: color,
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildStatsCards(bool isTabletOrWeb, bool isDarkMode) {
    return Obx(() => Row(
          children: [
            Expanded(
              child: _buildStatCard(
                  'Total Visitors',
                  controller.totalVisitors.value.toString(),
                  Icons.people,
                  isTabletOrWeb,
                  isDarkMode),
            ),
          ],
        ));
  }

  Widget _buildStatCard(String title, String? value, IconData icon,
      bool isTabletOrWeb, bool isDarkMode) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? adminAppColors.darkSecondaryBackground
            : const Color(0xFFF0F6FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color:
                isDarkMode ? adminAppColors.secondary : adminAppColors.primary),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                color:
                    isDarkMode ? adminAppColors.darkTextPrimary : Colors.black,
                fontSize: isTabletOrWeb ? 15 : 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 3),
          if (value != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : const Color(0xFF3B82F6),
                    size: isTabletOrWeb ? 22 : 20),
                const SizedBox(width: 8),
                Text(
                  value,
                  style: GoogleFonts.lexend(
                    fontSize: isTabletOrWeb ? 22 : 22,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : Colors.black,
                  ),
                ),
              ],
            )
          else
            Icon(icon,
                size: isTabletOrWeb ? 30 : 24,
                color: isDarkMode
                    ? adminAppColors.darkTextPrimary
                    : Colors.black87),
        ],
      ),
    );
  }

  Widget _buildEmployeeSection(bool isTabletOrWeb, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? adminAppColors.darkMainBackground
            : adminAppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color:
                isDarkMode ? adminAppColors.secondary : adminAppColors.primary),
      ),
      child: Column(
        children: [
          _buildEmployeeHeader(isDarkMode),
          _buildEmployeeList(isTabletOrWeb, isDarkMode),
          const SizedBox(height: 20),
          _buildPagination(isDarkMode),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEmployeeHeader(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDarkMode
              ? adminAppColors.darkMainBackground
              : adminAppColors.background,
          border: Border(
              bottom: BorderSide(
                  color: isDarkMode
                      ? adminAppColors.secondary
                      : adminAppColors.primary))),
      child: Row(
        children: [
          Container(
            width: 300,
            height: 35,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? adminAppColors.darkSecondaryBackground
                  : adminAppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: isDarkMode
                      ? adminAppColors.secondary
                      : adminAppColors.primary),
            ),
            child: Center(
              child: TextField(
                onChanged: (value) => controller.search(value),
                decoration: InputDecoration(
                  hintText: 'Search Name',
                  hintStyle: GoogleFonts.lexend(
                      color: isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 16),
                  prefixIcon: ImageIcon(AssetImage(AllImages.searchBar),
                      color: isDarkMode
                          ? Colors.white
                          : Colors.black,
                      size: 16),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                ),
                style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : Colors.black),
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? adminAppColors.darkMainBackground
                  : adminAppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: isDarkMode
                      ? adminAppColors.secondary
                      : adminAppColors.primary),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(AssetImage(AllImages.filter),
                    color: isDarkMode ? adminAppColors.secondary : Colors.black,
                    size: 18),
                const SizedBox(width: 6),
                Text(
                  'Filter',
                  style: TextStyle(
                      color: isDarkMode
                          ? adminAppColors.darkTextPrimary
                          : Colors.black,
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeList(bool isTabletOrWeb, bool isDarkMode) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.filteredVisitors.isEmpty) {
        return const Center(child: Text('No visitors found.'));
      }
      final results = controller.getCurrentPageResults();
      return Column(
        children: results
            .map((visitor) =>
                _buildVisitorCard(visitor, isTabletOrWeb, isDarkMode))
            .toList(),
      );
    });
  }

  Widget _buildVisitorCard(
      Visitor visitor, bool isTabletOrWeb, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        // Get.find<MainController>().selectVisitor(visitor);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode
              ? adminAppColors.darkMainBackground
              : adminAppColors.background,
          border: Border(
              bottom: BorderSide(
                  color: isDarkMode
                      ? adminAppColors.secondary.withOpacity(0.5)
                      : const Color(0xFFE2E8F0))),
        ),
        child: isTabletOrWeb
            ? Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: isDarkMode
                        ? adminAppColors.darkSecondary
                        : const Color(0xFF3B82F6),
                    // backgroundImage: AssetImage(employee.avatar),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          visitor.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: isDarkMode
                                ? adminAppColors.darkTextPrimary
                                : adminAppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          visitor.company ?? '',
                          style: GoogleFonts.lexend(
                            color: isDarkMode
                                ? adminAppColors.darkTextSecondary
                                : const Color(0xFF64748B),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            visitor.status,
                            style: GoogleFonts.lexend(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Purpose',
                          style: GoogleFonts.lexend(
                            color: isDarkMode
                                ? adminAppColors.darkTextSecondary
                                : const Color(0xFF64748B),
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          visitor.purpose,
                          style: TextStyle(
                            color: isDarkMode
                                ? adminAppColors.darkTextPrimary
                                : const Color(0xFF1E293B),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Host',
                          style: GoogleFonts.lexend(
                            color: isDarkMode
                                ? adminAppColors.darkTextSecondary
                                : const Color(0xFF64748B),
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          visitor.host!.name,
                          style: TextStyle(
                            color: isDarkMode
                                ? adminAppColors.darkTextPrimary
                                : const Color(0xFF1E293B),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? adminAppColors.darkCard
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: isDarkMode
                              ? adminAppColors.darkBorder
                              : const Color(0xFFE2E8F0)),
                    ),
                    child: Icon(
                      Icons.more_vert,
                      color: isDarkMode
                          ? adminAppColors.darkTextSecondary
                          : const Color(0xFF94A3B8),
                      size: 18,
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: isDarkMode
                            ? adminAppColors.darkSecondary
                            : const Color(0xFF3B82F6),
                        
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    visitor.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? adminAppColors.darkTextPrimary
                                          : const Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    visitor.status,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              visitor.company ?? '',
                              style: TextStyle(
                                color: isDarkMode
                                    ? adminAppColors.darkTextSecondary
                                    : const Color(0xFF64748B),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? adminAppColors.darkCard
                              : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: isDarkMode
                                  ? adminAppColors.darkBorder
                                  : const Color(0xFFE2E8F0)),
                        ),
                        child: Icon(
                          Icons.more_vert,
                          color: isDarkMode
                              ? adminAppColors.darkTextSecondary
                              : const Color(0xFF94A3B8),
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Purpose',
                              style: TextStyle(
                                color: isDarkMode
                                    ? adminAppColors.darkTextSecondary
                                    : const Color(0xFF64748B),
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              visitor.purpose,
                              style: TextStyle(
                                color: isDarkMode
                                    ? adminAppColors.darkTextPrimary
                                    : const Color(0xFF1E293B),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Host',
                              style: TextStyle(
                                color: isDarkMode
                                    ? adminAppColors.darkTextSecondary
                                    : const Color(0xFF64748B),
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              visitor.host!.name,
                              style: TextStyle(
                                color: isDarkMode
                                    ? adminAppColors.darkTextPrimary
                                    : const Color(0xFF1E293B),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildPagination(bool isDarkMode) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildPageButton("Previous",
              onTap: controller.previousPage, isDarkMode: isDarkMode),
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
          _buildPageButton("Next",
              onTap: controller.nextPage, isDarkMode: isDarkMode),
        ],
      ),
    );
  }

  Widget _buildPageButton(String text,
      {required VoidCallback onTap, required bool isDarkMode}) {
    return GestureDetector(
      onTap: onTap,
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
    );
  }
}
