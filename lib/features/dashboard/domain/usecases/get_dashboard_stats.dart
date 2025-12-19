import 'package:fpdart/fpdart.dart';
import 'package:moneybox_task/features/dashboard/domain/entities/dashboard_stats_entity.dart';
import 'package:moneybox_task/features/dashboard/domain/repositories/dasboard_stats_repository.dart';

import '../../../../core/failure/failure.dart';

class GetDashboardStats {
  final DashboardStatsRepository repository;

  GetDashboardStats(this.repository);

  Future<Either<Failure, DashboardStatsEntity>> call() async {
    return await repository.getDashboardStats();
  }
}
