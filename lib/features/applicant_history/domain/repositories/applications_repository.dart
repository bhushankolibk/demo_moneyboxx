import 'package:fpdart/fpdart.dart';
import 'package:moneybox_task/features/applicant_history/domain/entities/applicant_history_entity.dart';
import 'package:moneybox_task/features/add_applicant/domain/entities/loan_applicant_entity.dart';

import '../../../../core/failure/failure.dart';

abstract class ApplicationsRepository {
  Future<Either<Failure, List<ApplicationHistoryEntity>>> getApplications();
  Future<Either<Failure, List<LoanApplicationEntity>>> getLocalApplicants();
}
