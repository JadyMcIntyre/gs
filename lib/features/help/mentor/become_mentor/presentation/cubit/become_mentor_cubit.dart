import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/mentor_application.dart';
import '../../domain/entities/mentor_application_record.dart';
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
    emit(state.copyWith(status: BecomeMentorStatus.submitting, errorMessage: null));

    try {
      await _repo.submitApplication(application, attachment: attachment);
      emit(state.copyWith(status: BecomeMentorStatus.success));
    } on BecomeMentorException catch (e) {
      emit(state.copyWith(status: BecomeMentorStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
        status: BecomeMentorStatus.failure,
        errorMessage: 'Unable to submit your request right now.',
      ));
    }
  }

  Future<void> checkExisting() async {
    emit(state.copyWith(isCheckingExisting: true, errorMessage: null));
    try {
      final existing = await _repo.getExistingApplication();
      emit(state.copyWith(existing: existing, isCheckingExisting: false));
    } on BecomeMentorException catch (e) {
      emit(state.copyWith(
        status: BecomeMentorStatus.failure,
        errorMessage: e.message,
        isCheckingExisting: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BecomeMentorStatus.failure,
        errorMessage: 'Unable to load your request right now.',
        isCheckingExisting: false,
      ));
    }
  }

  void reset() {
    emit(const BecomeMentorState.initial());
  }
}
