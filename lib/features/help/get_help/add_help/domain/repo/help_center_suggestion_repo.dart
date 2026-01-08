import '../entities/help_center_suggestion.dart';
import '../entities/help_center_suggestion_record.dart';

abstract class HelpCenterSuggestionRepo {
  Future<void> submitSuggestion(HelpCenterSuggestion suggestion);

  Future<List<HelpCenterSuggestionRecord>> getSuggestions();

  Future<void> updateSuggestion(String suggestionId, HelpCenterSuggestion suggestion);
}
