import '../entities/app_suggestion.dart';

abstract class AppSuggestionRepo {
  Future<void> submitSuggestion(AppSuggestion suggestion);
}
