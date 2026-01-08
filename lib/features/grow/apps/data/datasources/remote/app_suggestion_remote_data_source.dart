import '../../models/app_suggestion_model.dart';

abstract class AppSuggestionRemoteDataSource {
  Future<void> submitSuggestion({
    required AppSuggestionModel suggestion,
    required String userId,
  });
}
