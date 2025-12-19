import 'dart:convert';

import '../../domain/entities/loan_applicant_entity.dart';

class LoanApplicationModel {
  final String? id;
  final int currentStep;
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
  const LoanApplicationModel({
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

  LoanApplicationModel copyWith({
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
    return LoanApplicationModel(
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'currentStep': currentStep,
      'businessName': businessName,
      'businessType': businessType,
      'registrationNumber': registrationNumber,
      'yearsInOperation': yearsInOperation,
      'applicantName': applicantName,
      'panCard': panCard,
      'aadhaarNumber': aadhaarNumber,
      'mobileNumber': mobileNumber,
      'emailAddress': emailAddress,
      'loanAmount': loanAmount,
      'tenure': tenure,
      'loanPurpose': loanPurpose != null ? jsonEncode(loanPurpose) : null,
    };
  }

  factory LoanApplicationModel.fromMap(Map<String, dynamic> map) {
    return LoanApplicationModel(
      id: map['id'],
      currentStep: map['currentStep'] ?? 0,
      businessName: map['businessName'],
      businessType: map['businessType'],
      registrationNumber: map['registrationNumber'],
      yearsInOperation: map['yearsInOperation'],
      applicantName: map['applicantName'],
      panCard: map['panCard'],
      aadhaarNumber: map['aadhaarNumber'],
      mobileNumber: map['mobileNumber'],
      emailAddress: map['emailAddress'],
      loanAmount: map['loanAmount']?.toDouble(),
      tenure: map['tenure'],
      loanPurpose: map['loanPurpose'] != null
          ? List<String>.from(jsonDecode(map['loanPurpose']))
          : [],
    );
  }

  factory LoanApplicationModel.fromEntity(LoanApplicationEntity entity) {
    return LoanApplicationModel(
      id: entity.id,
      currentStep: entity.currentStep,
      businessName: entity.businessName,
      businessType: entity.businessType,
      registrationNumber: entity.registrationNumber,
      yearsInOperation: entity.yearsInOperation,
      applicantName: entity.applicantName,
      panCard: entity.panCard,
      aadhaarNumber: entity.aadhaarNumber,
      mobileNumber: entity.mobileNumber,
      emailAddress: entity.emailAddress,
      loanAmount: entity.loanAmount,
      tenure: entity.tenure,
      loanPurpose: entity.loanPurpose,
    );
  }

  LoanApplicationEntity toEntity() {
    return LoanApplicationEntity(
      id: id,
      currentStep: currentStep,
      businessName: businessName,
      businessType: businessType,
      registrationNumber: registrationNumber,
      yearsInOperation: yearsInOperation,
      applicantName: applicantName,
      panCard: panCard,
      aadhaarNumber: aadhaarNumber,
      mobileNumber: mobileNumber,
      emailAddress: emailAddress,
      loanAmount: loanAmount,
      tenure: tenure,
      loanPurpose: loanPurpose,
    );
  }
}
