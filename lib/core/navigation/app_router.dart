import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/navigation/min_app.dart';
import 'package:godsufficient/core/navigation/nav_models.dart';
import 'package:godsufficient/core/widgets/action_card.dart';
import 'package:godsufficient/core/widgets/split_actions.dart';
import 'package:godsufficient/features/help/get_help/add_help/presentation/pages/add_help_center_page.dart';
import 'package:godsufficient/features/help/get_help/find_help/presentation/pages/find_help_categories_page.dart';
import 'package:godsufficient/features/help/get_help/find_help/presentation/pages/help_centers_page.dart';
import 'package:godsufficient/features/help/get_help/find_help/domain/entities/help_category.dart';
import 'package:godsufficient/features/help/mentor/become_mentor/presentation/pages/become_mentor.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/mentor_profile/presentation/pages/mentor_profile_page.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/preview_mentors/domain/entities/mentor.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/preview_mentors/presentation/pages/find_mentor.dart';
import 'package:godsufficient/features/grow/apps/presentation/pages/find_apps_page.dart';
import 'package:godsufficient/features/auth/presentation/pages/sign_in.dart';
import 'package:godsufficient/features/auth/presentation/pages/sign_up.dart';
import 'package:godsufficient/features/settings/presentation/pages/settings_page.dart';

GoRouter buildRouter() {
  return GoRouter(
    // If you want to start on auth, keep /sign_in. After login, call context.go('/grow')
    initialLocation: '/sign_in',
    routes: [
      // ---------- AUTH (top-level) ----------
      GoRoute(path: '/sign_in', name: 'sign-in', builder: (context, state) => SignInPage()),
      GoRoute(path: '/sign_up', name: 'sign-up', builder: (context, state) => SignUpPage()),
      GoRoute(path: '/settings', name: 'settings', builder: (context, state) => const SettingsPage()),

      // ---------- OPTIONAL REDIRECTS from old paths ----------
      GoRoute(path: '/find_mentor', redirect: (_, __) => '/help/mentor/find'),
      GoRoute(path: '/become_mentor', redirect: (_, __) => '/help/mentor/add'),

      // ---------- SHELL WITH BOTTOM NAV ----------
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
          _helpBranch(), // <--- special: we wire mentor pages here
          _branchForMega(Mega.community, const [Nested.church, Nested.volunteer]),
        ],
      ),
    ],
  );
}

// Generic branch for Grow/Community
StatefulShellBranch _branchForMega(Mega mega, List<Nested> nested) {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        path: '/${mega.path}',
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
              if (n == Nested.apps && a == ActionType.find) {
                return const FindAppsPage();
              }
              return _DoAction(nested: n, action: a); // stub for not-yet-built screens
            },
          ),
        ],
      ),
    ],
  );
}

// Help branch with real mentor pages on the new URLs
StatefulShellBranch _helpBranch() {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        path: '/help',
        builder: (context, state) => _MegaHome(mega: Mega.help, nested: const [Nested.get_help, Nested.mentor]),
        routes: [
          // nested index -> two buttons (Find / Add)
          GoRoute(
            path: ':nested',
            builder: (context, state) {
              final n = Nested.values.firstWhere((e) => e.path == state.pathParameters['nested']);
              return _NestedActions(nested: n);
            },
          ),
          // Get help
          GoRoute(path: 'get_help/find', name: 'help-get-help-find', builder: (context, state) => const FindHelpCategoriesPage()),
          GoRoute(
            path: 'get_help/find/:categoryId',
            name: 'help-get-help-centers',
            builder: (context, state) => HelpCentersPage(
              categoryId: state.pathParameters['categoryId']!,
              category: state.extra is HelpCategory ? state.extra as HelpCategory : null,
            ),
          ),
          GoRoute(path: 'get_help/add', name: 'help-get-help-add', builder: (context, state) => const AddHelpCenterPage()),
          // New canonical URLs for your existing pages:
          GoRoute(path: 'mentor/find', name: 'help-mentor-find', builder: (context, state) => const FindMentor()),
          GoRoute(path: 'mentor/add', name: 'help-mentor-add', builder: (context, state) => BecomeMentor()),
          // Optional: mentor profile under Help
          GoRoute(
            path: 'mentor/find/profile',
            name: 'selected-mentor',
            builder: (context, state) {
              final mentor = state.extra as Mentor;
              return MentorProfilePage(mentor: mentor);
            },
          ),
        ],
      ),
    ],
  );
}

// ---------------- UI scaffolding below (unchanged) ----------------

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
            // These URLs now resolve to your real pages for mentor;
            // for other features, they hit _DoAction stub until you build them.
            onPrimary: () => context.go('/${nested.mega.path}/${nested.path}/find'),
            onSecondary: () => context.go('/${nested.mega.path}/${nested.path}/add'),
          ),
        ),
      ),
    );
  }
}

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
