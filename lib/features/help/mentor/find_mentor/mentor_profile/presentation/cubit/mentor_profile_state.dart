part of 'mentor_profile_cubit.dart';

sealed class MentorProfileState extends Equatable {
  const MentorProfileState();

  @override
  List<Object> get props => [];
}

final class MentorProfileInitial extends MentorProfileState {}
