import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mentor_profile_state.dart';

class MentorProfileCubit extends Cubit<MentorProfileState> {
  MentorProfileCubit() : super(MentorProfileInitial());
}
