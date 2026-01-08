part of 'app_suggestion_cubit.dart';

class AppSuggestionState {
  const AppSuggestionState._({
    required this.status,
    this.errorMessage,
  });

  const AppSuggestionState.initial() : this._(status: AppSuggestionStatus.initial);

  const AppSuggestionState.submitting() : this._(status: AppSuggestionStatus.submitting);

  const AppSuggestionState.success() : this._(status: AppSuggestionStatus.success);

  const AppSuggestionState.failure(String message)
      : this._(status: AppSuggestionStatus.failure, errorMessage: message);

  final AppSuggestionStatus status;
  final String? errorMessage;

  bool get isSubmitting => status == AppSuggestionStatus.submitting;
}

enum AppSuggestionStatus { initial, submitting, success, failure }
