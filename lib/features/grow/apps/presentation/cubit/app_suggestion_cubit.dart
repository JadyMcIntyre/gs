import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/app_suggestion.dart';
import '../../domain/entities/app_suggestion_record.dart';
import '../../domain/exceptions/app_suggestion_exception.dart';
import '../../domain/repo/app_suggestion_repo.dart';

part 'app_suggestion_state.dart';

class AppSuggestionCubit extends Cubit<AppSuggestionState> {
  AppSuggestionCubit(this._repo) : super(const AppSuggestionState.initial());

  final AppSuggestionRepo _repo;

  Future<void> submit(AppSuggestion suggestion) async {
    emit(state.copyWith(status: AppSuggestionStatus.submitting, errorMessage: null));

    try {
      await _repo.submitSuggestion(suggestion);
      emit(state.copyWith(status: AppSuggestionStatus.success));
    } on AppSuggestionException catch (e) {
      emit(state.copyWith(status: AppSuggestionStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
        status: AppSuggestionStatus.failure,
        errorMessage: 'Unable to submit your suggestion right now.',
      ));
    }
  }

  Future<void> checkExisting() async {
    emit(state.copyWith(isCheckingExisting: true, errorMessage: null));
    try {
      final existing = await _repo.getExistingSuggestion();
      emit(state.copyWith(existing: existing, isCheckingExisting: false));
    } on AppSuggestionException catch (e) {
      emit(state.copyWith(
        status: AppSuggestionStatus.failure,
        errorMessage: e.message,
        isCheckingExisting: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AppSuggestionStatus.failure,
        errorMessage: 'Unable to load your suggestion right now.',
        isCheckingExisting: false,
      ));
    }
  }
}
