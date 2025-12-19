import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'form_inputs.dart';

class BusinessStepForm extends StatelessWidget {
  final TextEditingController nameController;
  final String? initialBusinessType;
  final TextEditingController registrationController;
  final TextEditingController yearsInOperationController;
  final Function(String?) onTypeChanged;

  const BusinessStepForm({
    super.key,
    required this.nameController,
    this.initialBusinessType,
    required this.registrationController,
    required this.yearsInOperationController,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Step 1: Business Details"),
        const SizedBox(height: 20),

        // 1. Attach Controller here
        CustomTextField(
          label: "Business Name",
          hint: "Enter business name",
          controller: nameController, // Pass it to your custom widget
        ),
        const SizedBox(height: 16),

        // 2. Set Initial Value for Dropdown
        CustomDropdown(
          label: "Business Type",
          items: const ["Sole Proprietorship", "Partnership", "Pvt Ltd", "LLP"],
          initialValue:
              initialBusinessType, // Ensure CustomDropdown accepts this
          onChanged: onTypeChanged,
        ),
        const SizedBox(height: 16),

        CustomTextField(
          label: "Registration No.",
          hint: "e.g. REG123456",
          controller: registrationController,
        ),
        const SizedBox(height: 16),

        CustomTextField(
          label: "Years in Operation",
          hint: "e.g. 5",
          isNumber: true,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ], // Allow only digits
          controller: yearsInOperationController,
        ),
      ],
    );
  }
}
