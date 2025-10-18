import '../../models/mentor_application_model.dart';

abstract class BecomeMentorRemoteDataSource {
  Future<void> submitApplication({
    required MentorApplicationModel application,
    required String userId,
    MentorAttachmentModel? attachment,
  });

  Future<DateTime?> lastSubmissionAt(String userId);
}
