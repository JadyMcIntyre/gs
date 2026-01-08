import 'package:cloud_firestore/cloud_firestore.dart';

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
}
