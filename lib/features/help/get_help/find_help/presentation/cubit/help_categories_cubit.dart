import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/help_category_model.dart';
import '../../domain/entities/help_category.dart';

sealed class HelpCategoriesState {
  const HelpCategoriesState();
}

class HelpCategoriesLoading extends HelpCategoriesState {
  const HelpCategoriesLoading();
}

class HelpCategoriesError extends HelpCategoriesState {
  const HelpCategoriesError(this.message);
  final String message;
}

class HelpCategoriesLoaded extends HelpCategoriesState {
  const HelpCategoriesLoaded(this.categories);
  final List<HelpCategory> categories;
}

class HelpCategoriesCubit extends Cubit<HelpCategoriesState> {
  HelpCategoriesCubit(this._firestore) : super(const HelpCategoriesLoading());

  final FirebaseFirestore _firestore;

  Future<void> load() async {
    emit(const HelpCategoriesLoading());
    try {
      final snapshot = await _firestore.collection('help_categories').get();
      final categories = snapshot.docs
          .where((d) => (d.data()['isActive'] as bool?) ?? true)
          .map(HelpCategoryModel.fromDoc)
          .toList()
        ..sort((a, b) {
          final ao = a.order ?? 1 << 30;
          final bo = b.order ?? 1 << 30;
          final byOrder = ao.compareTo(bo);
          if (byOrder != 0) return byOrder;
          return a.label.toLowerCase().compareTo(b.label.toLowerCase());
        });

      emit(HelpCategoriesLoaded(categories));
    } catch (e) {
      emit(HelpCategoriesError('Unable to load help categories.'));
    }
  }
}
