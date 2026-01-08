import 'package:equatable/equatable.dart';

import 'app_suggestion.dart';

class AppSuggestionRecord extends Equatable {
  const AppSuggestionRecord({
    required this.suggestion,
    required this.status,
  });

  final AppSuggestion suggestion;
  final String status;

  bool get isSubmitted => status == 'submitted';
  bool get isReviewing => status == 'reviewing';

  @override
  List<Object?> get props => [suggestion, status];
}
