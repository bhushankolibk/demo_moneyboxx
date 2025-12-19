// lib/features/dashboard/domain/entities/dashboard_stats_entity.dart

class DashboardStatsEntity {
  final int totalApplications;
  final int approvedApplications;
  final int pendingApplications;
  final int underReviewApplications;
  final int rejectedApplications;
  final int disbursedApplications;
  final int totalDisbursedAmount;
  final int totalRequestedAmount;
  final int averageLoanAmount;
  final int approvalRate;
  final List<MonthlyTrend> monthlyTrends;
  final List<LoanByPurpose> loansByPurpose;
  final List<LoanByBusinessType> loansByBusinessType;

  const DashboardStatsEntity({
    required this.totalApplications,
    required this.approvedApplications,
    required this.pendingApplications,
    required this.underReviewApplications,
    required this.rejectedApplications,
    required this.disbursedApplications,
    required this.totalDisbursedAmount,
    required this.totalRequestedAmount,
    required this.averageLoanAmount,
    required this.approvalRate,
    required this.monthlyTrends,
    required this.loansByPurpose,
    required this.loansByBusinessType,
  });
}

class MonthlyTrend {
  final String month;
  final int applications;
  final int approved;
  final int disbursed;

  const MonthlyTrend({
    required this.month,
    required this.applications,
    required this.approved,
    required this.disbursed,
  });
}

class LoanByPurpose {
  final String purpose;
  final int count;
  final int totalAmount;

  const LoanByPurpose({
    required this.purpose,
    required this.count,
    required this.totalAmount,
  });
}

class LoanByBusinessType {
  final String type;
  final int count;
  final double percentage;

  const LoanByBusinessType({
    required this.type,
    required this.count,
    required this.percentage,
  });
}
