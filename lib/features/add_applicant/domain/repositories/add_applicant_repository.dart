import 'package:fpdart/fpdart.dart';
import 'package:moneybox_task/core/failure/failure.dart';

import '../entities/loan_applicant_entity.dart';

abstract class AddApplicantRepository {
  Future<Either<Failure, Unit>> saveDraft(LoanApplicationEntity draft);

  Future<Either<Failure, Option<LoanApplicationEntity>>> getLastDraft();

  Future<Either<Failure, List<LoanApplicationEntity>>> getAllLoanApplicants();
}
