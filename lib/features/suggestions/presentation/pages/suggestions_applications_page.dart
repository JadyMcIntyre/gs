import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/di/injection.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:godsufficient/features/help/mentor/become_mentor/presentation/cubit/become_mentor_cubit.dart';

class SuggestionsApplicationsPage extends StatelessWidget {
  const SuggestionsApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BecomeMentorCubit>()..checkExisting(),
      child: BlocBuilder<BecomeMentorCubit, BecomeMentorState>(
        builder: (context, state) {
          Widget body;

          if (state.isCheckingExisting) {
            body = const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state.status == BecomeMentorStatus.failure && state.errorMessage != null) {
            body = Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.errorMessage!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.read<BecomeMentorCubit>().checkExisting(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state.existing == null) {
            body = Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.inbox_outlined, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    'No suggestions or applications yet.',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () => context.go('/help/mentor/add'),
                    child: const Text('Become a mentor'),
                  ),
                ],
              ),
            );
          } else {
            final record = state.existing!;
            final canEdit = record.isSubmitted;

            body = Padding(
              padding: const EdgeInsets.all(24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mentor application',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text('Status: ${record.status}'),
                      const SizedBox(height: 12),
                      Text(
                        canEdit
                            ? 'You can update your application while it is submitted.'
                            : 'Your application is under review and cannot be edited.',
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: canEdit ? () => context.go('/help/mentor/add') : null,
                        child: const Text('Update application'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return AppPage(
            title: 'Suggestions & Applications',
            isScrollable: true,
            widgets: [body],
          );
        },
      ),
    );
  }
}
