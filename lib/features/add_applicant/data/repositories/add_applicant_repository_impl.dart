import 'package:fpdart/fpdart.dart';
import 'package:moneybox_task/core/failure/failure.dart';
import 'package:moneybox_task/features/add_applicant/data/datasources/local/add_applicant_local_datasource.dart';
import 'package:moneybox_task/features/add_applicant/domain/repositories/add_applicant_repository.dart';

import '../../domain/entities/loan_applicant_entity.dart';
import '../models/loan_applicant_model.dart';

class AddApplicantRepositoryImpl extends AddApplicantRepository {
  final AddApplicantLocalDatasource userLocalDatasource;
  AddApplicantRepositoryImpl({required this.userLocalDatasource});

  @override
  Future<Either<Failure, Unit>> saveDraft(LoanApplicationEntity draft) async {
    try {
      final model = LoanApplicationModel.fromEntity(draft);
      await userLocalDatasource.saveDraft(model);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Option<LoanApplicationEntity>>> getLastDraft() async {
    try {
      final model = await userLocalDatasource.getLastDraft();
      if (model != null) {
        return Right(Some(model.toEntity()));
      } else {
        return const Right(None());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LoanApplicationEntity>>>
  getAllLoanApplicants() async {
    try {
      final models = await userLocalDatasource.getLoanApplicants();
      final entities = models.map((e) => e.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
