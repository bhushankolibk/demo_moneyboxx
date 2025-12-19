import 'package:fpdart/fpdart.dart';
import 'package:moneybox_task/features/dashboard/domain/entities/dashboard_stats_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/repositories/dasboard_stats_repository.dart';
import '../datasources/remote/dasboard_stats_datasource.dart';

class DashboardStatsRepositoryImpl implements DashboardStatsRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardStatsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DashboardStatsEntity>> getDashboardStats() async {
    try {
      final remoteModel = await remoteDataSource.getDashboardStats();
      return Right(remoteModel.toEntity());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
