import 'package:godsufficient/features/help/get_help/add_help/domain/entities/help_center_suggestion_record.dart';

import '../../models/help_center_suggestion_model.dart';

abstract class HelpCenterSuggestionRemoteDataSource {
  Future<void> submitSuggestion({
    required HelpCenterSuggestionModel suggestion,
    required String userId,
  });

  Future<List<HelpCenterSuggestionRecord>> getSuggestions(String userId);

  Future<void> updateSuggestion({
    required String userId,
    required String suggestionId,
    required HelpCenterSuggestionModel suggestion,
  });
}
