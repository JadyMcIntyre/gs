import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/app_suggestion.dart';
import '../../domain/exceptions/app_suggestion_exception.dart';
import '../../domain/repo/app_suggestion_repo.dart';

part 'app_suggestion_state.dart';

class AppSuggestionCubit extends Cubit<AppSuggestionState> {
  AppSuggestionCubit(this._repo) : super(const AppSuggestionState.initial());

  final AppSuggestionRepo _repo;

  Future<void> submit(AppSuggestion suggestion) async {
    emit(const AppSuggestionState.submitting());

    try {
      await _repo.submitSuggestion(suggestion);
      emit(const AppSuggestionState.success());
    } on AppSuggestionException catch (e) {
      emit(AppSuggestionState.failure(e.message));
    } catch (e) {
      emit(const AppSuggestionState.failure('Unable to submit your suggestion right now.'));
    }
  }
}
