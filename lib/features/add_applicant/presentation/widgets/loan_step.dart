import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'form_inputs.dart'; // Ensure CustomDropdown is imported from here

class LoanStepForm extends StatefulWidget {
  final double initialAmount;
  final String initialTenure;
  final String initialPurpose;
  final Function(double amount, String tenure, String purpose)
  onLoanDetailsChanged;

  const LoanStepForm({
    super.key,
    required this.initialAmount,
    required this.initialTenure,
    required this.initialPurpose,
    required this.onLoanDetailsChanged,
  });

  @override
  State<LoanStepForm> createState() => _LoanStepFormState();
}

class _LoanStepFormState extends State<LoanStepForm> {
  late double _loanAmount;
  late String _tenure;
  late String _selectedPurpose;

  @override
  void initState() {
    super.initState();
    // 1. Initialize local state from the passed Draft/BLoC data
    _loanAmount = widget.initialAmount;
    _tenure = widget.initialTenure;
    _selectedPurpose = widget.initialPurpose;
  }

  /// Helper to send updated data back to the Parent Page
  void _notifyParent() {
    widget.onLoanDetailsChanged(_loanAmount, _tenure, _selectedPurpose);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Step 3: Loan Requirements"),
        const SizedBox(height: 24),

        // --- Slider Section ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Loan Amount", style: TextStyle(fontWeight: FontWeight.w500)),
            Text(
              "₹${_loanAmount.toInt()}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        Slider(
          value: _loanAmount,
          min: 50000, // Adjusted min to be realistic
          max: 5000000,
          divisions: 100,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.textSecondary,
          onChanged: (val) {
            setState(() => _loanAmount = val);
            _notifyParent();
          },
        ),

        // Manual Input Box (Display Only)
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text("₹${_loanAmount.toInt()}", textAlign: TextAlign.right),
          ),
        ),

        const SizedBox(height: 24),

        // --- Tenure Dropdown ---
        // Ensure your CustomDropdown in 'form_inputs.dart' accepts 'value' and 'onChanged'
        CustomDropdown(
          label: "Tenure (Month)",
          items: const ["12", "24", "36", "48", "60"],
          initialValue: _tenure, // Pass current state
          onChanged: (val) {
            if (val != null) {
              setState(() => _tenure = val);
              _notifyParent();
            }
          },
        ),

        const SizedBox(height: 24),

        // --- Purpose Choice Chips ---
        Text(
          "Purpose",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: ["Working Capital", "Expansion", "Equipment", "Inventory"]
              .map((purpose) {
                final isSelected = _selectedPurpose == purpose;
                return ChoiceChip(
                  label: Text(purpose),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.grey[300]!,
                    ),
                  ),
                  onSelected: (val) {
                    if (val) {
                      setState(() => _selectedPurpose = purpose);
                      _notifyParent();
                    }
                  },
                );
              })
              .toList(),
        ),

        // Bottom padding to ensure UI isn't covered by buttons
        const SizedBox(height: 80),
      ],
    );
  }
}
