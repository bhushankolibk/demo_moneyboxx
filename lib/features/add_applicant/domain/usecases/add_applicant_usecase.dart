import 'package:fpdart/fpdart.dart';
import 'package:moneybox_task/core/failure/failure.dart';
import 'package:moneybox_task/features/add_applicant/domain/repositories/add_applicant_repository.dart';

class AddUserUsecase {
  final AddApplicantRepository repository;
  AddUserUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(userEntity) {
    return repository.saveDraft(userEntity);
  }
}
