import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../models/mentor_application_model.dart';
import 'become_mentor_remote_data_source.dart';

@LazySingleton(as: BecomeMentorRemoteDataSource)
class BecomeMentorRemoteDataSourceImpl implements BecomeMentorRemoteDataSource {
  BecomeMentorRemoteDataSourceImpl(this._firestore, this._storage);

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('suggestions').doc('help').collection('mentor');

  @override
  Future<DateTime?> lastSubmissionAt(String userId) async {
    final snapshot = await _collection.doc(userId).get();
    if (!snapshot.exists) return null;

    final createdAt = snapshot.data()?['createdAt'];
    if (createdAt is Timestamp) {
      return createdAt.toDate();
    }
    if (createdAt is DateTime) {
      return createdAt;
    }
    return null;
  }

  @override
  Future<void> submitApplication({
    required MentorApplicationModel application,
    required String userId,
    MentorAttachmentModel? attachment,
  }) async {
    final docRef = _collection.doc(userId);

    String? storagePath;
    String? downloadUrl;

    if (attachment != null) {
      storagePath = 'suggestions/help/mentor/$userId/${attachment.name}';
      final ref = _storage.ref(storagePath);
      final metadata = SettableMetadata(contentType: attachment.mimeType);
      await ref.putData(attachment.bytes, metadata);
      downloadUrl = await ref.getDownloadURL();
    }

    final data = application.toFirestore()
      ..addAll({
        'status': 'submitted',
        'statusHistory': [
          {
            'status': 'submitted',
            'changedAt': Timestamp.now(),
          }
        ],
        'published': false,
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
      });

    if (storagePath != null) {
      data['attachment'] = {
        'name': attachment!.name,
        'storagePath': storagePath,
        'downloadUrl': downloadUrl,
        'contentType': attachment.mimeType,
      };
    }

    await docRef.set(data);
  }
}
