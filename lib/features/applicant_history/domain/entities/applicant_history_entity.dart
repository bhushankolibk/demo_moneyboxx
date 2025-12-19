import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ApplicationHistoryEntity extends Equatable {
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

  const ApplicationHistoryEntity({
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

  /// Helper: Get Status Color
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF00C853); // Green
      case 'pending':
        return const Color(0xFFFFAB00); // Amber
      case 'rejected':
        return const Color(0xFFD32F2F); // Red
      case 'disbursed':
        return const Color(0xFF00B0FF); // Blue
      case 'draft':
        return Colors.grey;
      case 'under_review':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  @override
  List<Object?> get props => [
    id,
    status,
    isLocalDraft,
    businessName,
    applicantName,
  ];
}
