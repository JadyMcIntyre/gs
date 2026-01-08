import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/mentor_application.dart';
import '../../domain/entities/mentor_attachment.dart';
import '../../domain/entities/mentor_application_record.dart';
import '../../domain/exceptions/become_mentor_exception.dart';
import '../../domain/repo/become_mentor_repo.dart';
import '../datasources/remote/become_mentor_remote_data_source.dart';
import '../models/mentor_application_model.dart';

@LazySingleton(as: BecomeMentorRepo)
class BecomeMentorRepoImpl implements BecomeMentorRepo {
  BecomeMentorRepoImpl(this._remoteDataSource, this._auth);

  final BecomeMentorRemoteDataSource _remoteDataSource;
  final FirebaseAuth _auth;

  static const Duration _submissionCooldown = Duration(minutes: 5);

  @override
  Future<void> submitApplication(
    MentorApplication application, {
    MentorApplicationAttachment? attachment,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const BecomeMentorException('Please sign in before submitting a mentor request.');
    }

    final existing = await _remoteDataSource.getApplication(user.uid);
    if (existing != null && existing.isReviewing) {
      throw const BecomeMentorException('Your application is under review and cannot be edited.');
    }

    if (existing == null) {
      final lastSubmission = await _remoteDataSource.lastSubmissionAt(user.uid);
      if (lastSubmission != null) {
        final elapsed = DateTime.now().toUtc().difference(lastSubmission.toUtc());
        if (elapsed < _submissionCooldown) {
          final remaining = _submissionCooldown - elapsed;
          final minutes = remaining.inMinutes;
          final seconds = remaining.inSeconds % 60;
          final buffer = StringBuffer();
          if (minutes > 0) {
            buffer.write('$minutes minute${minutes == 1 ? '' : 's'}');
          }
          if (minutes > 0 && seconds > 0) {
            buffer.write(' and ');
          }
          if (seconds > 0) {
            buffer.write('$seconds second${seconds == 1 ? '' : 's'}');
          }
          throw BecomeMentorException('Please wait $buffer before submitting another request.');
        }
      }
    }

    final model = MentorApplicationModel.fromEntity(application);
    final attachmentModel =
        attachment == null ? null : MentorAttachmentModel.fromAttachment(attachment);

    try {
      await _remoteDataSource.submitApplication(
        application: model,
        attachment: attachmentModel,
        userId: user.uid,
      );
    } on BecomeMentorException {
      rethrow;
    } on FirebaseException catch (e) {
      throw BecomeMentorException(e.message ?? 'Unable to submit mentor request. (${e.code})');
    } catch (e) {
      throw BecomeMentorException('Something went wrong while submitting your request.');
    }
  }

  @override
  Future<MentorApplicationRecord?> getExistingApplication() async {
    final user = _auth.currentUser;
    if (user == null) {
      return null;
    }

    try {
      return await _remoteDataSource.getApplication(user.uid);
    } on FirebaseException catch (e) {
      throw BecomeMentorException(e.message ?? 'Unable to load your mentor request. (${e.code})');
    } catch (e) {
      throw const BecomeMentorException('Something went wrong while loading your request.');
    }
  }
}
