import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/applicant_history_entity.dart';
import '../../domain/usecases/get_all_applications.dart';

part 'applicant_history_event.dart';
part 'applicant_history_state.dart';

class ApplicantHistoryBloc
    extends Bloc<ApplicantHistoryEvent, ApplicantHistoryState> {
  final GetAllApplications getAllApplications;
  ApplicantHistoryBloc({required this.getAllApplications})
    : super(ApplicantHistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
    on<FilterHistory>(_onFilterHistory);
  }

  Future<void> _onLoadHistory(
    LoadHistory event,
    Emitter<ApplicantHistoryState> emit,
  ) async {
    emit(HistoryLoading());
    final result = await getAllApplications();
    result.fold(
      (failure) => emit(HistoryError(failure.message)),
      (list) => emit(
        HistoryLoaded(allApplications: list, filteredApplications: list),
      ),
    );
  }

  void _onFilterHistory(
    FilterHistory event,
    Emitter<ApplicantHistoryState> emit,
  ) {
    if (state is HistoryLoaded) {
      final currentState = state as HistoryLoaded;
      final filter = event.status;

      final filtered = filter == 'All'
          ? currentState.allApplications
          : currentState.allApplications
                .where((e) => e.status.toLowerCase() == filter.toLowerCase())
                .toList();

      emit(
        HistoryLoaded(
          allApplications: currentState.allApplications,
          filteredApplications: filtered,
          activeFilter: filter,
        ),
      );
    }
  }
}
