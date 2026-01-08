import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:godsufficient/features/grow/apps/domain/entities/app_suggestion_record.dart';

import '../../models/app_suggestion_model.dart';
import 'app_suggestion_remote_data_source.dart';

class AppSuggestionRemoteDataSourceImpl implements AppSuggestionRemoteDataSource {
  AppSuggestionRemoteDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('suggestions').doc('grow').collection('app');

  @override
  Future<void> submitSuggestion({
    required AppSuggestionModel suggestion,
    required String userId,
  }) async {
    final docRef = _collection.doc(userId);
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
  Future<AppSuggestionRecord?> getSuggestion(String userId) async {
    final snapshot = await _collection.doc(userId).get();
    if (!snapshot.exists) return null;

    final data = snapshot.data();
    if (data == null) return null;

    final suggestion = AppSuggestionModel.fromFirestore(data);
    final status = data['status'] as String? ?? 'submitted';
    return AppSuggestionRecord(suggestion: suggestion, status: status);
  }
}
