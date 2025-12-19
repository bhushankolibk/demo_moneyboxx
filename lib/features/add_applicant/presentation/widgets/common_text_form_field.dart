import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const CommonTextFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
            hintText: hintText,
          ),
          onChanged: onChanged,
          validator: validator,
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: keyboardType,
          autofocus: false,
          inputFormatters: inputFormatters,
        ),

        Text(errorText ?? '', style: const TextStyle(color: Colors.red)),
      ],
    );
  }
}
