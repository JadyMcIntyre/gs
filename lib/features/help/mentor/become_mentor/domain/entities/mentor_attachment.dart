import 'dart:typed_data';

class MentorApplicationAttachment {
  const MentorApplicationAttachment({
    required this.bytes,
    required this.name,
    this.mimeType,
  });

  final Uint8List bytes;
  final String name;
  final String? mimeType;
}
