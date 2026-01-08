import '../entities/mentor_application.dart';
import '../entities/mentor_attachment.dart';
import '../entities/mentor_application_record.dart';

abstract class BecomeMentorRepo {
  Future<void> submitApplication(
    MentorApplication application, {
    MentorApplicationAttachment? attachment,
  });

  Future<MentorApplicationRecord?> getExistingApplication();
}
