import 'package:godsufficient/features/grow/apps/domain/entities/app_suggestion_record.dart';

import '../../models/app_suggestion_model.dart';

abstract class AppSuggestionRemoteDataSource {
  Future<void> submitSuggestion({
    required AppSuggestionModel suggestion,
    required String userId,
  });

  Future<AppSuggestionRecord?> getSuggestion(String userId);
}
