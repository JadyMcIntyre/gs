import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/help_center_suggestion.dart';
import '../../domain/entities/help_center_suggestion_record.dart';
import '../../domain/exceptions/help_center_suggestion_exception.dart';
import '../../domain/repo/help_center_suggestion_repo.dart';

part 'help_center_suggestion_state.dart';

class HelpCenterSuggestionCubit extends Cubit<HelpCenterSuggestionState> {
  HelpCenterSuggestionCubit(this._repo) : super(const HelpCenterSuggestionState.initial());

  final HelpCenterSuggestionRepo _repo;

  Future<void> submit(HelpCenterSuggestion suggestion) async {
    emit(state.copyWith(status: HelpCenterSuggestionStatus.submitting, errorMessage: null));

    try {
      await _repo.submitSuggestion(suggestion);
      emit(state.copyWith(status: HelpCenterSuggestionStatus.success));
    } on HelpCenterSuggestionException catch (e) {
      emit(state.copyWith(status: HelpCenterSuggestionStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
        status: HelpCenterSuggestionStatus.failure,
        errorMessage: 'Unable to submit your suggestion right now.',
      ));
    }
  }

  Future<void> loadSuggestions() async {
    emit(state.copyWith(isLoadingSuggestions: true, errorMessage: null));
    try {
      final suggestions = await _repo.getSuggestions();
      emit(state.copyWith(suggestions: suggestions, isLoadingSuggestions: false));
    } on HelpCenterSuggestionException catch (e) {
      emit(state.copyWith(
        status: HelpCenterSuggestionStatus.failure,
        errorMessage: e.message,
        isLoadingSuggestions: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HelpCenterSuggestionStatus.failure,
        errorMessage: 'Unable to load your suggestions right now.',
        isLoadingSuggestions: false,
      ));
    }
  }

  Future<void> update(String suggestionId, HelpCenterSuggestion suggestion) async {
    emit(state.copyWith(status: HelpCenterSuggestionStatus.submitting, errorMessage: null));

    try {
      await _repo.updateSuggestion(suggestionId, suggestion);
      emit(state.copyWith(status: HelpCenterSuggestionStatus.success));
    } on HelpCenterSuggestionException catch (e) {
      emit(state.copyWith(status: HelpCenterSuggestionStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
        status: HelpCenterSuggestionStatus.failure,
        errorMessage: 'Unable to update your suggestion right now.',
      ));
    }
  }
}
