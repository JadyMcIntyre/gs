import 'package:go_router/go_router.dart';
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
