import 'dart:convert';

import 'package:moneybox_task/core/network/api_service.dart';
import 'package:moneybox_task/features/dashboard/data/datasources/remote/dasboard_stats_datasource.dart';
import '../../models/dashboard_model.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiService apiService;

  DashboardRemoteDataSourceImpl({required this.apiService});

  @override
  Future<DashboardModel> getDashboardStats() async {
    final response = await apiService.getDashboardStats();
    print(response);
    final Map<String, dynamic> jsonMap = response is String
        ? jsonDecode(response)
        : response;

    print("jsonMap: $jsonMap");
    return DashboardModel.fromJson(jsonMap);
  }
}
