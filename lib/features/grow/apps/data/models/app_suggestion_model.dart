import '../../domain/entities/app_suggestion.dart';

class AppSuggestionModel extends AppSuggestion {
  const AppSuggestionModel({
    required super.name,
    super.description,
    super.logoUrl,
    super.appStoreUrl,
    super.playStoreUrl,
    super.tags,
  });

  factory AppSuggestionModel.fromEntity(AppSuggestion suggestion) {
    return AppSuggestionModel(
      name: suggestion.name,
      description: suggestion.description,
      logoUrl: suggestion.logoUrl,
      appStoreUrl: suggestion.appStoreUrl,
      playStoreUrl: suggestion.playStoreUrl,
      tags: suggestion.tags,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'logoUrl': logoUrl,
      'appStoreUrl': appStoreUrl,
      'playStoreUrl': playStoreUrl,
      'tags': tags,
      'isActive': false,
    };
  }
}
