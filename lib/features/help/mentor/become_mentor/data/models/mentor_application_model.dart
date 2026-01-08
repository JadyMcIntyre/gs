import '../../domain/entities/mentor_application.dart';
import '../../domain/entities/mentor_attachment.dart';

class MentorApplicationModel extends MentorApplication {
  const MentorApplicationModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required super.expertise,
    required super.description,
  });

  factory MentorApplicationModel.fromEntity(MentorApplication application) {
    return MentorApplicationModel(
      firstName: application.firstName,
      lastName: application.lastName,
      email: application.email,
      phone: application.phone,
      expertise: application.expertise,
      description: application.description,
    );
  }

  factory MentorApplicationModel.fromFirestore(Map<String, dynamic> data) {
    return MentorApplicationModel(
      firstName: data['firstName'] as String? ?? '',
      lastName: data['lastName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      expertise: data['expertise'] as String? ?? '',
      description: data['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'expertise': expertise,
      'description': description,
    };
  }
}

class MentorAttachmentModel extends MentorApplicationAttachment {
  const MentorAttachmentModel({
    required super.bytes,
    required super.name,
    super.mimeType,
  });

  factory MentorAttachmentModel.fromAttachment(MentorApplicationAttachment attachment) {
    return MentorAttachmentModel(
      bytes: attachment.bytes,
      name: attachment.name,
      mimeType: attachment.mimeType,
    );
  }
}
