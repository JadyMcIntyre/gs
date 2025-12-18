class HelpCategory {
  const HelpCategory({
    required this.id,
    required this.label,
    this.description,
    this.icon,
    this.order,
  });

  final String id;
  final String label;
  final String? description;
  final String? icon;
  final int? order;
}

