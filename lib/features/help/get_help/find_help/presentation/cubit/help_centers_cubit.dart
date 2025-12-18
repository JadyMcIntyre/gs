import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/help_center_model.dart';
import '../../domain/entities/help_center.dart';

sealed class HelpCentersState {
  const HelpCentersState();
}

class HelpCentersLoading extends HelpCentersState {
  const HelpCentersLoading();
}

class HelpCentersError extends HelpCentersState {
  const HelpCentersError(this.message);
  final String message;
}

class HelpCentersLoaded extends HelpCentersState {
  const HelpCentersLoaded(this.centers);
  final List<HelpCenter> centers;
}

class HelpCentersCubit extends Cubit<HelpCentersState> {
  HelpCentersCubit(this._firestore) : super(const HelpCentersLoading());

  final FirebaseFirestore _firestore;

  Future<void> load({required String categoryId}) async {
    emit(const HelpCentersLoading());
    try {
      final snapshot =
          await _firestore.collection('help_centers').where('categoryId', isEqualTo: categoryId).get();

      final centers = snapshot.docs.map(HelpCenterModel.fromDoc).where((c) => c.categoryId.isNotEmpty).toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(HelpCentersLoaded(centers));
    } catch (e) {
      emit(HelpCentersError('Unable to load places for this category.'));
    }
  }
}

