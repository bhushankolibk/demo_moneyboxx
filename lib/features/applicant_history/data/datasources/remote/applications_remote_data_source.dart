import '../../../../add_applicant/data/models/loan_applicant_model.dart';
import '../../models/applicant_history_model.dart';

abstract class ApplicationsRemoteDataSource {
  Future<List<ApplicationHistoryModel>> getApplications();
  Future<List<LoanApplicationModel>> getLocalApplicants();
}
