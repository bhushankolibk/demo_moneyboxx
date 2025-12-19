part of 'applicant_history_bloc.dart';

abstract class ApplicantHistoryEvent extends Equatable {
  const ApplicantHistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadHistory extends ApplicantHistoryEvent {}

class FilterHistory extends ApplicantHistoryEvent {
  final String status;
  const FilterHistory(this.status);

  @override
  List<Object?> get props => [status];
}

class SortHistory extends ApplicantHistoryEvent {
  final String sortBy;
  const SortHistory(this.sortBy);

  @override
  List<Object?> get props => [sortBy];
}
