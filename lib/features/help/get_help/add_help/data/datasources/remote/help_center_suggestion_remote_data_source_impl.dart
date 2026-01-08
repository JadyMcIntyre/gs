import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:godsufficient/features/help/get_help/add_help/domain/entities/help_center_suggestion_record.dart';

import '../../models/help_center_suggestion_model.dart';
import 'help_center_suggestion_remote_data_source.dart';

class HelpCenterSuggestionRemoteDataSourceImpl implements HelpCenterSuggestionRemoteDataSource {
  HelpCenterSuggestionRemoteDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('suggestions').doc('help').collection('getHelp');

  CollectionReference<Map<String, dynamic>> _userSuggestions(String userId) =>
      _collection.doc(userId).collection('suggestions');

  @override
  Future<void> submitSuggestion({
    required HelpCenterSuggestionModel suggestion,
    required String userId,
  }) async {
    final docRef = _userSuggestions(userId).doc();
    final data = suggestion.toFirestore()
      ..addAll({
        'status': 'submitted',
        'statusHistory': [
          {
            'status': 'submitted',
            'changedAt': Timestamp.now(),
          }
        ],
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
      });

    await docRef.set(data);
  }

  @override
  Future<List<HelpCenterSuggestionRecord>> getSuggestions(String userId) async {
    final snapshot = await _userSuggestions(userId).orderBy('createdAt', descending: true).get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      final suggestion = HelpCenterSuggestionModel.fromFirestore(data);
      final status = data['status'] as String? ?? 'submitted';
      return HelpCenterSuggestionRecord(id: doc.id, suggestion: suggestion, status: status);
    }).toList();
  }

  @override
  Future<void> updateSuggestion({
    required String userId,
    required String suggestionId,
    required HelpCenterSuggestionModel suggestion,
  }) async {
    final docRef = _userSuggestions(userId).doc(suggestionId);
    final data = suggestion.toFirestore()
      ..addAll({
        'updatedAt': FieldValue.serverTimestamp(),
      });

    await docRef.set(data, SetOptions(merge: true));
  }
}
