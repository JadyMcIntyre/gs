import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/navigation/min_app.dart';
import 'package:godsufficient/core/navigation/nav_models.dart';
import 'package:godsufficient/core/widgets/action_card.dart';
import 'package:godsufficient/core/widgets/split_actions.dart';
import 'package:godsufficient/features/help/mentor/become_mentor/presentation/pages/become_mentor.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/mentor_profile/presentation/pages/mentor_profile_page.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/preview_mentors/domain/entities/mentor.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/preview_mentors/presentation/pages/find_mentor.dart';
import 'package:godsufficient/features/home/presentation/home.dart';
import 'package:godsufficient/features/auth/presentation/pages/sign_in.dart';
import 'package:godsufficient/features/auth/presentation/pages/sign_up.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/sign_in',
  routes: [
    /// Auth ///
    GoRoute(path: '/sign_in', name: 'sign-in', builder: (context, state) => SignInPage()),
    GoRoute(path: '/sign_up', name: 'sign-up', builder: (context, state) => SignUpPage()),

    /// Home ///
    GoRoute(path: '/home', name: 'home', builder: (context, state) => const HomePage()),

    /// Help ///
    GoRoute(path: '/find_mentor', name: 'find-mentor', builder: (context, state) => FindMentor()),
    GoRoute(
      path: '/mentor_profile',
      name: 'view-mentor',
      builder: (context, state) {
        final mentor = state.extra as Mentor;
        return MentorProfilePage(mentor: mentor);
      },
    ),
    GoRoute(path: '/become_mentor', name: 'become-mentor', builder: (context, state) => BecomeMentor()),
    // GoRoute(
    //   path: '/details/:id',
    //   name: 'details',
    //   builder: (context, state) {
    //     final id = state.params['id']!;
    //     return DetailsPage(itemId: id);
    //   },
    // ),
    // …more routes…
  ],
);

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/grow',
    routes: [
      // Shell with bottom bar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navShell) {
          final idx = navShell.currentIndex;
          return Scaffold(
            body: navShell,
            bottomNavigationBar: NavigationBar(
              selectedIndex: idx,
              onDestinationSelected: navShell.goBranch,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.trending_up), label: 'Grow'),
                NavigationDestination(icon: Icon(Icons.volunteer_activism), label: 'Help'),
                NavigationDestination(icon: Icon(Icons.groups), label: 'Community'),
              ],
            ),
          );
        },
        branches: [
          _branchForMega(Mega.grow, const [Nested.apps, Nested.learn]),
          _branchForMega(Mega.help, const [Nested.get_help, Nested.mentor]),
          _branchForMega(Mega.community, const [Nested.church, Nested.volunteer]),
        ],
      ),
    ],
  );
}

StatefulShellBranch _branchForMega(Mega mega, List<Nested> nested) {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        path: '/${mega.path}',
        // This is the tab landing page (index) now
        builder: (context, state) => _MegaHome(mega: mega, nested: nested),
        routes: [
          GoRoute(
            path: ':nested',
            builder: (context, state) {
              final n = Nested.values.firstWhere((e) => e.path == state.pathParameters['nested']);
              return _NestedActions(nested: n);
            },
          ),
          GoRoute(
            path: ':nested/:action',
            builder: (context, state) {
              final n = Nested.values.firstWhere((e) => e.path == state.pathParameters['nested']);
              final a = state.pathParameters['action'] == 'add' ? ActionType.add : ActionType.find;
              return _DoAction(nested: n, action: a);
            },
          ),
        ],
      ),
    ],
  );
}

// Mega tab landing: shows the nested themes as cards
class _MegaHome extends StatelessWidget {
  const _MegaHome({required this.mega, required this.nested});
  final Mega mega;
  final List<Nested> nested;

  @override
  Widget build(BuildContext context) {
    return MinAppScaffold(
      title: mega.label,
      body: ListView.separated(
        itemCount: nested.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final n = nested[i];
          return ActionCard(
            title: n.label,
            subtitle: 'Open ${n.label.toLowerCase()} actions',
            icon: switch (n) {
              Nested.apps => Icons.apps,
              Nested.learn => Icons.menu_book,
              Nested.get_help => Icons.support_agent,
              Nested.mentor => Icons.school,
              Nested.church => Icons.church,
              Nested.volunteer => Icons.handshake,
            },
            onTap: () => context.go('/${mega.path}/${n.path}'),
          );
        },
      ),
    );
  }
}

// Nested theme page: two clear CTA buttons
class _NestedActions extends StatelessWidget {
  const _NestedActions({required this.nested});
  final Nested nested;

  @override
  Widget build(BuildContext context) {
    return MinAppScaffold(
      title: nested.label,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SplitActions(
            primaryLabel: nested.actionLabel(ActionType.find),
            secondaryLabel: nested.actionLabel(ActionType.add),
            onPrimary: () => context.go('/${nested.mega.path}/${nested.path}/find'),
            onSecondary: () => context.go('/${nested.mega.path}/${nested.path}/add'),
          ),
        ),
      ),
    );
  }
}

// Final action screen (stub): swap with actual “find/add” UIs per feature
class _DoAction extends StatelessWidget {
  const _DoAction({required this.nested, required this.action});
  final Nested nested;
  final ActionType action;

  @override
  Widget build(BuildContext context) {
    final title = nested.actionLabel(action);
    return MinAppScaffold(
      title: title,
      body: Center(
        child: Text(
          '$title\n(${nested.mega.label} / ${nested.label})',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
