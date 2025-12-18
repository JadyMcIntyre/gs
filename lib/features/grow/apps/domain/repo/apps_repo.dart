import '../entities/gs_app.dart';

abstract class AppsRepo {
  Future<List<GsApp>> getApps();
}
