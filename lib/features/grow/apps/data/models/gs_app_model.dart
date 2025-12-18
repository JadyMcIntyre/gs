import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/gs_app.dart';

class GsAppModel extends GsApp {
  const GsAppModel({
    required super.id,
    required super.name,
    super.description,
    super.logoUrl,
    super.appStoreUrl,
    super.playStoreUrl,
    super.tags,
    super.isActive,
  });

  factory GsAppModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final name = _asTrimmedString(data?['name']);

    return GsAppModel(
      id: doc.id,
      name: (name?.isNotEmpty ?? false) ? name! : doc.id,
      description: _asTrimmedString(data?['description']),
      logoUrl: _asTrimmedString(data?['logoUrl']),
      appStoreUrl: _asTrimmedString(data?['appStoreUrl']),
      playStoreUrl: _asTrimmedString(data?['playStoreUrl']),
      tags: _asStringList(data?['tags']),
      isActive: _asBool(data?['isActive']) ?? true,
    );
  }

  static String? _asTrimmedString(dynamic value) {
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static bool? _asBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final v = value.trim().toLowerCase();
      if (v == 'true' || v == '1') return true;
      if (v == 'false' || v == '0') return false;
    }
    return null;
  }

  static List<String> _asStringList(dynamic value) {
    if (value is! List) return const [];
    return value
        .whereType<String>()
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);
  }
}

