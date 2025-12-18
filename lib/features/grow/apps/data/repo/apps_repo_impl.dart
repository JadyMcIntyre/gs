import 'package:injectable/injectable.dart';
import '../../domain/repo/apps_repo.dart';
import '../datasources/remote/apps_remote_data_source.dart';
import '../../domain/entities/gs_app.dart';

@LazySingleton(as: AppsRepo)
class AppsRepoImpl implements AppsRepo {
  AppsRepoImpl(this._remote);

  final AppsRemoteDataSource _remote;

  @override
  Future<List<GsApp>> getApps() => _remote.getApps();
}
