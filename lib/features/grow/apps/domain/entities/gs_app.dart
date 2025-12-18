import 'package:equatable/equatable.dart';

class GsApp extends Equatable {
  const GsApp({
    required this.id,
    required this.name,
    this.description,
    this.logoUrl,
    this.appStoreUrl,
    this.playStoreUrl,
    this.tags = const [],
    this.isActive = true,
  });

  final String id;
  final String name;
  final String? description;
  final String? logoUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final List<String> tags;
  final bool isActive;

  @override
  List<Object?> get props => [id, name, description, logoUrl, appStoreUrl, playStoreUrl, tags, isActive];
}

