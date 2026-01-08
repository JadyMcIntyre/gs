import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/help_center.dart';

class HelpCenterModel extends HelpCenter {
  const HelpCenterModel({
    required super.id,
    required super.name,
    required super.categoryId,
    super.description,
    super.address,
    super.phone,
    super.website,
    super.imageUrl,
    super.tags,
  });

  factory HelpCenterModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc, {required String categoryId}) {
    final data = doc.data() ?? const <String, dynamic>{};
    return HelpCenterModel(
      id: doc.id,
      name: (data['name'] as String?)?.trim().isNotEmpty == true ? (data['name'] as String) : doc.id,
      categoryId: categoryId.trim(),
      description: data['description'] as String?,
      address: data['address'] as String?,
      phone: data['phone'] as String?,
      website: data['website'] as String?,
      imageUrl: data['imageUrl'] as String?,
      tags: _asStringList(data['tags']),
    );
  }

  static List<String> _asStringList(dynamic value) {
    if (value is Iterable) {
      return value.whereType<String>().map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    return const [];
  }
}
