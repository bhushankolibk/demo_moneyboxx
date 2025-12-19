import 'package:flutter/material.dart';
import 'package:moneybox_task/core/theme/app_colors.dart';

/// A reusable elevated button with common customization options.
/// Place this file at: lib/core/utils/widgets/mb_elevated_button.dart
class MBElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final double borderRadius;
  final TextStyle? textStyle;
  final Color? textColor;
  final double height;

  const MBElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6.0,
    this.borderRadius = 12.0,
    this.textStyle,
    this.textColor,
    this.height = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveTextStyle =
        (textStyle ??
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
            .copyWith(color: textColor ?? Colors.white);

    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: foregroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          textStyle: effectiveTextStyle,
        ),
        onPressed: onPressed,
        child: Text(label, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
