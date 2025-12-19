part of 'add_applicant_bloc.dart';

abstract class AddApplicationEvent extends Equatable {
  const AddApplicationEvent();

  @override
  List<Object?> get props => [];
}

class LoadLoanApplications extends AddApplicationEvent {}

class CheckForDraft extends AddApplicationEvent {}

class ResumeDraft extends AddApplicationEvent {
  final LoanApplicationEntity draft;
  const ResumeDraft(this.draft);

  @override
  List<Object?> get props => [draft];
}

class NextStepEvent extends AddApplicationEvent {
  final String? businessName;
  final String? businessType;
  final String? registrationNumber;
  final String? yearsInOperation;

  final String? applicantName;
  final String? panCard;
  final String? aadhaarNumber;
  final String? mobileNumber;
  final String? emailAddress;

  final double? loanAmount;
  final String? tenure;
  final List<String>? loanPurpose;

  const NextStepEvent({
    this.businessName,
    this.businessType,
    this.registrationNumber,
    this.yearsInOperation,
    this.applicantName,
    this.panCard,
    this.aadhaarNumber,
    this.mobileNumber,
    this.emailAddress,
    this.loanAmount,
    this.tenure,
    this.loanPurpose,
  });

  @override
  List<Object?> get props => [
    businessName,
    businessType,
    registrationNumber,
    yearsInOperation,
    applicantName,
    panCard,
    aadhaarNumber,
    mobileNumber,
    emailAddress,
    loanAmount,
    tenure,
    loanPurpose,
  ];
}

class PreviousStepEvent extends AddApplicationEvent {}

class JumpToStepEvent extends AddApplicationEvent {
  final int stepIndex;
  const JumpToStepEvent(this.stepIndex);

  @override
  List<Object?> get props => [stepIndex];
}

class SubmitApplicationEvent extends AddApplicationEvent {
  final String? businessName;
  final String? businessType;
  final String? registrationNumber;
  final String? yearsInOperation;

  final String? applicantName;
  final String? panCard;
  final String? aadhaarNumber;
  final String? mobileNumber;
  final String? emailAddress;

  final double? loanAmount;
  final String? tenure;
  final List<String>? loanPurpose;

  const SubmitApplicationEvent({
    this.businessName,
    this.businessType,
    this.registrationNumber,
    this.yearsInOperation,
    this.applicantName,
    this.panCard,
    this.aadhaarNumber,
    this.mobileNumber,
    this.emailAddress,
    this.loanAmount,
    this.tenure,
    this.loanPurpose,
  });

  @override
  List<Object?> get props => [
    businessName,
    businessType,
    registrationNumber,
    yearsInOperation,
    applicantName,
    panCard,
    aadhaarNumber,
    mobileNumber,
    emailAddress,
    loanAmount,
    tenure,
    loanPurpose,
  ];
}
