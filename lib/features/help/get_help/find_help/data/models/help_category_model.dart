import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/help_category.dart';

class HelpCategoryModel extends HelpCategory {
  const HelpCategoryModel({
    required super.id,
    required super.label,
    super.description,
    super.icon,
    super.order,
  });

  factory HelpCategoryModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final name = (data?['name'] as String?)?.trim();
    final label = (data?['label'] as String?)?.trim();
    return HelpCategoryModel(
      id: doc.id,
      label: (name?.isNotEmpty ?? false)
          ? name!
          : ((label?.isNotEmpty ?? false) ? label! : doc.id),
      description: data?['description'] as String?,
      icon: data?['icon'] as String?,
      order: _asInt(data?['order']),
    );
  }

  static int? _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return null;
  }
}
