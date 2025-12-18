class HelpCenter {
  const HelpCenter({
    required this.id,
    required this.name,
    required this.categoryId,
    this.description,
    this.address,
    this.phone,
    this.website,
    this.imageUrl,
    this.tags = const [],
  });

  final String id;
  final String name;
  final String categoryId;
  final String? description;
  final String? address;
  final String? phone;
  final String? website;
  final String? imageUrl;
  final List<String> tags;
}

