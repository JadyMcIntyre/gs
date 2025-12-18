import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/widgets/action_card.dart';
import 'package:godsufficient/core/widgets/app_page.dart';

import '../cubit/help_categories_cubit.dart';

class FindHelpCategoriesPage extends StatelessWidget {
  const FindHelpCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HelpCategoriesCubit(FirebaseFirestore.instance)..load(),
      child: BlocBuilder<HelpCategoriesCubit, HelpCategoriesState>(
        builder: (context, state) {
          if (state is HelpCategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HelpCategoriesError) {
            return Center(child: Text(state.message));
          }

          if (state is HelpCategoriesLoaded) {
            final projectId = Firebase.app().options.projectId;
            return AppPage(
              isScrollable: true,
              mainAxisAlignment: MainAxisAlignment.start,
              padding: const EdgeInsets.all(24),
              title: 'Get help',
              widgets: [
                Text(
                  'What are you looking for?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                if (state.categories.isEmpty) ...[
                  Text(
                    'No categories have been added yet.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Add documents in Firestore collection `help_categories` (fields: `name`, `description`, `icon`, `order`, `isActive`).",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Connected project: $projectId',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                      onPressed: () => context.read<HelpCategoriesCubit>().load(),
                      child: const Text('Reload'),
                    ),
                  ),
                ] else ...[
                  ...state.categories.map(
                    (c) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: ActionCard(
                        title: c.label,
                        subtitle: c.description,
                        icon: _iconForKey(c.icon),
                        onTap: () {
                          context.goNamed(
                            'help-get-help-centers',
                            pathParameters: {'categoryId': c.id},
                            extra: c,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

IconData _iconForKey(String? key) {
  switch (key?.toLowerCase().trim()) {
    case 'rehab':
    case 'rehabs':
    case 'recovery':
      return Icons.local_hospital_outlined;
    case 'counseling':
    case 'counselling':
    case 'therapy':
      return Icons.psychology_alt_outlined;
    case 'shelter':
    case 'housing':
      return Icons.home_work_outlined;
    case 'food':
    case 'pantry':
      return Icons.restaurant_outlined;
    case 'hotline':
    case 'crisis':
      return Icons.phone_in_talk_outlined;
    default:
      return Icons.support_agent_outlined;
  }
}
