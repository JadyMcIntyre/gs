import '../../domain/entities/help_center_suggestion.dart';

class HelpCenterSuggestionModel extends HelpCenterSuggestion {
  const HelpCenterSuggestionModel({
    required super.name,
    required super.categoryId,
    super.description,
    super.address,
    super.phone,
    super.website,
    super.imageUrl,
    super.tags,
  });

  factory HelpCenterSuggestionModel.fromEntity(HelpCenterSuggestion suggestion) {
    return HelpCenterSuggestionModel(
      name: suggestion.name,
      categoryId: suggestion.categoryId,
      description: suggestion.description,
      address: suggestion.address,
      phone: suggestion.phone,
      website: suggestion.website,
      imageUrl: suggestion.imageUrl,
      tags: suggestion.tags,
    );
  }

  factory HelpCenterSuggestionModel.fromFirestore(Map<String, dynamic> data) {
    return HelpCenterSuggestionModel(
      name: data['name'] as String? ?? '',
      categoryId: data['categoryId'] as String? ?? '',
      description: data['description'] as String?,
      address: data['address'] as String?,
      phone: data['phone'] as String?,
      website: data['website'] as String?,
      imageUrl: data['imageUrl'] as String?,
      tags: (data['tags'] as List<dynamic>?)
              ?.whereType<String>()
              .map((tag) => tag.trim())
              .where((tag) => tag.isNotEmpty)
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'categoryId': categoryId,
      'description': description,
      'address': address,
      'phone': phone,
      'website': website,
      'imageUrl': imageUrl,
      'tags': tags,
    };
  }
}
