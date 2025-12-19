import 'package:fpdart/fpdart.dart';
import 'package:moneybox_task/features/dashboard/domain/entities/dashboard_stats_entity.dart';

import '../../../../core/failure/failure.dart';

abstract class DashboardStatsRepository {
  Future<Either<Failure, DashboardStatsEntity>> getDashboardStats();
}
