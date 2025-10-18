import '../entities/mentor_application.dart';
import '../entities/mentor_attachment.dart';

abstract class BecomeMentorRepo {
  Future<void> submitApplication(
    MentorApplication application, {
    MentorApplicationAttachment? attachment,
  });
}
