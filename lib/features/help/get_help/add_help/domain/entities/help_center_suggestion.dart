import 'package:equatable/equatable.dart';

class HelpCenterSuggestion extends Equatable {
  const HelpCenterSuggestion({
    required this.name,
    required this.categoryId,
    this.description,
    this.address,
    this.phone,
    this.website,
    this.imageUrl,
    this.tags = const [],
  });

  final String name;
  final String categoryId;
  final String? description;
  final String? address;
  final String? phone;
  final String? website;
  final String? imageUrl;
  final List<String> tags;

  @override
  List<Object?> get props => [
        name,
        categoryId,
        description,
        address,
        phone,
        website,
        imageUrl,
        tags,
      ];
}
