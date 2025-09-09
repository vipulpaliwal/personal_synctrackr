import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/visitor_dashboard_controller.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:synctrackr/admin/utils/responsive.dart';
import 'package:synctrackr/admin/screens/sidebar.dart';

class VisitorDashboardScreen extends StatelessWidget {
  final Visitor visitor;

  const VisitorDashboardScreen({super.key, required this.visitor});

  @override
  Widget build(BuildContext context) {
    final VisitorDashboardController controller =
        Get.put(VisitorDashboardController(visitor));
    return Scaffold(
      body: Responsive(
        mobile: _buildMainContent(context, BoxConstraints(), controller),
        tablet: Row(
          children: [
            Container(
              width: 250,
              color: Colors.white,
              child: const Sidebar(),
            ),
            Expanded(
              child: _buildMainContent(context, BoxConstraints(), controller),
            ),
          ],
        ),
        desktop: Row(
          children: [
            Container(
              width: 250,
              color: Colors.white,
              child: const Sidebar(),
            ),
            Expanded(
              child: _buildMainContent(context, BoxConstraints(), controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, BoxConstraints constraints,
      VisitorDashboardController controller) {
    final isTabletOrWeb = constraints.maxWidth >= 768;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isTabletOrWeb ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(controller),
          SizedBox(height: isTabletOrWeb ? 24 : 16),

          // Visitor Card
          _buildVisitorCard(context, isTabletOrWeb, controller),
        ],
      ),
    );
  }

  Widget _buildHeader(VisitorDashboardController controller) {
    return Row(
      children: [
        const Text(
          'Dashboard / Visitors / ',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 14,
          ),
        ),
        Text(
          controller.visitor.name,
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.light_mode_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.dark_mode_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }

  Widget _buildVisitorCard(BuildContext context, bool isTabletOrDesktop,
      VisitorDashboardController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(isTabletOrDesktop ? 32 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visitor Header
            _buildVisitorHeader(isTabletOrDesktop, controller),

            const SizedBox(height: 32),

            // Visitor Details Grid
            _buildDetailsGrid(isTabletOrDesktop, controller),

            const SizedBox(height: 32),

            // ID Proof and E-Pass Section
            _buildIdProofSection(isTabletOrDesktop),

            const SizedBox(height: 32),

            // COVID Compliance
            _buildCovidCompliance(isTabletOrDesktop),

            const SizedBox(height: 24),

            // Signature Section
            _buildSignatureSection(isTabletOrDesktop),

            const SizedBox(height: 32),

            // Action Buttons
            _buildActionButtons(context, isTabletOrDesktop),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF6B7280)),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF374151),
          ),
        ),
      ],
    );
  }

  Widget _buildVisitorDetails(VisitorDashboardController controller) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          const Text(
            'Visitor Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Purpose of Visit', controller.visitor.purpose),
          _buildDetailRow('Host', controller.visitor.host!.name),
          _buildDetailRow('Status', controller.visitor.status),
          _buildDetailRow(
              'Signed In', controller.visitor.signedIn?.toString() ?? 'N/A'),
          _buildDetailRow(
              'Signed Out', controller.visitor.signedOut?.toString() ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitHistory() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          const Text(
            'Visit History',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          _buildHistoryRow(
              '22 July 2024', 'Meeting', 'Alice Johnson', '09:00 AM - 10:30 AM'),
          _buildHistoryRow(
              '15 July 2024', 'Delivery', 'David Wong', '02:00 PM - 02:15 PM'),
          _buildHistoryRow(
              '01 July 2024', 'Vendor', 'Sarah Parker', '11:00 AM - 12:00 PM'),
        ],
      ),
    );
  }

  Widget _buildHistoryRow(
      String date, String purpose, String host, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(date,
                  style: const TextStyle(color: Color(0xFF374151)))),
          Expanded(
              flex: 2,
              child: Text(purpose,
                  style: const TextStyle(color: Color(0xFF374151)))),
          Expanded(
              flex: 2,
              child:
                  Text(host, style: const TextStyle(color: Color(0xFF374151)))),
          Expanded(
              flex: 2,
              child:
                  Text(time, style: const TextStyle(color: Color(0xFF374151)))),
        ],
      ),
    );
  }

  Widget _buildVisitorHeader(
      bool isTabletOrDesktop, VisitorDashboardController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Image
        Container(
          width: isTabletOrDesktop ? 80 : 64,
          height: isTabletOrDesktop ? 80 : 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(controller.visitor.photo ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Visitor Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Visitor ID ',
                    style: TextStyle(
                      fontSize: isTabletOrDesktop ? 16 : 14,
                      color: Colors.blue[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'B03D7282',
                    style: TextStyle(
                      fontSize: isTabletOrDesktop ? 16 : 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                'May 25 2025 01:00 PM IST',
                style: TextStyle(
                  fontSize: isTabletOrDesktop ? 14 : 12,
                  color: Colors.grey[500],
                ),
              ),

              const SizedBox(height: 8),

              Text(
                controller.visitor.name,
                style: TextStyle(
                  fontSize: isTabletOrDesktop ? 28 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'From Prisa Enterprises',
                style: TextStyle(
                  fontSize: isTabletOrDesktop ? 16 : 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsGrid(
      bool isTabletOrDesktop, VisitorDashboardController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = isTabletOrDesktop ? 2 : 1;

        if (isTabletOrDesktop && constraints.maxWidth > 700) {
          crossAxisCount = 2;
        } else if (!isTabletOrDesktop) {
          crossAxisCount = 1;
        }

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          childAspectRatio: isTabletOrDesktop ? 5 : 6,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDetailItem('Purpose', controller.visitor.purpose),
            _buildDetailItem('Meeting with', controller.visitor.host!.name),
            _buildDetailItem('Profession', 'Technician Engineer'),
            _buildDetailItem('Company', 'Prisa Enterprises'),
            _buildDetailItem('Mobile No.', '+91 8990756046'),
            _buildDetailItem('Email Id', 'devesh.rajpoot@prisa.com'),
            _buildDetailItem('ID proof', 'Aadhaar Card'),
            _buildDetailItem('ID Proof NO.', '8845 6575 9215'),
          ],
        );
      },
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildIdProofSection(bool isTabletOrDesktop) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ID Proof Image
        Expanded(
          flex: isTabletOrDesktop ? 1 : 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ID proof Image',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: isTabletOrDesktop ? 150 : 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1586281010691-6ca79d47b3db?w=300&h=200&fit=crop'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 24),

        // E-Pass QR
        Expanded(
          flex: isTabletOrDesktop ? 1 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'E-Pass QR',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: isTabletOrDesktop ? 150 : 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Center(
                  child: Icon(
                    Icons.qr_code,
                    size: isTabletOrDesktop ? 80 : 60,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCovidCompliance(bool isTabletOrDesktop) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Handle COVID compliance click
            },
            child: Text(
              'Click Here',
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: isTabletOrDesktop ? 16 : 14,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'to COVID-19 Health & Safety Compliance',
            style: TextStyle(
              fontSize: isTabletOrDesktop ? 14 : 12,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Date of Pass Generation: May 23 2025 05:07 PM IST',
            style: TextStyle(
              fontSize: isTabletOrDesktop ? 12 : 11,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureSection(bool isTabletOrDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'SyncTrackr',
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: isTabletOrDesktop ? 14 : 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Mutual Non-Disclosure Consent',
              style: TextStyle(
                fontSize: isTabletOrDesktop ? 14 : 12,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: isTabletOrDesktop ? 120 : 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'Digital Signature',
              style: TextStyle(
                fontSize: isTabletOrDesktop ? 24 : 20,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isTabletOrDesktop) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // Handle resend mail
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mail resent successfully')),
              );
            },
            icon: Icon(Icons.mail_outline,
                size: isTabletOrDesktop ? 20 : 18),
            label: Text(
              'Resend mail',
              style: TextStyle(fontSize: isTabletOrDesktop ? 16 : 14),
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: isTabletOrDesktop ? 16 : 14,
                horizontal: 24,
              ),
              side: BorderSide(color: Colors.grey[400]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Handle print
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Printing visitor pass...')),
              );
            },
            icon: Icon(Icons.print, size: isTabletOrDesktop ? 20 : 18),
            label: Text(
              'Print',
              style: TextStyle(fontSize: isTabletOrDesktop ? 16 : 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: isTabletOrDesktop ? 16 : 14,
                horizontal: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
