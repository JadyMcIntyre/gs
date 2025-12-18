import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/gs_app.dart';
import 'apps_remote_data_source.dart';
import '../../models/gs_app_model.dart';

@LazySingleton(as: AppsRemoteDataSource)
class AppsRemoteDataSourceImpl implements AppsRemoteDataSource {
  AppsRemoteDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<List<GsApp>> getApps() async {
    final snapshot = await _firestore.collection('apps').get();
    final apps = snapshot.docs
        .map(GsAppModel.fromDoc)
        .where((a) => a.isActive)
        .toList(growable: false);

    final sorted = [...apps]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return sorted.cast<GsApp>();
  }
}
