import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:godsufficient/features/auth/data/datasources/fb_auth_datasource.dart';
import 'package:godsufficient/features/auth/domain/repo/auth_repo.dart';
import 'package:godsufficient/features/auth/data/repo/auth_repo_impl.dart';
import 'package:godsufficient/features/auth/domain/usecases/sign_in.dart';
import 'package:godsufficient/features/auth/domain/usecases/register.dart';
import 'package:godsufficient/features/auth/domain/usecases/sign_out.dart';
import 'package:godsufficient/features/auth/domain/usecases/watch_auth.dart';
import 'package:godsufficient/features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

void initAuth() {
  // Data
  sl.registerLazySingleton(() => FirebaseAuthDatasource(FirebaseAuth.instance));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepositoryImpl(sl()));

  // Use-cases
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => WatchAuth(sl()));

  // Cubit
  sl.registerFactory(() => AuthCubit(signIn: sl(), register: sl(), signOut: sl(), watchAuth: sl()));
}
