import 'package:fpdart/fpdart.dart';
import 'package:moneybox_task/features/add_applicant/domain/repositories/add_applicant_repository.dart';

import '../../../../core/failure/failure.dart';
import '../entities/loan_applicant_entity.dart';

class SaveDraft {
  final AddApplicantRepository repository;

  SaveDraft({required this.repository});

  Future<Either<Failure, Unit>> call(LoanApplicationEntity draft) async {
    return await repository.saveDraft(draft);
  }
}
