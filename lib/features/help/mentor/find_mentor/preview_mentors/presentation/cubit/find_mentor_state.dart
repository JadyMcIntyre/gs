part of 'find_mentor_cubit.dart';

sealed class FindMentorState extends Equatable {
  const FindMentorState();

  @override
  List<Object> get props => [];
}

final class FindMentorInitial extends FindMentorState {}

final class FindMentorLoading extends FindMentorState {}

final class FindMentorError extends FindMentorState {
  final String message;

  const FindMentorError(this.message);

  @override
  List<Object> get props => [message];
}

final class FindMentorLoaded extends FindMentorState {
  final List<Mentor> mentors;

  const FindMentorLoaded(this.mentors);

  @override
  List<Object> get props => [mentors];
}
