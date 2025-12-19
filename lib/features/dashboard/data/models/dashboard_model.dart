import 'package:moneybox_task/features/dashboard/domain/entities/dashboard_stats_entity.dart';

class DashboardModel {
  DashboardStats dashboardStats;

  DashboardModel({required this.dashboardStats});

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    dashboardStats: DashboardStats.fromJson(json["dashboard_stats"]),
  );

  Map<String, dynamic> toJson() => {"dashboard_stats": dashboardStats.toJson()};

  DashboardStatsEntity toEntity() {
    return DashboardStatsEntity(
      totalApplications: _toInt(dashboardStats.totalApplications),
      approvedApplications: _toInt(dashboardStats.approvedApplications),
      pendingApplications: _toInt(dashboardStats.pendingApplications),
      underReviewApplications: _toInt(dashboardStats.underReviewApplications),
      rejectedApplications: _toInt(dashboardStats.rejectedApplications),
      disbursedApplications: _toInt(dashboardStats.disbursedApplications),
      totalDisbursedAmount: _toInt(dashboardStats.totalDisbursedAmount),
      totalRequestedAmount: _toInt(dashboardStats.totalRequestedAmount),
      averageLoanAmount: _toInt(dashboardStats.averageLoanAmount),
      approvalRate: _toInt(dashboardStats.approvalRate),
      monthlyTrends: dashboardStats.monthlyTrends
          .map(
            (t) => MonthlyTrend(
              month: t.month,
              applications: _toInt(t.applications),
              approved: _toInt(t.approved),
              disbursed: _toInt(t.disbursed),
            ),
          )
          .toList(),
      loansByPurpose: dashboardStats.loansByPurpose
          .map(
            (p) => LoanByPurpose(
              purpose: p.purpose,
              count: _toInt(p.count),
              totalAmount: _toInt(p.totalAmount),
            ),
          )
          .toList(),
      loansByBusinessType: dashboardStats.loansByBusinessType
          .map(
            (b) => LoanByBusinessType(
              type: b.type,
              count: _toInt(b.count),
              percentage: b.percentage.toDouble(),
            ),
          )
          .toList(),
    );
  }
}

class DashboardStats {
  int totalApplications;
  int approvedApplications;
  int pendingApplications;
  int underReviewApplications;
  int rejectedApplications;
  int disbursedApplications;
  int totalDisbursedAmount;
  int totalRequestedAmount;
  int averageLoanAmount;
  int approvalRate;
  List<MonthlyTrendModel> monthlyTrends;
  List<LoansByPurposeModel> loansByPurpose;
  List<LoansByBusinessTypeModel> loansByBusinessType;

  DashboardStats({
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

  factory DashboardStats.fromJson(Map<String, dynamic> json) => DashboardStats(
    totalApplications: json["totalApplications"],
    approvedApplications: json["approvedApplications"],
    pendingApplications: json["pendingApplications"],
    underReviewApplications: json["underReviewApplications"],
    rejectedApplications: json["rejectedApplications"],
    disbursedApplications: json["disbursedApplications"],
    totalDisbursedAmount: json["totalDisbursedAmount"],
    totalRequestedAmount: json["totalRequestedAmount"],
    averageLoanAmount: json["averageLoanAmount"],
    approvalRate: json["approvalRate"],
    monthlyTrends: List<MonthlyTrendModel>.from(
      json["monthlyTrends"].map((x) => MonthlyTrendModel.fromJson(x)),
    ),
    loansByPurpose: List<LoansByPurposeModel>.from(
      json["loansByPurpose"].map((x) => LoansByPurposeModel.fromJson(x)),
    ),
    loansByBusinessType: List<LoansByBusinessTypeModel>.from(
      json["loansByBusinessType"].map(
        (x) => LoansByBusinessTypeModel.fromJson(x),
      ),
    ),
  );

  Map<String, dynamic> toJson() => {
    "totalApplications": totalApplications,
    "approvedApplications": approvedApplications,
    "pendingApplications": pendingApplications,
    "underReviewApplications": underReviewApplications,
    "rejectedApplications": rejectedApplications,
    "disbursedApplications": disbursedApplications,
    "totalDisbursedAmount": totalDisbursedAmount,
    "totalRequestedAmount": totalRequestedAmount,
    "averageLoanAmount": averageLoanAmount,
    "approvalRate": approvalRate,
    "monthlyTrends": List<dynamic>.from(monthlyTrends.map((x) => x.toJson())),
    "loansByPurpose": List<dynamic>.from(loansByPurpose.map((x) => x.toJson())),
    "loansByBusinessType": List<dynamic>.from(
      loansByBusinessType.map((x) => x.toJson()),
    ),
  };
}

class LoansByBusinessTypeModel {
  String type;
  int count;
  int percentage;

  LoansByBusinessTypeModel({
    required this.type,
    required this.count,
    required this.percentage,
  });

  factory LoansByBusinessTypeModel.fromJson(Map<String, dynamic> json) =>
      LoansByBusinessTypeModel(
        type: json["type"],
        count: json["count"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
    "type": type,
    "count": count,
    "percentage": percentage,
  };
}

class LoansByPurposeModel {
  String purpose;
  int count;
  int totalAmount;

  LoansByPurposeModel({
    required this.purpose,
    required this.count,
    required this.totalAmount,
  });

  factory LoansByPurposeModel.fromJson(Map<String, dynamic> json) =>
      LoansByPurposeModel(
        purpose: json["purpose"],
        count: json["count"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
    "purpose": purpose,
    "count": count,
    "totalAmount": totalAmount,
  };
}

class MonthlyTrendModel {
  String month;
  int applications;
  int approved;
  int disbursed;

  MonthlyTrendModel({
    required this.month,
    required this.applications,
    required this.approved,
    required this.disbursed,
  });

  factory MonthlyTrendModel.fromJson(Map<String, dynamic> json) =>
      MonthlyTrendModel(
        month: json["month"],
        applications: json["applications"],
        approved: json["approved"],
        disbursed: json["disbursed"],
      );

  Map<String, dynamic> toJson() => {
    "month": month,
    "applications": applications,
    "approved": approved,
    "disbursed": disbursed,
  };
}

int _toInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}
