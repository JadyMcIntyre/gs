import '../entities/app_suggestion.dart';
import '../entities/app_suggestion_record.dart';

abstract class AppSuggestionRepo {
  Future<void> submitSuggestion(AppSuggestion suggestion);

  Future<AppSuggestionRecord?> getExistingSuggestion();
}
