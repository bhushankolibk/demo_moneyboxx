import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneybox_task/features/add_applicant/domain/entities/loan_applicant_entity.dart';

import 'package:moneybox_task/features/add_applicant/domain/usecases/get_last_draft.dart';
import 'package:uuid/uuid.dart';
import '../../domain/usecases/save_draft.dart';

part 'add_applicant_event.dart';
part 'add_application_state.dart';

class AddApplicationBloc
    extends Bloc<AddApplicationEvent, AddApplicationState> {
  final GetLastDraft getLastDraft;
  final SaveDraft saveDraft;

  AddApplicationBloc({required this.getLastDraft, required this.saveDraft})
    : super(AddApplicationState.initial()) {
    on<CheckForDraft>(_onCheckForDraft);
    on<ResumeDraft>(_onResumeDraft);
    on<NextStepEvent>(_onNextStep);
    on<PreviousStepEvent>(_onPreviousStep);
    on<JumpToStepEvent>(_onJumpToStep);
    on<SubmitApplicationEvent>(_onSubmitApplication);
  }

  Future<void> _onCheckForDraft(
    CheckForDraft event,
    Emitter<AddApplicationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Call UseCase
    final result = await getLastDraft();
    print("object: $result");

    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, errorMessage: "Could not load drafts"),
      ),
      (optionDraft) {
        log("optionDraft: $optionDraft");
        optionDraft.fold(
          () {
            // None: Start new
            final newId = 'local_${const Uuid().v4()}';
            emit(
              state.copyWith(
                applicationModel: LoanApplicationEntity(
                  id: newId,
                  currentStep: 0,
                ),
                isLoading: false,
                isSubmitted: false,
              ),
            );
          },
          (draftEntity) {
            emit(
              state.copyWith(
                applicationModel: draftEntity,
                isLoading: false,
                isSubmitted: false,
              ),
            );
          },
        );
      },
    );
  }

  void _onResumeDraft(ResumeDraft event, Emitter<AddApplicationState> emit) {
    emit(state.copyWith(applicationModel: event.draft, isLoading: false));
  }

  Future<void> _onNextStep(
    NextStepEvent event,
    Emitter<AddApplicationState> emit,
  ) async {
    final updatedModel = state.applicationModel.copyWith(
      currentStep: state.applicationModel.currentStep + 1,
      businessName: event.businessName,
      businessType: event.businessType,
      registrationNumber: event.registrationNumber,
      yearsInOperation: event.yearsInOperation,
      applicantName: event.applicantName,
      panCard: event.panCard,
      aadhaarNumber: event.aadhaarNumber,
      mobileNumber: event.mobileNumber,
      emailAddress: event.emailAddress,
      loanAmount: event.loanAmount,
      tenure: event.tenure,
      loanPurpose: event.loanPurpose,
    );

    emit(state.copyWith(applicationModel: updatedModel));

    final result = await saveDraft(updatedModel);

    result.fold(
      (failure) => print("Auto-save failed: ${failure.message}"),
      (_) => print("Auto-save successful"),
    );
  }

  Future<void> _onPreviousStep(
    PreviousStepEvent event,
    Emitter<AddApplicationState> emit,
  ) async {
    if (state.applicationModel.currentStep > 0) {
      final updatedModel = state.applicationModel.copyWith(
        currentStep: state.applicationModel.currentStep - 1,
      );
      emit(state.copyWith(applicationModel: updatedModel));

      // Optional: Auto-save position via UseCase
      await saveDraft(updatedModel);
    }
  }

  void _onJumpToStep(JumpToStepEvent event, Emitter<AddApplicationState> emit) {
    emit(
      state.copyWith(
        applicationModel: state.applicationModel.copyWith(
          currentStep: event.stepIndex,
        ),
      ),
    );
  }

  Future<void> _onSubmitApplication(
    SubmitApplicationEvent event,
    Emitter<AddApplicationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final updatedModel = state.applicationModel.copyWith(
      currentStep: state.applicationModel.currentStep + 1,
      businessName: event.businessName,
      businessType: event.businessType,
      registrationNumber: event.registrationNumber,
      yearsInOperation: event.yearsInOperation,
      applicantName: event.applicantName,
      panCard: event.panCard,
      aadhaarNumber: event.aadhaarNumber,
      mobileNumber: event.mobileNumber,
      emailAddress: event.emailAddress,
      loanAmount: event.loanAmount,
      tenure: event.tenure,
      loanPurpose: event.loanPurpose,
    );
    // Final Save via UseCase
    final result = await saveDraft(updatedModel);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Failed to submit: ${failure.message}",
        ),
      ),
      (_) => emit(state.copyWith(isLoading: false, isSubmitted: true)),
    );
  }
}
