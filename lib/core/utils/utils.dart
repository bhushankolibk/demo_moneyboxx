import 'package:flutter/material.dart';
import 'package:moneybox_task/core/constants/image_constants.dart';
import 'package:moneybox_task/core/theme/app_colors.dart';

class Utils {
  Utils._();

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  static void showSnackBar(
    String message,
    BuildContext context, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    bool clearPrevious = true,
    SnackBarBehavior? behavior,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
        behavior: behavior,
      ),
    );
  }

  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String content,
    required String confirmText,
    required Color confirmColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(content),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(confirmText, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  static Widget dashboardLoader({
    String label = 'Loading dashboard...',
    Color? color,
    String? assetPath,
    double outerSize = 120,
    double innerSize = 80,
    double strokeWidth = 6,
  }) {
    final loaderColor = color ?? AppColors.primary;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: outerSize,
              width: outerSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: innerSize,
                    width: innerSize,
                    child: CircularProgressIndicator(
                      strokeWidth: strokeWidth,
                      valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
                    ),
                  ),
                  ImageIcon(
                    AssetImage(ImageConstants.icon),
                    size: outerSize,
                    color: loaderColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: loaderColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
