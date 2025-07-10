import 'package:go_router/go_router.dart';
import 'package:godsufficient/features/home/presentation/home.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => HomePage(),
      // you can inject a Bloc here if needed:
      // builder: (context, state) => BlocProvider(
      //   create: (_) => HomeCubit(),
      //   child: HomePage(),
      // ),
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
