import '../../models/loan_applicant_model.dart';

abstract class AddApplicantLocalDatasource {
  Future<void> saveDraft(LoanApplicationModel draft);
  Future<List<LoanApplicationModel>> getLoanApplicants();
  Future<LoanApplicationModel?> getLastDraft();
  Future<void> deleteDraft(String id);
}
