import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/reports_controller.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';
import 'package:synctrackr/admin/widgets/employee_list.dart';
import 'package:synctrackr/admin/widgets/reports_statics_chart.dart';
import 'package:synctrackr/admin/widgets/stats_cards.dart';
import 'package:synctrackr/admin/widgets/visitor_statistics.dart';
import 'package:synctrackr/admin/widgets/visitor_types_chart.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(ReportsController());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          flexibleSpace: CommonHeader(title: "Reports"),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const StatsCards(
                    cardNames: ['visitors', 'checkin', 'checkout', 'monthly']),
                const SizedBox(
                  height: 20,
                ),
                const ReportsStaticsChart(),
                const SizedBox(
                  height: 20,
                ),
                if (screenWidth > 820) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: VisitorStatistics()),
                      const SizedBox(width: 24),
                      const Expanded(child: VisitorTypesChart()),
                    ],
                  )
                ] else ...[
                  Column(
                    children: [
                      VisitorStatistics(),
                      const SizedBox(height: 24),
                      const VisitorTypesChart(),
                    ],
                  )
                ],
                const SizedBox(
                  height: 20,
                ),
                EmployeeList()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
