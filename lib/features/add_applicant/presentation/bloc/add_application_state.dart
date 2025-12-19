part of 'add_applicant_bloc.dart';

class AddApplicationState extends Equatable {
  final LoanApplicationEntity applicationModel;

  final bool isLoading;
  final String? errorMessage;
  final bool isSubmitted;

  const AddApplicationState({
    required this.applicationModel,
    this.isLoading = false,
    this.errorMessage,
    this.isSubmitted = false,
  });

  factory AddApplicationState.initial() {
    return const AddApplicationState(
      applicationModel: LoanApplicationEntity(),
      isLoading: false,
      isSubmitted: false,
    );
  }

  AddApplicationState copyWith({
    LoanApplicationEntity? applicationModel,
    bool? isLoading,
    String? errorMessage,
    bool? isSubmitted,
  }) {
    return AddApplicationState(
      applicationModel: applicationModel ?? this.applicationModel,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [
    applicationModel,
    isLoading,
    errorMessage,
    isSubmitted,
  ];
}
