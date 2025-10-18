import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/mentor_application.dart';
import '../../domain/entities/mentor_attachment.dart';
import '../../domain/exceptions/become_mentor_exception.dart';
import '../../domain/repo/become_mentor_repo.dart';

part 'become_mentor_state.dart';

@injectable
class BecomeMentorCubit extends Cubit<BecomeMentorState> {
  BecomeMentorCubit(this._repo) : super(const BecomeMentorState.initial());

  final BecomeMentorRepo _repo;

  Future<void> submit(
    MentorApplication application, {
    MentorApplicationAttachment? attachment,
  }) async {
    emit(const BecomeMentorState.submitting());

    try {
      await _repo.submitApplication(application, attachment: attachment);
      emit(const BecomeMentorState.success());
    } on BecomeMentorException catch (e) {
      emit(BecomeMentorState.failure(e.message));
    } catch (e) {
      emit(const BecomeMentorState.failure('Unable to submit your request right now.'));
    }
  }

  void reset() {
    emit(const BecomeMentorState.initial());
  }
}
