import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godsufficient/core/di/injection.dart';
import 'package:godsufficient/core/navigation/min_app.dart';
import 'package:godsufficient/features/grow/apps/domain/entities/gs_app.dart';
import 'package:godsufficient/features/grow/apps/domain/repo/apps_repo.dart';
import 'package:godsufficient/features/grow/apps/presentation/blocs/apps_cubit.dart';
import 'package:godsufficient/features/grow/apps/presentation/widgets/app_preview_card.dart';

class FindAppsPage extends StatelessWidget {
  const FindAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppsCubit(sl<AppsRepo>())..load(),
      child: BlocBuilder<AppsCubit, AppsState>(
        builder: (context, state) {
          return MinAppScaffold(
            title: 'Find apps',
            body: switch (state) {
              AppsLoading() => const Center(child: CircularProgressIndicator()),
              AppsError(:final message) => _ErrorState(
                  message: message,
                  onRetry: () => context.read<AppsCubit>().load(),
                ),
              AppsLoaded(:final apps) => _LoadedState(apps: apps),
            },
          );
        },
      ),
    );
  }
}

class _LoadedState extends StatelessWidget {
  const _LoadedState({required this.apps});
  final List<GsApp> apps;

  @override
  Widget build(BuildContext context) {
    if (apps.isEmpty) {
      final projectId = Firebase.app().options.projectId;
      return ListView(
        padding: EdgeInsets.zero,
        children: [
          Text(
            'No apps have been added yet.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Text(
            "Add documents in Firestore collection `apps` (fields: `name`, `description`, `logoUrl`, `tags`, `appStoreUrl`, `playStoreUrl`, `isActive`).",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Connected project: $projectId',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: apps.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final app = apps[i];
        return AppPreviewCard(
          name: app.name,
          description: app.description,
          tags: app.tags,
          logoUrl: app.logoUrl,
          onTap: () => showModalBottomSheet<void>(
            context: context,
            showDragHandle: true,
            isScrollControlled: true,
            builder: (context) => AppDetailsSheet(app: app),
          ),
        );
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
