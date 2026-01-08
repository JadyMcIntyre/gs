import 'package:equatable/equatable.dart';

import 'help_center_suggestion.dart';

class HelpCenterSuggestionRecord extends Equatable {
  const HelpCenterSuggestionRecord({
    required this.id,
    required this.suggestion,
    required this.status,
  });

  final String id;
  final HelpCenterSuggestion suggestion;
  final String status;

  bool get isSubmitted => status == 'submitted';
  bool get isReviewing => status == 'reviewing';

  @override
  List<Object?> get props => [id, suggestion, status];
}
