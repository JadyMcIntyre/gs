import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../domain/entities/help_center_suggestion.dart';
import '../../domain/entities/help_center_suggestion_record.dart';
import '../../domain/exceptions/help_center_suggestion_exception.dart';
import '../../domain/repo/help_center_suggestion_repo.dart';
import '../datasources/remote/help_center_suggestion_remote_data_source.dart';
import '../models/help_center_suggestion_model.dart';

class HelpCenterSuggestionRepoImpl implements HelpCenterSuggestionRepo {
  HelpCenterSuggestionRepoImpl(this._remote, this._auth);

  final HelpCenterSuggestionRemoteDataSource _remote;
  final FirebaseAuth _auth;

  @override
  Future<void> submitSuggestion(HelpCenterSuggestion suggestion) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const HelpCenterSuggestionException('Please sign in before submitting a help center.');
    }

    final model = HelpCenterSuggestionModel.fromEntity(suggestion);

    try {
      await _remote.submitSuggestion(suggestion: model, userId: user.uid);
    } on FirebaseException catch (e) {
      throw HelpCenterSuggestionException(e.message ?? 'Unable to submit help center. (${e.code})');
    } catch (e) {
      throw const HelpCenterSuggestionException('Something went wrong while submitting your suggestion.');
    }
  }

  @override
  Future<List<HelpCenterSuggestionRecord>> getSuggestions() async {
    final user = _auth.currentUser;
    if (user == null) {
      return [];
    }

    try {
      return await _remote.getSuggestions(user.uid);
    } on FirebaseException catch (e) {
      throw HelpCenterSuggestionException(e.message ?? 'Unable to load help centers. (${e.code})');
    } catch (e) {
      throw const HelpCenterSuggestionException('Something went wrong while loading your suggestions.');
    }
  }

  @override
  Future<void> updateSuggestion(String suggestionId, HelpCenterSuggestion suggestion) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const HelpCenterSuggestionException('Please sign in before updating a help center.');
    }

    final model = HelpCenterSuggestionModel.fromEntity(suggestion);

    try {
      await _remote.updateSuggestion(
        userId: user.uid,
        suggestionId: suggestionId,
        suggestion: model,
      );
    } on FirebaseException catch (e) {
      throw HelpCenterSuggestionException(e.message ?? 'Unable to update help center. (${e.code})');
    } catch (e) {
      throw const HelpCenterSuggestionException('Something went wrong while updating your suggestion.');
    }
  }
}
