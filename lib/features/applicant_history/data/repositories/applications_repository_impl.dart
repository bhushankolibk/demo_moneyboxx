import 'package:fpdart/fpdart.dart';
import 'package:moneybox_task/features/applicant_history/domain/entities/applicant_history_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../../add_applicant/domain/entities/loan_applicant_entity.dart';
import '../../domain/repositories/applications_repository.dart';
import '../datasources/remote/applications_remote_data_source.dart';

class ApplicationsRepositoryImpl implements ApplicationsRepository {
  final ApplicationsRemoteDataSource remoteDataSource;

  ApplicationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ApplicationHistoryEntity>>>
  getApplications() async {
    try {
      final result = await remoteDataSource.getApplications();

      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LoanApplicationEntity>>>
  getLocalApplicants() async {
    try {
      final result = await remoteDataSource.getLocalApplicants();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
