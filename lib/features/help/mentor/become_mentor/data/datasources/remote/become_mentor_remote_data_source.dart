import 'package:godsufficient/features/help/mentor/become_mentor/data/models/mentor_application_model.dart';
import 'package:godsufficient/features/help/mentor/become_mentor/domain/entities/mentor_application_record.dart';

abstract class BecomeMentorRemoteDataSource {
  Future<void> submitApplication({
    required MentorApplicationModel application,
    required String userId,
    MentorAttachmentModel? attachment,
  });

  Future<DateTime?> lastSubmissionAt(String userId);

  Future<MentorApplicationRecord?> getApplication(String userId);
}
