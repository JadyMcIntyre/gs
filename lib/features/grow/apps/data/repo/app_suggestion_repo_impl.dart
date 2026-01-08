import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../domain/entities/app_suggestion.dart';
import '../../domain/exceptions/app_suggestion_exception.dart';
import '../../domain/repo/app_suggestion_repo.dart';
import '../datasources/remote/app_suggestion_remote_data_source.dart';
import '../models/app_suggestion_model.dart';

class AppSuggestionRepoImpl implements AppSuggestionRepo {
  AppSuggestionRepoImpl(this._remote, this._auth);

  final AppSuggestionRemoteDataSource _remote;
  final FirebaseAuth _auth;

  @override
  Future<void> submitSuggestion(AppSuggestion suggestion) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AppSuggestionException('Please sign in before submitting an app suggestion.');
    }

    final model = AppSuggestionModel.fromEntity(suggestion);

    try {
      await _remote.submitSuggestion(suggestion: model, userId: user.uid);
    } on FirebaseException catch (e) {
      throw AppSuggestionException(e.message ?? 'Unable to submit app suggestion. (${e.code})');
    } catch (e) {
      throw const AppSuggestionException('Something went wrong while submitting your suggestion.');
    }
  }
}
