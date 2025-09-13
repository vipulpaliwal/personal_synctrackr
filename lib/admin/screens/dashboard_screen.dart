// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
// import 'package:synctrackr/admin/widgets/common_header.dart';
// import 'package:synctrackr/admin/widgets/live_feed.dart';
// import 'package:synctrackr/admin/widgets/pending_visitors.dart';
// import 'package:synctrackr/admin/widgets/stats_cards.dart';
// import 'package:synctrackr/admin/widgets/visitor_statistics.dart';
// import 'package:synctrackr/admin/widgets/visitor_types_chart.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Get.put(DashboardController());
//     return const DashboardContent();
//   }
// }

// class DashboardContent extends StatelessWidget {
//   const DashboardContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const CommonHeader(title: 'Home'),
//               const SizedBox(height: 24),

//               // Stats Cards
//               StatsCards(cardNames: ['visitors', 'checkin', 'checkout', 'add']),
//               const SizedBox(height: 24),

//               // Main Content
//               Column(
//                 children: [
//                   const LiveFeed(),
//                   const SizedBox(height: 24),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: VisitorStatistics(),
//                       ),
//                       const SizedBox(width: 24),
//                       const Expanded(
//                         child: VisitorTypesChart(),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   const PendingVisitors(),
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

//updated1

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
// import 'package:synctrackr/admin/widgets/common_header.dart';
// import 'package:synctrackr/admin/widgets/live_feed.dart';
// import 'package:synctrackr/admin/widgets/pending_visitors.dart';
// import 'package:synctrackr/admin/widgets/stats_cards.dart';
// import 'package:synctrackr/admin/widgets/visitor_statistics.dart';
// import 'package:synctrackr/admin/widgets/visitor_types_chart.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Get.put(DashboardController());
//     return CustomScrollView(slivers: [
//       const SliverAppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white54,
//         elevation: 0,
//         scrolledUnderElevation: 0.0,
//         flexibleSpace: CommonHeader(title: "Home"),
//       ),
//       SliverList(
//           delegate: SliverChildListDelegate([

//         // Purana LayoutBuilder code hata ke direct Row laga do
// Padding(
//   padding: const EdgeInsets.all(20.0),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const StatsCards(
//         cardNames: ['visitors', 'checkin', 'checkout', 'add'],
//       ),
//       const SizedBox(height: 24),

//       // Live Feed
//       const LiveFeed(),
//       const SizedBox(height: 24),

//       // Hamesha Row me dikhana
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: VisitorStatistics(),
//           ),
//           const SizedBox(width: 24),
//           const Expanded(
//             child: VisitorTypesChart(),
//           ),
//         ],
//       ),

//       const SizedBox(height: 24),
//       const PendingVisitors(),
//     ],
//   ),
// ),

//       ])),
//     ]);
//   }
// }

//updated 4

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:synctrackr/admin/controllers/dashboard_controller.dart';
// import 'package:synctrackr/admin/widgets/common_header.dart';
// import 'package:synctrackr/admin/widgets/live_feed.dart';
// import 'package:synctrackr/admin/widgets/pending_visitors.dart';
// import 'package:synctrackr/admin/widgets/stats_cards.dart';
// import 'package:synctrackr/admin/widgets/visitor_statistics.dart';
// import 'package:synctrackr/admin/widgets/visitor_types_chart.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Get.put(DashboardController());
//     return CustomScrollView(
//       slivers: [
//         const SliverAppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.white54,
//           elevation: 0,
//           scrolledUnderElevation: 0.0,
//           flexibleSpace: CommonHeader(title: "Home"),
//         ),
//         SliverList(
//           delegate: SliverChildListDelegate([
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const StatsCards(
//                     cardNames: ['visitors', 'checkin', 'checkout', 'add'],
//                   ),
//                   const SizedBox(height: 24),

//                   // Live Feed
//                   const LiveFeed(),
//                   const SizedBox(height: 24),

//                   // Responsive Layout for Charts
//                   LayoutBuilder(
//                     builder: (context, constraints) {
//                       if (constraints.maxWidth >= 1024) {
//                         // Desktop
//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(child: VisitorStatistics()),
//                             const SizedBox(width: 24),
//                             const Expanded(child: VisitorTypesChart()),
//                           ],
//                         );
//                       } else if (constraints.maxWidth >= 768) {
//                         // Tablet
//                         return Wrap(
//                           spacing: 24,
//                           runSpacing: 24,
//                           children: [
//                             SizedBox(
//                               width: (constraints.maxWidth / 2) - 24,
//                               child: VisitorStatistics(),
//                             ),
//                             const SizedBox(
//                               width: 350, // fix width for chart
//                               child: VisitorTypesChart(),
//                             ),
//                           ],
//                         );
//                       } else {
//                         // Mobile
//                         return Column(
//                           children: [
//                             VisitorStatistics(),
//                             const SizedBox(height: 24),
//                             const VisitorTypesChart(),
//                           ],
//                         );
//                       }
//                     },
//                   ),

//                   const SizedBox(height: 24),
//                   const PendingVisitors(),
//                 ],
//               ),
//             ),
//           ]),
//         ),
//       ],
//     );
//   }
// }

//update 5

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
