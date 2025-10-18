part of 'become_mentor_cubit.dart';

class BecomeMentorState extends Equatable {
  const BecomeMentorState._({
    required this.status,
    this.errorMessage,
  });

  const BecomeMentorState.initial() : this._(status: BecomeMentorStatus.initial);

  const BecomeMentorState.submitting() : this._(status: BecomeMentorStatus.submitting);

  const BecomeMentorState.success() : this._(status: BecomeMentorStatus.success);

  const BecomeMentorState.failure(String message)
      : this._(status: BecomeMentorStatus.failure, errorMessage: message);

  final BecomeMentorStatus status;
  final String? errorMessage;

  bool get isSubmitting => status == BecomeMentorStatus.submitting;

  @override
  List<Object?> get props => [status, errorMessage];
}

enum BecomeMentorStatus { initial, submitting, success, failure }
