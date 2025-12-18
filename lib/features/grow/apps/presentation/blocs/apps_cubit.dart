import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/gs_app.dart';
import '../../domain/repo/apps_repo.dart';

sealed class AppsState {
  const AppsState();
}

class AppsLoading extends AppsState {
  const AppsLoading();
}

class AppsError extends AppsState {
  const AppsError(this.message);
  final String message;
}

class AppsLoaded extends AppsState {
  const AppsLoaded(this.apps);
  final List<GsApp> apps;
}

class AppsCubit extends Cubit<AppsState> {
  AppsCubit(this._repo) : super(const AppsLoading());

  final AppsRepo _repo;

  Future<void> load() async {
    emit(const AppsLoading());
    try {
      final apps = await _repo.getApps();
      emit(AppsLoaded(apps));
    } catch (_) {
      emit(const AppsError('Unable to load apps.'));
    }
  }
}

