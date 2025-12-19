import 'package:flutter/material.dart';
import 'form_inputs.dart';

class ApplicantStepForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController panController;
  final TextEditingController aadhaarController;
  final TextEditingController mobileController;
  final TextEditingController emailController;

  const ApplicantStepForm({
    super.key,
    required this.nameController,
    required this.panController,
    required this.aadhaarController,
    required this.mobileController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header
        const SectionHeader(title: "Step 2: Applicant Details"),
        const SizedBox(height: 20),

        // 2. Form Fields
        CustomTextField(
          label: "Full Name",
          hint: "e.g. Rahul Kumar",
          controller: nameController,
        ),
        const SizedBox(height: 16),

        CustomTextField(
          label: "PAN Number",
          hint: "ABCDE1234F",
          isUpperCase: true, // Forces uppercase for PAN
          controller: panController,
          onChanged: (val) {
            // Keep only alphanumeric and enforce 10-character limit
            final filtered = val.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
            final limited = filtered.length > 10
                ? filtered.substring(0, 10)
                : filtered;

            // Update controller only when formatting changed to avoid infinite loops
            if (limited != val) {
              panController.value = TextEditingValue(
                text: limited,
                selection: TextSelection.collapsed(offset: limited.length),
              );
            }
          },
        ),
        const SizedBox(height: 16),

        CustomTextField(
          label: "Aadhaar Number",
          hint: "XXXX-XXXX-1234",
          isNumber: true, // Shows numeric keyboard
          controller: aadhaarController,
          onChanged: (val) {
            // Keep only digits and enforce 12-digit limit
            final digits = val.replaceAll(RegExp(r'\D'), '');
            final limited = digits.length > 12
                ? digits.substring(0, 12)
                : digits;

            // Format into groups of 4 with hyphens: 1234-5678-9012
            final buffer = StringBuffer();
            for (var i = 0; i < limited.length; i++) {
              if (i != 0 && i % 4 == 0) buffer.write('-');
              buffer.write(limited[i]);
            }
            final formatted = buffer.toString();

            // Update controller only when formatting changed to avoid infinite loops
            if (formatted != val) {
              aadhaarController.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.collapsed(offset: formatted.length),
              );
            }
          },
          validator: (val) {
            final digits = val?.replaceAll(RegExp(r'\D'), '') ?? '';
            if (digits.length != 12) return 'Aadhaar must be 12 digits';
            return null;
          },
        ),
        const SizedBox(height: 16),

        CustomTextField(
          label: "Mobile Number",
          hint: "9876543210",
          isNumber: true,
          controller: mobileController,
          onChanged: (val) {
            final digits = val.replaceAll(RegExp(r'\D'), '');
            final limited = digits.length > 10
                ? digits.substring(0, 10)
                : digits;

            if (limited != val) {
              mobileController.value = TextEditingValue(
                text: limited,
                selection: TextSelection.collapsed(offset: limited.length),
              );
            }
          },
        ),
        const SizedBox(height: 16),

        CustomTextField(
          label: "Email Address",
          hint: "rahul@example.com",
          isEmail: true, // Shows email keyboard
          controller: emailController,
        ),

        // Add padding at bottom to ensure content isn't hidden behind floating buttons
        const SizedBox(height: 80),
      ],
    );
  }
}
