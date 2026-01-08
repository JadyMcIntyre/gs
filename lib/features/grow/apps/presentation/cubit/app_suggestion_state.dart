part of 'app_suggestion_cubit.dart';

class AppSuggestionState extends Equatable {
  const AppSuggestionState({
    required this.status,
    this.errorMessage,
    this.existing,
    this.isCheckingExisting = false,
  });

  const AppSuggestionState.initial()
      : this(status: AppSuggestionStatus.initial, isCheckingExisting: false);

  const AppSuggestionState.submitting()
      : this(status: AppSuggestionStatus.submitting, isCheckingExisting: false);

  const AppSuggestionState.success()
      : this(status: AppSuggestionStatus.success, isCheckingExisting: false);

  const AppSuggestionState.failure(String message)
      : this(
          status: AppSuggestionStatus.failure,
          errorMessage: message,
          isCheckingExisting: false,
        );

  final AppSuggestionStatus status;
  final String? errorMessage;
  final AppSuggestionRecord? existing;
  final bool isCheckingExisting;

  bool get isSubmitting => status == AppSuggestionStatus.submitting;

  AppSuggestionState copyWith({
    AppSuggestionStatus? status,
    String? errorMessage,
    AppSuggestionRecord? existing,
    bool? isCheckingExisting,
  }) {
    return AppSuggestionState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      existing: existing ?? this.existing,
      isCheckingExisting: isCheckingExisting ?? this.isCheckingExisting,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, existing, isCheckingExisting];
}

enum AppSuggestionStatus { initial, submitting, success, failure }
