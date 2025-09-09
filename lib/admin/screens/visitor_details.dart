import 'dart:convert';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/controllers/visitor_details_controller.dart';
import 'package:synctrackr/admin/models/visitor_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';
import 'package:synctrackr/core/constants/app_barrels.dart';

class VisitorDetailsScreen extends StatefulWidget {
  final int visitorId;

  const VisitorDetailsScreen({super.key, required this.visitorId});

  @override
  State<VisitorDetailsScreen> createState() => _VisitorDetailsScreenState();
}

class _VisitorDetailsScreenState extends State<VisitorDetailsScreen> {
  late final VisitorDetailsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(VisitorDetailsController());
    _controller.fetchVisitorDetails(widget.visitorId);
  }

  @override
  void didUpdateWidget(covariant VisitorDetailsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visitorId != oldWidget.visitorId) {
      _controller.fetchVisitorDetails(widget.visitorId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      if (_controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (_controller.errorMessage.isNotEmpty) {
        return Center(child: Text(_controller.errorMessage.value));
      }

      final visitor = _controller.visitor.value;
      if (visitor == null) {
        return const Center(child: Text('No visitor details found.'));
      }

      return Row(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  scrolledUnderElevation: 0.0,
                  flexibleSpace: CommonHeader(title: visitor.name),
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Opacity(
                      opacity: 0.8,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: isDarkMode
                                  ? Colors.white
                                  : adminAppColors.primary),
                          color: isDarkMode
                              ? Colors.black.withOpacity(0.5)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildVisitorInfo(isDarkMode, visitor),
                            const SizedBox(height: 24),
                            _buildVisitorDetails(isDarkMode, visitor),
                            const SizedBox(height: 24),
                            _buildIdAndQrCode(isDarkMode, visitor),
                            const SizedBox(height: 24),
                            _buildComplianceAndConsent(isDarkMode, visitor),
                            const SizedBox(height: 24),
                            _buildActionButtons(isDarkMode),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildVisitorInfo(bool isDarkMode, Visitor visitor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(1), // border ki thickness
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue, // border color
              width: 3, // border width
            ),
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundImage:
                (visitor.photo != null && visitor.photo!.isNotEmpty)
                    ? NetworkImage(visitor.photo!)
                    : const AssetImage('assets/images/profile.jpg')
                        as ImageProvider,
          ),
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visitor ID ${visitor.id}',
              style: GoogleFonts.lexend(
                color: isDarkMode
                    ? adminAppColors.darkPrimary
                    : const Color(0xFF4F46E5),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('MMM dd yyyy hh:mm a').format(visitor.appointmentDate),
              style: GoogleFonts.lexend(
                color: isDarkMode
                    ? adminAppColors.darkTextSecondary
                    : const Color(0xFF6B7280),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              visitor.name,
              style: GoogleFonts.lexend(
                color: isDarkMode
                    ? adminAppColors.darkTextPrimary
                    : const Color(0xFF1F2937),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'From ${visitor.company ?? 'N/A'}',
              style: GoogleFonts.lexend(
                color: isDarkMode
                    ? adminAppColors.darkTextSecondary
                    : const Color(0xFF6B7280),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVisitorDetails(bool isDarkMode, Visitor visitor) {
    return Column(
      children: [
        const DottedLine(
          direction: Axis.horizontal, // Axis.vertical bhi kar sakte ho
          lineLength: double.infinity, // pura width lega
          lineThickness: 1.5,
          dashLength: 6.0,
          dashColor: Colors.grey,
          dashGapLength: 4.0,
          dashGapColor: Colors.transparent,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem('Purpose', visitor.purpose, isDarkMode),
                  const SizedBox(height: 16),
                  _buildDetailItem(
                      'Profession', visitor.profession ?? 'N/A', isDarkMode),
                  const SizedBox(height: 16),
                  _buildDetailItem(
                      'Mobile No.', visitor.phone ?? 'N/A', isDarkMode),
                  const SizedBox(height: 16),
                  _buildDetailItem(
                      'ID proof', visitor.idProof?.type ?? 'N/A', isDarkMode),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem(
                      'Meeting with', visitor.host!.name, isDarkMode),
                  const SizedBox(height: 16),
                  _buildDetailItem(
                      'Company', visitor.company ?? 'N/A', isDarkMode),
                  const SizedBox(height: 16),
                  _buildDetailItem(
                      'Email Id', visitor.email ?? 'N/A', isDarkMode),
                  const SizedBox(height: 16),
                  _buildDetailItem('ID Proof NO.',
                      visitor.idProof?.number ?? 'N/A', isDarkMode),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(String title, String value, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lexend(
            color: isDarkMode ? adminAppColors.darkTextPrimary : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.lexend(
            color: isDarkMode
                ? adminAppColors.darkTextSecondary
                : const Color(0xFF1F2937),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildIdAndQrCode(bool isDarkMode, Visitor visitor) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID proof Image',
                style: GoogleFonts.lexend(
                  color: isDarkMode
                      ? adminAppColors.darkTextPrimary
                      : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              if (visitor.idProof?.image != null)
                Image.network(
                  visitor.idProof!.image!,
                  height: 150,
                  fit: BoxFit.cover,
                )
              else
                Text(
                  'No Image',
                  style: GoogleFonts.lexend(
                      color: isDarkMode ? AppColors.Grey : Colors.black),
                )
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'E-Pass QR',
                style: GoogleFonts.lexend(
                  color: isDarkMode
                      ? adminAppColors.darkTextPrimary
                      : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              if (visitor.ePassQR != null)
                Container(
                  color: Colors.white,
                  child: QrImageView(
                    data: visitor.ePassQR!,
                    version: QrVersions.auto,
                    size: 150.0,
                  ),
                )
              else
                Text(
                  'No QR Code',
                  style: GoogleFonts.lexend(
                      color: isDarkMode ? AppColors.Grey : Colors.black),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceAndConsent(bool isDarkMode, Visitor visitor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDarkMode
                    ? adminAppColors.darkTextPrimary
                    : Colors.black, // default color
              ),
              children: [
                TextSpan(
                  text: 'Click Here',
                  style: GoogleFonts.lexend(
                      fontWeight: FontWeight.w600,
                      color: isDarkMode
                          ? adminAppColors.darkPrimary
                          : const Color(0xFF4F46E5),
                      fontSize: 16),
                ),
                TextSpan(
                  text: ' to COVID-19 Health & Safety Compliance',
                  style: GoogleFonts.lexend(
                      fontWeight: FontWeight.w300, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date of Pass Generation:',
              style: GoogleFonts.lexend(
                color: isDarkMode
                    ? adminAppColors.darkTextSecondary
                    : const Color(0xFF6B7280),
                fontSize: 14,
              ),
            ),
            Text(
              DateFormat('MMM dd yyyy hh:mm a').format(visitor.createdAt),
              style: GoogleFonts.inter(
                color: isDarkMode
                    ? adminAppColors.darkTextPrimary
                    : const Color(0xFF1F2937),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const DottedLine(
          direction: Axis.horizontal, // Axis.vertical bhi kar sakte ho
          lineLength: double.infinity, // pura width lega
          lineThickness: 1.5,
          dashLength: 6.0,
          dashColor: Colors.grey,
          dashGapLength: 4.0,
          dashGapColor: Colors.transparent,
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.topLeft,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'SyncTrackr ', // sirf SyncTrackr
                  style: GoogleFonts.lexend(
                      fontWeight: FontWeight.w600,
                      color: isDarkMode
                          ? adminAppColors.darkPrimary
                          : const Color(0xFF4F46E5),
                      fontSize: 16),
                ),
                TextSpan(
                  text: 'Mutual Non-Disclosure Consent', // baaki text
                  style: GoogleFonts.lexend(
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : const Color(0xFF1F2937), // Black
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
                color: isDarkMode
                    ? adminAppColors.darkBorder
                    : const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: _buildSignatureImage(isDarkMode),
          ),
        ),
      ],
    );
  }

  Widget _buildSignatureImage(bool isDarkMode) {
    if (_controller.signatureImage.value == null) {
      return Text(
        'No Signature',
        style: GoogleFonts.inter(
          color: isDarkMode
              ? adminAppColors.darkTextSecondary
              : const Color(0xFF9CA3AF),
          fontSize: 16,
        ),
      );
    }
    try {
      return Image.memory(_controller.signatureImage.value!);
    } catch (e) {
      print('Error decoding signature image: $e');
      return Text(
        'Invalid Signature Image',
        style: GoogleFonts.inter(
          color: Colors.red,
          fontSize: 16,
        ),
      );
    }
  }

  Widget _buildActionButtons(bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.mail_outline,
                color:
                    isDarkMode ? adminAppColors.darkTextPrimary : Colors.black),
            label: Text('Resend mail',
                style: TextStyle(
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : Colors.black)),
            style: OutlinedButton.styleFrom(
              backgroundColor: isDarkMode
                  ? adminAppColors.darkSecondary
                  : adminAppColors.background,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(
                  color: isDarkMode
                      ? adminAppColors.darkPrimary
                      : const Color(0xFF4F46E5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.print_outlined,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
            label: const Text(
              'Print',
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: isDarkMode ? Colors.black : Colors.white,
              backgroundColor: isDarkMode
                  ? adminAppColors.darkPrimary
                  : const Color(0xFF4F46E5),
              padding: const EdgeInsets.symmetric(vertical: 16),
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
