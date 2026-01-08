import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/di/injection.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:godsufficient/features/grow/apps/data/datasources/remote/app_suggestion_remote_data_source_impl.dart';
import 'package:godsufficient/features/grow/apps/data/repo/app_suggestion_repo_impl.dart';
import 'package:godsufficient/features/grow/apps/presentation/cubit/app_suggestion_cubit.dart';
import 'package:godsufficient/features/help/get_help/add_help/data/datasources/remote/help_center_suggestion_remote_data_source_impl.dart';
import 'package:godsufficient/features/help/get_help/add_help/data/repo/help_center_suggestion_repo_impl.dart';
import 'package:godsufficient/features/help/get_help/add_help/presentation/cubit/help_center_suggestion_cubit.dart';
import 'package:godsufficient/features/help/mentor/become_mentor/presentation/cubit/become_mentor_cubit.dart';

class SuggestionsApplicationsPage extends StatefulWidget {
  const SuggestionsApplicationsPage({super.key});

  @override
  State<SuggestionsApplicationsPage> createState() => _SuggestionsApplicationsPageState();
}

class _SuggestionsApplicationsPageState extends State<SuggestionsApplicationsPage> {
  bool _shownSubmissionDialog = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_shownSubmissionDialog) return;
    final extra = GoRouterState.of(context).extra;
    final shouldShow = extra is Map && extra['showSubmissionDialog'] == true;
    if (!shouldShow) return;

    _shownSubmissionDialog = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Submission received'),
          content: const Text('Successfully submitted. You may track progress here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appSuggestionRepo = AppSuggestionRepoImpl(
      AppSuggestionRemoteDataSourceImpl(FirebaseFirestore.instance),
      FirebaseAuth.instance,
    );
    final helpCenterSuggestionRepo = HelpCenterSuggestionRepoImpl(
      HelpCenterSuggestionRemoteDataSourceImpl(FirebaseFirestore.instance),
      FirebaseAuth.instance,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<BecomeMentorCubit>()..checkExisting()),
        BlocProvider(create: (_) => AppSuggestionCubit(appSuggestionRepo)..loadSuggestions()),
        BlocProvider(
          create: (_) => HelpCenterSuggestionCubit(helpCenterSuggestionRepo)..loadSuggestions(),
        ),
      ],
      child: BlocBuilder<BecomeMentorCubit, BecomeMentorState>(
        builder: (context, mentorState) {
          return BlocBuilder<AppSuggestionCubit, AppSuggestionState>(
            builder: (context, appState) {
              return BlocBuilder<HelpCenterSuggestionCubit, HelpCenterSuggestionState>(
                builder: (context, helpState) {
                  final sections = <Widget>[
                    _buildMentorSection(context, mentorState),
                    const SizedBox(height: 16),
                    _buildAppSection(context, appState),
                    const SizedBox(height: 16),
                    _buildHelpCenterSection(context, helpState),
                  ];

                  return AppPage(
                    title: 'Suggestions & Applications',
                    isScrollable: true,
                    widgets: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: sections,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMentorSection(BuildContext context, BecomeMentorState state) {
    if (state.isCheckingExisting) {
      return const _SectionCard(
        title: 'Mentor application',
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.status == BecomeMentorStatus.failure && state.errorMessage != null) {
      return _SectionCard(
        title: 'Mentor application',
        child: _ErrorSection(
          message: state.errorMessage!,
          onRetry: () => context.read<BecomeMentorCubit>().checkExisting(),
        ),
      );
    }

    if (state.existing == null) {
      return _SectionCard(
        title: 'Mentor application',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 40),
            const SizedBox(height: 12),
            const Text('No mentor applications yet.'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => context.go('/help/mentor/add'),
              child: const Text('Become a mentor'),
            ),
          ],
        ),
      );
    }

    final record = state.existing!;
    final canEdit = record.isSubmitted;

    return _SectionCard(
      title: 'Mentor application',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status: ${record.status}'),
          const SizedBox(height: 8),
          Text(
            canEdit
                ? 'You can update your application while it is submitted.'
                : 'Your application is under review and cannot be edited.',
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: canEdit ? () => context.go('/help/mentor/add') : null,
            child: const Text('Update application'),
          ),
        ],
      ),
    );
  }

  Widget _buildAppSection(BuildContext context, AppSuggestionState state) {
    if (state.isLoadingSuggestions) {
      return const _SectionCard(
        title: 'App suggestion',
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.status == AppSuggestionStatus.failure && state.errorMessage != null) {
      return _SectionCard(
        title: 'App suggestion',
        child: _ErrorSection(
          message: state.errorMessage!,
          onRetry: () => context.read<AppSuggestionCubit>().loadSuggestions(),
        ),
      );
    }

    if (state.suggestions.isEmpty) {
      return _SectionCard(
        title: 'App suggestion',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 40),
            const SizedBox(height: 12),
            const Text('No app suggestions yet.'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => context.go('/grow/apps/add'),
              child: const Text('Suggest an app'),
            ),
          ],
        ),
      );
    }

    return _SectionCard(
      title: 'App suggestion',
      child: Column(
        children: state.suggestions
            .map(
              (record) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SuggestionRow(
                  title: record.suggestion.name,
                  status: record.status,
                  icon: Icons.apps_outlined,
                  onEdit: record.isSubmitted
                      ? () => context.go('/grow/apps/add', extra: record)
                      : null,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildHelpCenterSection(BuildContext context, HelpCenterSuggestionState state) {
    if (state.isLoadingSuggestions) {
      return const _SectionCard(
        title: 'Help centre suggestion',
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.status == HelpCenterSuggestionStatus.failure && state.errorMessage != null) {
      return _SectionCard(
        title: 'Help centre suggestion',
        child: _ErrorSection(
          message: state.errorMessage!,
          onRetry: () => context.read<HelpCenterSuggestionCubit>().loadSuggestions(),
        ),
      );
    }

    if (state.suggestions.isEmpty) {
      return _SectionCard(
        title: 'Help centre suggestion',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 40),
            const SizedBox(height: 12),
            const Text('No help centre suggestions yet.'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => context.go('/help/get_help/add'),
              child: const Text('Add help centre'),
            ),
          ],
        ),
      );
    }

    return _SectionCard(
      title: 'Help centre suggestion',
      child: Column(
        children: state.suggestions
            .map(
              (record) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SuggestionRow(
                  title: record.suggestion.name,
                  status: record.status,
                  icon: Icons.support_agent,
                  onEdit: record.isSubmitted
                      ? () => context.go('/help/get_help/add', extra: record)
                      : null,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _ErrorSection extends StatelessWidget {
  const _ErrorSection({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ],
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({
    required this.title,
    required this.status,
    required this.icon,
    this.onEdit,
  });

  final String title;
  final String status;
  final IconData icon;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text('Status: $status'),
              ],
            ),
          ),
          TextButton(
            onPressed: onEdit,
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
}
