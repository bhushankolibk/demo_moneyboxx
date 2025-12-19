import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/loan_applicant_entity.dart';
import 'form_inputs.dart';

class ReviewStepForm extends StatelessWidget {
  final LoanApplicationEntity data;
  final Function(int) onEditPressed;

  const ReviewStepForm({
    super.key,
    required this.data,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Currency Formatter for clean display (e.g., ₹10,00,000)
    final currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Step 4: Review & Submit"),
        const SizedBox(height: 20),

        // --- Step 1: Business Details ---
        _buildReviewCard(
          title: "Business Details",
          content: _buildBusinessSummary(),
          stepIndex: 0,
        ),
        const SizedBox(height: 16),

        // --- Step 2: Applicant Details ---
        _buildReviewCard(
          title: "Applicant Details",
          content: _buildApplicantSummary(),
          stepIndex: 1,
        ),
        const SizedBox(height: 16),

        // --- Step 3: Loan Details ---
        _buildReviewCard(
          title: "Loan Details",
          content: _buildLoanSummary(currencyFormat),
          stepIndex: 2,
        ),

        // Spacing for floating button area
        const SizedBox(height: 80),
      ],
    );
  }

  /// Helper to format Business Data
  String _buildBusinessSummary() {
    final name = data.businessName?.isNotEmpty == true
        ? data.businessName
        : "Not specified";
    final type = data.businessType?.isNotEmpty == true
        ? data.businessType
        : "-";
    final reg = data.registrationNumber?.isNotEmpty == true
        ? "Reg: ${data.registrationNumber}"
        : "";

    return "$name\n$type\n$reg".trim();
  }

  /// Helper to format Applicant Data
  String _buildApplicantSummary() {
    final name = data.applicantName?.isNotEmpty == true
        ? data.applicantName
        : "Not specified";
    final mobile = data.mobileNumber?.isNotEmpty == true
        ? data.mobileNumber
        : "";
    final email = data.emailAddress?.isNotEmpty == true
        ? data.emailAddress
        : "";

    // Combine non-empty strings
    return [name, mobile, email].where((s) => s!.isNotEmpty).join("\n");
  }

  /// Helper to format Loan Data
  String _buildLoanSummary(NumberFormat formatter) {
    final amount = data.loanAmount != null
        ? formatter.format(data.loanAmount)
        : "₹0";
    final tenure = data.tenure ?? "-";
    final purpose = (data.loanPurpose != null && data.loanPurpose!.isNotEmpty)
        ? data.loanPurpose!.first
        : "-";

    return "$amount, $tenure\n$purpose";
  }

  Widget _buildReviewCard({
    required String title,
    required String content,
    required int stepIndex,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
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
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.primary,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                tooltip: "Edit $title",
                onPressed: () => onEditPressed(stepIndex),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              color: Colors.grey[800],
              height: 1.5,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
