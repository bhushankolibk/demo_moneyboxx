import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moneybox_task/core/constants/app_constants.dart';
import 'package:moneybox_task/core/constants/image_constants.dart';
import 'package:moneybox_task/core/manager/shared_prefs_manager.dart';
import 'package:moneybox_task/core/route_config/route_name.dart';
import 'package:moneybox_task/core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
    navigateToLogin();
  }

  void navigateToLogin() async {
    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;
      final isLoggedIn = await SharedPrefsManager.instance.getBool(
        AppConstants.isLogin,
      );
      if (isLoggedIn != null && isLoggedIn) {
        context.go(RouteName.dashboard);
        return;
      } else {
        context.go(RouteName.login);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImageConstants.logo,
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
