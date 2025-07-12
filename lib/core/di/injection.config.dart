// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:godsufficient/core/di/core_modules.dart' as _i575;
import 'package:godsufficient/features/auth/data/datasources/fb_auth_datasource.dart'
    as _i219;
import 'package:godsufficient/features/auth/data/repo/auth_repo_impl.dart'
    as _i775;
import 'package:godsufficient/features/auth/domain/repo/auth_repo.dart'
    as _i642;
import 'package:godsufficient/features/auth/domain/usecases/register.dart'
    as _i116;
import 'package:godsufficient/features/auth/domain/usecases/sign_in.dart'
    as _i915;
import 'package:godsufficient/features/auth/domain/usecases/sign_out.dart'
    as _i729;
import 'package:godsufficient/features/auth/domain/usecases/watch_auth.dart'
    as _i1055;
import 'package:godsufficient/features/auth/presentation/cubit/auth_cubit.dart'
    as _i1017;
import 'package:godsufficient/features/community/church/data/datasources/remote/church_remote_data_source.dart'
    as _i658;
import 'package:godsufficient/features/community/church/data/datasources/remote/church_remote_data_source_impl.dart'
    as _i534;
import 'package:godsufficient/features/community/church/data/repo/church_repo_impl.dart'
    as _i335;
import 'package:godsufficient/features/community/church/domain/repo/church_repo.dart'
    as _i626;
import 'package:godsufficient/features/community/volunteer/data/datasources/remote/volunteer_remote_data_source.dart'
    as _i124;
import 'package:godsufficient/features/community/volunteer/data/datasources/remote/volunteer_remote_data_source_impl.dart'
    as _i917;
import 'package:godsufficient/features/community/volunteer/data/repo/volunteer_repo_impl.dart'
    as _i34;
import 'package:godsufficient/features/community/volunteer/domain/repo/volunteer_repo.dart'
    as _i338;
import 'package:godsufficient/features/grow/apps/data/datasources/remote/apps_remote_data_source.dart'
    as _i821;
import 'package:godsufficient/features/grow/apps/data/datasources/remote/apps_remote_data_source_impl.dart'
    as _i388;
import 'package:godsufficient/features/grow/apps/data/repo/apps_repo_impl.dart'
    as _i497;
import 'package:godsufficient/features/grow/apps/domain/repo/apps_repo.dart'
    as _i526;
import 'package:godsufficient/features/grow/learn/data/datasources/remote/learn_remote_data_source.dart'
    as _i995;
import 'package:godsufficient/features/grow/learn/data/datasources/remote/learn_remote_data_source_impl.dart'
    as _i562;
import 'package:godsufficient/features/grow/learn/data/repo/learn_repo_impl.dart'
    as _i26;
import 'package:godsufficient/features/grow/learn/domain/repo/learn_repo.dart'
    as _i242;
import 'package:godsufficient/features/help/get_help/data/datasources/remote/get_help_remote_data_source.dart'
    as _i128;
import 'package:godsufficient/features/help/get_help/data/datasources/remote/get_help_remote_data_source_impl.dart'
    as _i693;
import 'package:godsufficient/features/help/get_help/data/repo/get_help_repo_impl.dart'
    as _i900;
import 'package:godsufficient/features/help/get_help/domain/repo/get_help_repo.dart'
    as _i786;
import 'package:godsufficient/features/help/mentor/become_mentor/data/datasources/remote/become_mentor_remote_data_source.dart'
    as _i990;
import 'package:godsufficient/features/help/mentor/become_mentor/data/datasources/remote/become_mentor_remote_data_source_impl.dart'
    as _i485;
import 'package:godsufficient/features/help/mentor/become_mentor/data/repo/become_mentor_repo_impl.dart'
    as _i600;
import 'package:godsufficient/features/help/mentor/become_mentor/domain/repo/become_mentor_repo.dart'
    as _i533;
import 'package:godsufficient/features/help/mentor/find_mentor/data/datasources/remote/find_mentor_remote_data_source.dart'
    as _i213;
import 'package:godsufficient/features/help/mentor/find_mentor/data/datasources/remote/find_mentor_remote_data_source_impl.dart'
    as _i1048;
import 'package:godsufficient/features/help/mentor/find_mentor/data/repo/find_mentor_repo_impl.dart'
    as _i572;
import 'package:godsufficient/features/help/mentor/find_mentor/domain/repo/find_mentor_repo.dart'
    as _i403;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final coreModule = _$CoreModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => coreModule.firebaseAuth);
    gh.lazySingleton<_i626.ChurchRepo>(() => _i335.ChurchRepoImpl());
    gh.lazySingleton<_i213.FindMentorRemoteDataSource>(
      () => _i1048.FindMentorRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i526.AppsRepo>(() => _i497.AppsRepoImpl());
    gh.lazySingleton<_i128.GetHelpRemoteDataSource>(
      () => _i693.GetHelpRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i533.BecomeMentorRepo>(
      () => _i600.BecomeMentorRepoImpl(),
    );
    gh.lazySingleton<_i658.ChurchRemoteDataSource>(
      () => _i534.ChurchRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i995.LearnRemoteDataSource>(
      () => _i562.LearnRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i124.VolunteerRemoteDataSource>(
      () => _i917.VolunteerRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i990.BecomeMentorRemoteDataSource>(
      () => _i485.BecomeMentorRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i821.AppsRemoteDataSource>(
      () => _i388.AppsRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i786.GetHelpRepo>(() => _i900.GetHelpRepoImpl());
    gh.lazySingleton<_i403.FindMentorRepo>(() => _i572.FindMentorRepoImpl());
    gh.lazySingleton<_i242.LearnRepo>(() => _i26.LearnRepoImpl());
    gh.lazySingleton<_i338.VolunteerRepo>(() => _i34.VolunteerRepoImpl());
    gh.factory<_i219.FirebaseAuthDatasource>(
      () => _i219.FirebaseAuthDatasource(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i642.AuthRepo>(
      () => _i775.AuthRepoImpl(gh<_i219.FirebaseAuthDatasource>()),
    );
    gh.factory<_i116.Register>(() => _i116.Register(gh<_i642.AuthRepo>()));
    gh.factory<_i915.SignIn>(() => _i915.SignIn(gh<_i642.AuthRepo>()));
    gh.factory<_i729.SignOut>(() => _i729.SignOut(gh<_i642.AuthRepo>()));
    gh.factory<_i1055.WatchAuth>(() => _i1055.WatchAuth(gh<_i642.AuthRepo>()));
    gh.factory<_i1017.AuthCubit>(
      () => _i1017.AuthCubit(
        signIn: gh<_i915.SignIn>(),
        register: gh<_i116.Register>(),
        signOut: gh<_i729.SignOut>(),
        watchAuth: gh<_i1055.WatchAuth>(),
      ),
    );
    return this;
  }
}

class _$CoreModule extends _i575.CoreModule {}
