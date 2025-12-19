import 'package:fpdart/fpdart.dart';
import 'package:moneybox_task/core/failure/failure.dart';
import 'package:moneybox_task/features/add_applicant/domain/repositories/add_applicant_repository.dart';

import '../entities/loan_applicant_entity.dart';

class GetLastDraft {
  final AddApplicantRepository repository;
  GetLastDraft({required this.repository});

  Future<Either<Failure, Option<LoanApplicationEntity>>> call() {
    return repository.getLastDraft();
  }
}
