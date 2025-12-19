import 'dart:convert';

import '../../domain/entities/applicant_history_entity.dart';

class ApplicationHistoryModel {
  final String id;
  final String? applicationNumber;
  final String status;
  final bool isLocalDraft;

  // Business Details
  final String businessName;
  final String businessType;
  final String registrationNumber;
  final int yearsInOperation;

  // Applicant Details
  final String applicantName;
  final String pan;
  final String aadhaar;
  final String phone;
  final String email;

  // Loan Details
  final double requestedAmount;
  final double? approvedAmount;
  final int tenure;
  final double? interestRate;
  final List<String> purpose;

  // Status Specifics & Dates
  final String? rejectionReason;
  final String? disbursementDate;
  final String createdAt;
  final String updatedAt;

  const ApplicationHistoryModel({
    required this.id,
    this.applicationNumber,
    required this.status,
    this.isLocalDraft = false,
    required this.businessName,
    required this.businessType,
    required this.registrationNumber,
    required this.yearsInOperation,
    required this.applicantName,
    required this.pan,
    required this.aadhaar,
    required this.phone,
    required this.email,
    required this.requestedAmount,
    this.approvedAmount,
    required this.tenure,
    this.interestRate,
    required this.purpose,
    this.rejectionReason,
    this.disbursementDate,
    required this.createdAt,
    required this.updatedAt,
  });

  ApplicationHistoryModel copyWith({
    String? id,
    String? applicationNumber,
    String? status,
    bool? isLocalDraft,
    String? businessName,
    String? businessType,
    String? registrationNumber,
    int? yearsInOperation,
    String? applicantName,
    String? pan,
    String? aadhaar,
    String? phone,
    String? email,
    double? requestedAmount,
    double? approvedAmount,
    int? tenure,
    double? interestRate,
    List<String>? purpose,
    String? rejectionReason,
    String? disbursementDate,
    String? createdAt,
    String? updatedAt,
  }) {
    return ApplicationHistoryModel(
      id: id ?? this.id,
      applicationNumber: applicationNumber ?? this.applicationNumber,
      status: status ?? this.status,
      isLocalDraft: isLocalDraft ?? this.isLocalDraft,
      businessName: businessName ?? this.businessName,
      businessType: businessType ?? this.businessType,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      yearsInOperation: yearsInOperation ?? this.yearsInOperation,
      applicantName: applicantName ?? this.applicantName,
      pan: pan ?? this.pan,
      aadhaar: aadhaar ?? this.aadhaar,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      requestedAmount: requestedAmount ?? this.requestedAmount,
      approvedAmount: approvedAmount ?? this.approvedAmount,
      tenure: tenure ?? this.tenure,
      interestRate: interestRate ?? this.interestRate,
      purpose: purpose ?? this.purpose,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      disbursementDate: disbursementDate ?? this.disbursementDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'applicationNumber': applicationNumber,
      'status': status,
      'isLocalDraft': isLocalDraft,
      'businessName': businessName,
      'businessType': businessType,
      'registrationNumber': registrationNumber,
      'yearsInOperation': yearsInOperation,
      'applicantName': applicantName,
      'pan': pan,
      'aadhaar': aadhaar,
      'phone': phone,
      'email': email,
      'requestedAmount': requestedAmount,
      'approvedAmount': approvedAmount,
      'tenure': tenure,
      'interestRate': interestRate,
      'purpose': purpose,
      'rejectionReason': rejectionReason,
      'disbursementDate': disbursementDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ApplicationHistoryModel.fromMap(Map<String, dynamic> map) {
    return ApplicationHistoryModel(
      id: map['id'] ?? '',
      applicationNumber: map['applicationNumber'],
      status: map['status'] ?? 'pending',
      isLocalDraft: map['isLocalDraft'] ?? false,
      businessName: map['businessName'] ?? '',
      businessType: map['businessType'] ?? '',
      registrationNumber: map['registrationNumber'] ?? '',
      yearsInOperation: (map['yearsInOperation'] as num?)?.toInt() ?? 0,
      applicantName: map['applicantName'] ?? '',
      pan: map['pan'] ?? '',
      aadhaar: map['aadhaar'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      requestedAmount: (map['requestedAmount'] as num?)?.toDouble() ?? 0.0,
      approvedAmount: (map['approvedAmount'] as num?)?.toDouble(),
      tenure: (map['tenure'] as num?)?.toInt() ?? 0,
      interestRate: (map['interestRate'] as num?)?.toDouble(),
      purpose: map['purpose'] != null ? List<String>.from(map['purpose']) : [],
      rejectionReason: map['rejectionReason'],
      disbursementDate: map['disbursementDate'],
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  // Wrapper for JSON decoding for a single model
  factory ApplicationHistoryModel.fromJson(String source) =>
      ApplicationHistoryModel.fromMap(json.decode(source));

  // Parse API response that contains the root "loan_applications" array
  static List<ApplicationHistoryModel> listFromApiResponse(
    Map<String, dynamic> apiResponse,
  ) {
    final items = apiResponse['loan_applications'];
    if (items is List) {
      return items
          .where((e) => e != null)
          .map(
            (e) => ApplicationHistoryModel.fromMap(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .toList();
    }
    return [];
  }

  factory ApplicationHistoryModel.fromEntity(ApplicationHistoryEntity entity) {
    return ApplicationHistoryModel(
      id: entity.id,
      applicationNumber: entity.applicationNumber,
      status: entity.status,
      isLocalDraft: entity.isLocalDraft,
      businessName: entity.businessName,
      businessType: entity.businessType,
      registrationNumber: entity.registrationNumber,
      yearsInOperation: entity.yearsInOperation,
      applicantName: entity.applicantName,
      pan: entity.pan,
      aadhaar: entity.aadhaar,
      phone: entity.phone,
      email: entity.email,
      requestedAmount: entity.requestedAmount,
      approvedAmount: entity.approvedAmount,
      tenure: entity.tenure,
      interestRate: entity.interestRate,
      purpose: entity.purpose,
      rejectionReason: entity.rejectionReason,
      disbursementDate: entity.disbursementDate,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  ApplicationHistoryEntity toEntity() {
    return ApplicationHistoryEntity(
      id: id,
      applicationNumber: applicationNumber,
      status: status,
      isLocalDraft: isLocalDraft,
      businessName: businessName,
      businessType: businessType,
      registrationNumber: registrationNumber,
      yearsInOperation: yearsInOperation,
      applicantName: applicantName,
      pan: pan,
      aadhaar: aadhaar,
      phone: phone,
      email: email,
      requestedAmount: requestedAmount,
      approvedAmount: approvedAmount,
      tenure: tenure,
      interestRate: interestRate,
      purpose: purpose,
      rejectionReason: rejectionReason,
      disbursementDate: disbursementDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
