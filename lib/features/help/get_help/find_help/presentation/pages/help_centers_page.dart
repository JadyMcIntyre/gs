import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godsufficient/core/widgets/app_page.dart';

import '../../domain/entities/help_category.dart';
import '../cubit/help_centers_cubit.dart';
import '../widgets/help_center_preview.dart';

class HelpCentersPage extends StatelessWidget {
  const HelpCentersPage({
    super.key,
    required this.categoryId,
    this.category,
  });

  final String categoryId;
  final HelpCategory? category;

  @override
  Widget build(BuildContext context) {
    final title = category?.label ?? 'Places';

    return BlocProvider(
      create: (_) => HelpCentersCubit(FirebaseFirestore.instance)..load(categoryId: categoryId),
      child: BlocBuilder<HelpCentersCubit, HelpCentersState>(
        builder: (context, state) {
          if (state is HelpCentersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HelpCentersError) {
            return Center(child: Text(state.message));
          }

          if (state is HelpCentersLoaded) {
            return AppPage(
              isScrollable: true,
              mainAxisAlignment: MainAxisAlignment.start,
              padding: const EdgeInsets.all(24),
              title: title,
              widgets: [
                if (category?.description != null && category!.description!.trim().isNotEmpty) ...[
                  Text(category!.description!, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 12),
                ],
                if (state.centers.isEmpty)
                  Text(
                    'No places are listed in this category yet.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                else
                  ...state.centers.map(
                    (c) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: HelpCenterPreview(
                        name: c.name,
                        description: c.description,
                        address: c.address,
                        phone: c.phone,
                        tags: c.tags,
                        imageUrl: c.imageUrl,
                      ),
                    ),
                  ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

