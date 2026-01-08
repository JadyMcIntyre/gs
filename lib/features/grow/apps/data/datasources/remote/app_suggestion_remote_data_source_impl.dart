import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:godsufficient/features/grow/apps/domain/entities/app_suggestion_record.dart';

import '../../models/app_suggestion_model.dart';
import 'app_suggestion_remote_data_source.dart';

class AppSuggestionRemoteDataSourceImpl implements AppSuggestionRemoteDataSource {
  AppSuggestionRemoteDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('suggestions').doc('grow').collection('app');

  CollectionReference<Map<String, dynamic>> _userSuggestions(String userId) =>
      _collection.doc(userId).collection('suggestions');

  @override
  Future<void> submitSuggestion({
    required AppSuggestionModel suggestion,
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
  Future<List<AppSuggestionRecord>> getSuggestions(String userId) async {
    final snapshot = await _userSuggestions(userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      final suggestion = AppSuggestionModel.fromFirestore(data);
      final status = data['status'] as String? ?? 'submitted';
      return AppSuggestionRecord(id: doc.id, suggestion: suggestion, status: status);
    }).toList();
  }

  @override
  Future<void> updateSuggestion({
    required String userId,
    required String suggestionId,
    required AppSuggestionModel suggestion,
  }) async {
    final docRef = _userSuggestions(userId).doc(suggestionId);
    final data = suggestion.toFirestore()
      ..addAll({
        'updatedAt': FieldValue.serverTimestamp(),
      });

    await docRef.set(data, SetOptions(merge: true));
  }
}
