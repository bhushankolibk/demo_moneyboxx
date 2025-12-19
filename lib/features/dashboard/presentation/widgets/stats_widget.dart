import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneybox_task/core/theme/app_colors.dart';

import '../bloc/dashboard_bloc.dart';

class StatsWidget extends StatelessWidget {
  final DashboardLoaded state;

  const StatsWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '₹',
      locale: 'en_IN',
    );
    final totalAmount = currencyFormatter.format(
      state.stats.totalDisbursedAmount,
    );

    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _buildStatCard(
            "Total Disbursed",
            totalAmount,
            AppColors.primary,
            true,
          ),
          _buildStatCard(
            "Approved",
            state.stats.approvedApplications.toString(),
            AppColors.success,
            false,
          ),
          _buildStatCard(
            "Pending",
            state.stats.pendingApplications.toString(),
            AppColors.warning,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, bool isWide) {
    return Container(
      width: isWide ? 170 : 130,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withAlpha(204)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(30),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              title == "Total Disbursed"
                  ? Icons.account_balance_wallet
                  : title == "Approved"
                  ? Icons.check_circle
                  : Icons.pending_actions,
              color: Colors.white,
              size: 20,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isWide ? 22 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withAlpha(230),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
