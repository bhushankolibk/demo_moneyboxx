import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moneybox_task/core/theme/app_colors.dart';
import 'package:moneybox_task/core/theme/bloc/theme_bloc.dart';
import 'package:moneybox_task/core/utils/utils.dart';

import '../../core/constants/app_constants.dart';
import '../../core/manager/shared_prefs_manager.dart';
import '../../core/route_config/route_name.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(color: AppColors.primary),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.background,
                  radius: 28,
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'MoneyBox',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Home
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.pop();
            },
          ),

          // Theme toggle
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return SwitchListTile.adaptive(
                secondary: const Icon(Icons.brightness_6),
                title: const Text('Theme'),
                value: state.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  context.read<ThemeBloc>().add(ToggleTheme());
                },
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              final confirmed =
                  await Utils.showConfirmationDialog(
                    context,
                    title: "Confirm logout",
                    content: "Are you sure you want to log out?",
                    confirmText: "Logout",
                    confirmColor: AppColors.error,
                  ) ??
                  false;

              if (!confirmed) return;

              context.pop();
              SharedPrefsManager.instance.setBool(AppConstants.isLogin, false);
              context.go(RouteName.login);
            },
          ),

          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Text(
              'Version 1.0.0',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
