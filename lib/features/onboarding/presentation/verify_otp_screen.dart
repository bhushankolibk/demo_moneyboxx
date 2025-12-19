import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:moneybox_task/core/manager/shared_prefs_manager.dart';
import 'package:moneybox_task/core/utils/utils.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/route_config/route_name.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/widgets/mb_elevated_button.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage>
    with SingleTickerProviderStateMixin {
  static const int _otpLength = 6;
  static const int _timerDuration = 30;

  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  int _secondsRemaining = _timerDuration;
  bool _isTimerRunning = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _startTimer();
  }

  void _initializeControllers() {
    _controllers = List.generate(
      _otpLength,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(_otpLength, (index) => FocusNode());
  }

  void _startTimer() {
    _secondsRemaining = _timerDuration;
    _isTimerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _isTimerRunning = false;
          timer.cancel();
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpDigitChanged(String value, int index) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    if (_getOtp().length == _otpLength) {
      FocusScope.of(context).unfocus();
    }
    setState(() {});
  }

  String _getOtp() {
    return _controllers.map((e) => e.text).join();
  }

  void _verifyOtp() {
    final otp = _getOtp();
    if (otp.length != _otpLength) {
      Utils.showSnackBar("Please enter a complete 6-digit OTP", context);

      return;
    }

    Utils.showSnackBar(
      "Successfully verified...",
      context,
      backgroundColor: AppColors.success,
      behavior: SnackBarBehavior.floating,
    );

    SharedPrefsManager.instance.setBool(AppConstants.isLogin, true);
    context.push(RouteName.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Verification",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "Enter the code sent to ",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  children: [
                    TextSpan(
                      text: widget.phoneNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // OTP Input Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  _otpLength,
                  (index) => _buildOtpBox(index),
                ),
              ),

              const SizedBox(height: 40),

              Center(
                child: _isTimerRunning
                    ? Text(
                        "Resend code in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _startTimer();
                        },
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: MBElevatedButton(
                  onPressed: _getOtp().length == _otpLength ? _verifyOtp : null,
                  label: "Verify & Proceed",
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _focusNodes[index].hasFocus
              ? AppColors.secondary
              : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          if (_focusNodes[index].hasFocus)
            BoxShadow(
              color: AppColors.secondary.withAlpha(50),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          decoration: const InputDecoration(
            counterText: "", // Hide character counter
            border: InputBorder.none,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) => _onOtpDigitChanged(value, index),
        ),
      ),
    );
  }
}
