import 'package:go_router/go_router.dart';
import 'package:godsufficient/features/home/presentation/home.dart';
import 'package:godsufficient/features/auth/presentation/sign_in.dart';
import 'package:godsufficient/features/auth/presentation/sign_up.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/sign-in',
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/sign-in',
      name: 'sign-in',
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: '/sign-up',
      name: 'sign-up',
      builder: (context, state) => SignUpPage(),
    ),
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
