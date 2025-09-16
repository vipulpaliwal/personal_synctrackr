import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';
import 'package:synctrackr/admin/widgets/live_feed.dart';
import 'package:synctrackr/admin/widgets/pending_visitors.dart';
import 'package:synctrackr/admin/widgets/stats_cards.dart';
import 'package:synctrackr/admin/widgets/visitor_statistics.dart';
import 'package:synctrackr/admin/widgets/visitor_types_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(DashboardController());
  }

  @override
  Widget build(BuildContext context) {
    // Get full screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.transparent,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0.0,
            flexibleSpace: const CommonHeader(title: "Home"),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StatsCards(
                      cardNames: ['visitors', 'checkin', 'checkout', 'add'],
                    ),
                    const SizedBox(height: 24),

                    // Live Feed
                    const LiveFeed(),
                    const SizedBox(height: 24),

                    // Charts Layout
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

                    const SizedBox(height: 24),
                    const PendingVisitors(),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
