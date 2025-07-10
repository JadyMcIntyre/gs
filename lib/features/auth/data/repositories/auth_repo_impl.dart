import 'package:firebase_auth/firebase_auth.dart';
import 'package:godsufficient/features/auth/data/datasources/fb_auth_datasource.dart';
import 'package:godsufficient/features/auth/data/models/app_user_model.dart';
import 'package:godsufficient/features/auth/data/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepo {
  final FirebaseAuthDatasource ds;

  AuthRepositoryImpl(this.ds);

  @override
  Future<AppUser?> signIn(String email, String pw) => ds.signInWithEmail(email, pw).then(_toEntity);

  @override
  Future<AppUser?> register(String email, String pw) => ds.register(email, pw).then(_toEntity);

  @override
  Future<void> signOut() => ds.signOut();

  @override
  Stream<AppUser?> authState() => ds.authChanges().map(_toEntity);

  AppUser? _toEntity(User? u) => u == null ? null : AppUser.fromFirebase(u);
}
