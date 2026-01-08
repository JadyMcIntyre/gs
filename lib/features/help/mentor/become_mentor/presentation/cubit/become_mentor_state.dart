part of 'become_mentor_cubit.dart';

class BecomeMentorState extends Equatable {
  const BecomeMentorState({
    required this.status,
    this.errorMessage,
    this.existing,
    this.isCheckingExisting = false,
  });

  const BecomeMentorState.initial()
      : this(status: BecomeMentorStatus.initial, isCheckingExisting: false);

  const BecomeMentorState.submitting()
      : this(status: BecomeMentorStatus.submitting, isCheckingExisting: false);

  const BecomeMentorState.success()
      : this(status: BecomeMentorStatus.success, isCheckingExisting: false);

  const BecomeMentorState.failure(String message)
      : this(
          status: BecomeMentorStatus.failure,
          errorMessage: message,
          isCheckingExisting: false,
        );

  final BecomeMentorStatus status;
  final String? errorMessage;
  final MentorApplicationRecord? existing;
  final bool isCheckingExisting;

  bool get isSubmitting => status == BecomeMentorStatus.submitting;

  BecomeMentorState copyWith({
    BecomeMentorStatus? status,
    String? errorMessage,
    MentorApplicationRecord? existing,
    bool? isCheckingExisting,
  }) {
    return BecomeMentorState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      existing: existing ?? this.existing,
      isCheckingExisting: isCheckingExisting ?? this.isCheckingExisting,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, existing, isCheckingExisting];
}

enum BecomeMentorStatus { initial, submitting, success, failure }
