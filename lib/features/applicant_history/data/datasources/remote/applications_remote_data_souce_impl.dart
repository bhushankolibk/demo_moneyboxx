import 'dart:convert';

import 'package:moneybox_task/core/database/database_manager.dart';
import 'package:moneybox_task/core/network/api_service.dart';
import 'package:moneybox_task/features/applicant_history/data/models/applicant_history_model.dart';

import 'package:moneybox_task/features/add_applicant/data/models/loan_applicant_model.dart';

import '../../../../../core/constants/app_constants.dart';
import 'applications_remote_data_source.dart';

class ApplicationsRemoteDataSourceImpl implements ApplicationsRemoteDataSource {
  final ApiService apiService;
  ApplicationsRemoteDataSourceImpl({required this.apiService});
  @override
  Future<List<ApplicationHistoryModel>> getApplications() async {
    final response = await apiService.getApplications();
    final Map<String, dynamic> jsonMap = response is String
        ? jsonDecode(response)
        : response;

    final List<ApplicationHistoryModel> applicationsList = [];
    final List<ApplicationHistoryModel> applications =
        ApplicationHistoryModel.listFromApiResponse(jsonMap);
    final db = await DatabaseManager.instance.database;
    final maps = await db.query(AppConstants.tableName);
    var list = maps.map((e) => LoanApplicationModel.fromMap(e)).map((localApp) {
      if (localApp.currentStep == 4) {
        applicationsList.add(
          ApplicationHistoryModel(
            id: localApp.id.toString(),
            status: "draft",
            isLocalDraft: false,
            businessName: localApp.businessName ?? "",
            businessType: localApp.businessType ?? "",
            registrationNumber: localApp.registrationNumber ?? "",
            yearsInOperation:
                int.tryParse(localApp.yearsInOperation.toString()) ?? 0,
            applicantName: localApp.applicantName ?? "",
            pan: localApp.panCard ?? "",
            aadhaar: localApp.aadhaarNumber ?? "",
            phone: localApp.mobileNumber ?? "",
            email: localApp.emailAddress ?? "",
            requestedAmount: localApp.loanAmount ?? 0.0,
            approvedAmount: localApp.loanAmount,
            tenure: int.tryParse(localApp.tenure.toString()) ?? 0,
            interestRate: 0.0,
            purpose: localApp.loanPurpose ?? [],
            rejectionReason: "",
            disbursementDate: "",
            createdAt: "",
            updatedAt: "",
          ),
        );
      }
    }).toList();
    print("list $list");
    // applicationsList.addAll(list);
    applicationsList.addAll(applications);
    return applicationsList;
  }

  @override
  Future<List<LoanApplicationModel>> getLocalApplicants() async {
    final db = await DatabaseManager.instance.database;
    final maps = await db.query(AppConstants.tableName);
    return maps.map((e) => LoanApplicationModel.fromMap(e)).toList();
  }
}
