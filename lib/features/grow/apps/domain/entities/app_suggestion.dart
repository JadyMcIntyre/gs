import 'package:equatable/equatable.dart';

class AppSuggestion extends Equatable {
  const AppSuggestion({
    required this.name,
    this.description,
    this.logoUrl,
    this.appStoreUrl,
    this.playStoreUrl,
    this.tags = const [],
  });

  final String name;
  final String? description;
  final String? logoUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final List<String> tags;

  @override
  List<Object?> get props => [name, description, logoUrl, appStoreUrl, playStoreUrl, tags];
}
