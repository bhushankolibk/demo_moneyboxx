import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moneybox_task/core/constants/image_constants.dart';
import 'package:moneybox_task/core/route_config/route_name.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../../../core/utils/widgets/mb_elevated_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _phoneController = TextEditingController();
  late Animation<double> _scaleAnimation;
  bool _showInput = false;

  @override
  void initState() {
    super.initState();
    // Splash Reveal Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward().then((_) {
      setState(() => _showInput = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Expanded(
            child: Center(
              // Use the existing scale animation for a smoother logo reveal
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  ImageConstants.logo,
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutExpo,
            height: _showInput ? MediaQuery.of(context).size.height * 0.45 : 0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 16,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showInput ? 1.0 : 0.0,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Welcome back",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Sign in to continue to your account",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      style: TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Mobile number",
                        prefixIcon: Icon(Icons.phone, color: AppColors.primary),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: MBElevatedButton(
                        onPressed: () {
                          final sanitized = _validateAndSanitizePhone(context);
                          if (sanitized == null) return;
                          _phoneController.text = sanitized;
                          FocusScope.of(context).unfocus();
                          context.pushNamed(
                            RouteName.otp,
                            queryParameters: {'phone': _phoneController.text},
                          );
                          return;
                        },

                        label: "Get OTP",
                      ),
                    ),
                    const SizedBox(height: 12),

                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "By continuing, you agree to our ",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          children: [
                            TextSpan(
                              text: "Terms",
                              style: TextStyle(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: " & "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: "."),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _validateAndSanitizePhone(BuildContext context) {
    final raw = _phoneController.text.trim();
    if (raw.isEmpty) {
      Utils.showSnackBar(
        'Please enter your mobile number',
        context,
        behavior: SnackBarBehavior.floating,
      );
      return null;
    }

    final sanitized = raw.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');

    final isValid = RegExp(r'^[0-9]{10}$').hasMatch(sanitized);
    if (!isValid) {
      Utils.showSnackBar(
        'Please enter a valid 10-digit mobile number',
        context,
        behavior: SnackBarBehavior.floating,
      );
      return null;
    }

    return sanitized;
  }
}
