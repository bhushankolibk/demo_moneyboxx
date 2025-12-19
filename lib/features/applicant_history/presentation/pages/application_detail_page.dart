// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:moneybox_task/core/theme/app_colors.dart';
import 'package:moneybox_task/features/applicant_history/presentation/widgets/timeline_section_widget.dart';
import '../../domain/entities/applicant_history_entity.dart';

class ApplicationDetailsPage extends StatefulWidget {
  final ApplicationHistoryEntity application;

  const ApplicationDetailsPage({super.key, required this.application});

  @override
  State<ApplicationDetailsPage> createState() => _ApplicationDetailsPageState();
}

class _ApplicationDetailsPageState extends State<ApplicationDetailsPage> {
  // Collapsible State Tracking
  bool _isBusinessExpanded = true;
  bool _isApplicantExpanded = false;
  bool _isLoanExpanded = false;

  @override
  Widget build(BuildContext context) {
    final app = widget.application;
    final currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF0A2472),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Hero(
                tag: 'title_${app.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    app.businessName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF0A2472), Color(0xFF0D47A1)],
                  ),
                ),
                child: Center(
                  child: Opacity(
                    opacity: 0.1,
                    child: Icon(Icons.business, size: 100, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 2. Timeline View ---
                  TimelineSectionWidget(app: app),
                  // _buildTimelineSection(app),
                  const SizedBox(height: 24),

                  // --- 3. Collapsible Sections ---
                  _buildSectionHeader(
                    "Business Information",
                    _isBusinessExpanded,
                    () {
                      setState(
                        () => _isBusinessExpanded = !_isBusinessExpanded,
                      );
                    },
                  ),
                  _buildCollapsibleContent(_isBusinessExpanded, [
                    _buildDetailRow("Business Type", app.businessType),
                    _buildDetailRow("Registration No.", app.registrationNumber),
                    _buildDetailRow(
                      "Years in Operation",
                      "${app.yearsInOperation} Years",
                    ),
                  ]),

                  const SizedBox(height: 16),

                  _buildSectionHeader(
                    "Applicant Details",
                    _isApplicantExpanded,
                    () {
                      setState(
                        () => _isApplicantExpanded = !_isApplicantExpanded,
                      );
                    },
                  ),
                  _buildCollapsibleContent(_isApplicantExpanded, [
                    _buildDetailRow("Applicant Name", app.applicantName),
                    _buildDetailRow("Mobile Number", app.phone),
                    _buildDetailRow("Email", app.email),
                    _buildDetailRow("PAN Number", app.pan),
                  ]),

                  const SizedBox(height: 16),

                  _buildSectionHeader("Loan Request", _isLoanExpanded, () {
                    setState(() => _isLoanExpanded = !_isLoanExpanded);
                  }),
                  _buildCollapsibleContent(_isLoanExpanded, [
                    _buildDetailRow(
                      "Requested Amount",
                      currencyFormat.format(app.requestedAmount),
                      isBold: true,
                    ),
                    _buildDetailRow("Tenure", "${app.tenure} Months"),
                    _buildDetailRow("Purpose", app.purpose.join(", ")),
                    if (app.status.toLowerCase() == 'rejected' &&
                        app.rejectionReason != null)
                      _buildDetailRow(
                        "Rejection Reason",
                        app.rejectionReason!,
                        color: Colors.red,
                      ),
                  ]),

                  const SizedBox(height: 100), // Spacing for floating buttons
                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildActionButtons(context, app),
    );
  }

  Widget _buildSectionHeader(
    String title,
    bool isExpanded,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isExpanded
              ? const BorderRadius.vertical(top: Radius.circular(12))
              : BorderRadius.circular(12),
          boxShadow: [
            if (!isExpanded)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollapsibleContent(bool isExpanded, List<Widget> children) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: isExpanded ? null : 0,
      padding: isExpanded ? const EdgeInsets.all(16) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: isExpanded ? Column(children: children) : null,
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isBold = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color:
                    color ??
                    (isBold ? const Color(0xFF0A2472) : Colors.black87),
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildActionButtons(
    BuildContext context,
    ApplicationHistoryEntity app,
  ) {
    // Only show buttons if pending/under review and NOT a local draft
    final isActive =
        !app.isLocalDraft &&
        (app.status.toLowerCase() == 'pending' ||
            app.status.toLowerCase() == 'under_review');

    if (!isActive) return null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.background,
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Reject"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success, // Green
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Approve",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
