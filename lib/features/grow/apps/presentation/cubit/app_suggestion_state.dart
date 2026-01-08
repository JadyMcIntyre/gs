part of 'app_suggestion_cubit.dart';

class AppSuggestionState extends Equatable {
  const AppSuggestionState({
    required this.status,
    this.errorMessage,
    this.suggestions = const [],
    this.isLoadingSuggestions = false,
  });

  const AppSuggestionState.initial()
      : this(status: AppSuggestionStatus.initial, isLoadingSuggestions: false);

  const AppSuggestionState.submitting()
      : this(status: AppSuggestionStatus.submitting, isLoadingSuggestions: false);

  const AppSuggestionState.success()
      : this(status: AppSuggestionStatus.success, isLoadingSuggestions: false);

  const AppSuggestionState.failure(String message)
      : this(
          status: AppSuggestionStatus.failure,
          errorMessage: message,
          isLoadingSuggestions: false,
        );

  final AppSuggestionStatus status;
  final String? errorMessage;
  final List<AppSuggestionRecord> suggestions;
  final bool isLoadingSuggestions;

  bool get isSubmitting => status == AppSuggestionStatus.submitting;

  AppSuggestionState copyWith({
    AppSuggestionStatus? status,
    String? errorMessage,
    List<AppSuggestionRecord>? suggestions,
    bool? isLoadingSuggestions,
  }) {
    return AppSuggestionState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      suggestions: suggestions ?? this.suggestions,
      isLoadingSuggestions: isLoadingSuggestions ?? this.isLoadingSuggestions,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, suggestions, isLoadingSuggestions];
}

enum AppSuggestionStatus { initial, submitting, success, failure }
