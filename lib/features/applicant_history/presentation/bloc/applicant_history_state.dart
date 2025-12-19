part of 'applicant_history_bloc.dart';

abstract class ApplicantHistoryState extends Equatable {
  const ApplicantHistoryState();

  @override
  List<Object?> get props => [];
}

class ApplicantHistoryInitial extends ApplicantHistoryState {}

class HistoryLoading extends ApplicantHistoryState {}

class HistoryLoaded extends ApplicantHistoryState {
  final List<ApplicationHistoryEntity> allApplications;
  final List<ApplicationHistoryEntity> filteredApplications;
  final String activeFilter;

  const HistoryLoaded({
    required this.allApplications,
    required this.filteredApplications,
    this.activeFilter = 'All',
  });

  @override
  List<Object?> get props => [
    allApplications,
    filteredApplications,
    activeFilter,
  ];
}

class HistoryError extends ApplicantHistoryState {
  final String message;
  const HistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
