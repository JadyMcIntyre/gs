part of 'help_center_suggestion_cubit.dart';

class HelpCenterSuggestionState extends Equatable {
  const HelpCenterSuggestionState({
    required this.status,
    this.errorMessage,
    this.suggestions = const [],
    this.isLoadingSuggestions = false,
  });

  const HelpCenterSuggestionState.initial()
      : this(status: HelpCenterSuggestionStatus.initial, isLoadingSuggestions: false);

  const HelpCenterSuggestionState.submitting()
      : this(status: HelpCenterSuggestionStatus.submitting, isLoadingSuggestions: false);

  const HelpCenterSuggestionState.success()
      : this(status: HelpCenterSuggestionStatus.success, isLoadingSuggestions: false);

  const HelpCenterSuggestionState.failure(String message)
      : this(
          status: HelpCenterSuggestionStatus.failure,
          errorMessage: message,
          isLoadingSuggestions: false,
        );

  final HelpCenterSuggestionStatus status;
  final String? errorMessage;
  final List<HelpCenterSuggestionRecord> suggestions;
  final bool isLoadingSuggestions;

  bool get isSubmitting => status == HelpCenterSuggestionStatus.submitting;

  HelpCenterSuggestionState copyWith({
    HelpCenterSuggestionStatus? status,
    String? errorMessage,
    List<HelpCenterSuggestionRecord>? suggestions,
    bool? isLoadingSuggestions,
  }) {
    return HelpCenterSuggestionState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      suggestions: suggestions ?? this.suggestions,
      isLoadingSuggestions: isLoadingSuggestions ?? this.isLoadingSuggestions,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, suggestions, isLoadingSuggestions];
}

enum HelpCenterSuggestionStatus { initial, submitting, success, failure }
