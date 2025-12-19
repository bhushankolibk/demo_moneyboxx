import 'package:fpdart/fpdart.dart';
import 'package:moneybox_task/features/applicant_history/domain/repositories/applications_repository.dart';

import '../../../../core/failure/failure.dart';
import '../entities/applicant_history_entity.dart';

class GetAllApplications {
  final ApplicationsRepository repository;

  GetAllApplications(this.repository);

  Future<Either<Failure, List<ApplicationHistoryEntity>>> call() async {
    return await repository.getApplications();
  }
}
