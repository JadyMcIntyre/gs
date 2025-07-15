import 'package:go_router/go_router.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/presentation/pages/find_mentor.dart';
import 'package:godsufficient/features/home/presentation/home.dart';
import 'package:godsufficient/features/auth/presentation/pages/sign_in.dart';
import 'package:godsufficient/features/auth/presentation/pages/sign_up.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/sign_in',
  routes: [
    GoRoute(path: '/home', name: 'home', builder: (context, state) => const HomePage()),
    GoRoute(path: '/sign_in', name: 'sign-in', builder: (context, state) => SignInPage()),
    GoRoute(path: '/sign_up', name: 'sign-up', builder: (context, state) => SignUpPage()),
    GoRoute(path: '/find_mentor', name: 'find-mentor', builder: (context, state) => FindMentor()),
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
