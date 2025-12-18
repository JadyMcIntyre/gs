import '../../../domain/entities/gs_app.dart';

abstract class AppsRemoteDataSource {
  Future<List<GsApp>> getApps();
}
