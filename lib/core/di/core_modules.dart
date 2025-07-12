import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
/// This File is used for SDKs/3rd party stuff.

@module
abstract class CoreModule {
  // Anything you *get* from a SDK goes here
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
