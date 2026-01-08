import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godsufficient/core/di/injection.dart';
import 'package:godsufficient/core/navigation/app_router.dart';
import 'package:godsufficient/core/theme/theme_cubit.dart';
import 'package:godsufficient/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:godsufficient/firebase_options.dart';
import 'package:godsufficient/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    // androidProvider: AndroidProvider.playIntegrity,
    androidProvider: AndroidProvider.debug,
    // appleProvider: AppleProvider.appAttest,
  );
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = buildRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            routerConfig: _router,
            title: 'God Sufficient',
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}
