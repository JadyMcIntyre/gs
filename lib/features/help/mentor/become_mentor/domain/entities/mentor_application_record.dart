import 'package:equatable/equatable.dart';

import 'mentor_application.dart';

class MentorApplicationRecord extends Equatable {
  const MentorApplicationRecord({
    required this.application,
    required this.status,
  });

  final MentorApplication application;
  final String status;

  bool get isSubmitted => status == 'submitted';
  bool get isReviewing => status == 'reviewing';

  @override
  List<Object?> get props => [application, status];
}
