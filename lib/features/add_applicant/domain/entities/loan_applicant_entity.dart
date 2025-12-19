import 'package:equatable/equatable.dart';

class LoanApplicationEntity extends Equatable {
  final String? id;
  final int currentStep;

  // Step 1: Business
  final String? businessName;
  final String? businessType;
  final String? registrationNumber;
  final String? yearsInOperation;

  // Step 2: Applicant
  final String? applicantName;
  final String? panCard;
  final String? aadhaarNumber;
  final String? mobileNumber;
  final String? emailAddress;

  // Step 3: Loan
  final double? loanAmount;
  final String? tenure;
  final List<String>? loanPurpose;

  const LoanApplicationEntity({
    this.id,
    this.currentStep = 0,
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

  LoanApplicationEntity copyWith({
    String? id,
    int? currentStep,
    String? businessName,
    String? businessType,
    String? registrationNumber,
    String? yearsInOperation,
    String? applicantName,
    String? panCard,
    String? aadhaarNumber,
    String? mobileNumber,
    String? emailAddress,
    double? loanAmount,
    String? tenure,
    List<String>? loanPurpose,
  }) {
    return LoanApplicationEntity(
      id: id ?? this.id,
      currentStep: currentStep ?? this.currentStep,
      businessName: businessName ?? this.businessName,
      businessType: businessType ?? this.businessType,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      yearsInOperation: yearsInOperation ?? this.yearsInOperation,
      applicantName: applicantName ?? this.applicantName,
      panCard: panCard ?? this.panCard,
      aadhaarNumber: aadhaarNumber ?? this.aadhaarNumber,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      loanAmount: loanAmount ?? this.loanAmount,
      tenure: tenure ?? this.tenure,
      loanPurpose: loanPurpose ?? this.loanPurpose,
    );
  }

  @override
  List<Object?> get props => [
    id,
    currentStep,
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
