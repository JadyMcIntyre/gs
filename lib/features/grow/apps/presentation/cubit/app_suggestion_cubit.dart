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

  Future<void> loadSuggestions() async {
    emit(state.copyWith(isLoadingSuggestions: true, errorMessage: null));
    try {
      final suggestions = await _repo.getSuggestions();
      emit(state.copyWith(suggestions: suggestions, isLoadingSuggestions: false));
    } on AppSuggestionException catch (e) {
      emit(state.copyWith(
        status: AppSuggestionStatus.failure,
        errorMessage: e.message,
        isLoadingSuggestions: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AppSuggestionStatus.failure,
        errorMessage: 'Unable to load your suggestion right now.',
        isLoadingSuggestions: false,
      ));
    }
  }

  Future<void> update(String suggestionId, AppSuggestion suggestion) async {
    emit(state.copyWith(status: AppSuggestionStatus.submitting, errorMessage: null));

    try {
      await _repo.updateSuggestion(suggestionId, suggestion);
      emit(state.copyWith(status: AppSuggestionStatus.success));
    } on AppSuggestionException catch (e) {
      emit(state.copyWith(status: AppSuggestionStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
        status: AppSuggestionStatus.failure,
        errorMessage: 'Unable to update your suggestion right now.',
      ));
    }
  }
}
