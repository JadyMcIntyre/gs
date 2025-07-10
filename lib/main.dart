import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godsufficient/common/dependencies/dependencies.dart';
import 'package:godsufficient/common/router/app_router.dart';
import 'package:godsufficient/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:godsufficient/firebase_options.dart';
import 'package:godsufficient/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initAuth();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<AuthCubit>())],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'God Sufficient',
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
