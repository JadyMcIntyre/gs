import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseAuthDatasource {
  final FirebaseAuth _auth;

  FirebaseAuthDatasource(this._auth);

  Future<User?> signInWithEmail(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password)
           .then((cred) => cred.user);

  Future<User?> register(String email, String password) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password)
           .then((cred) => cred.user);

  Future<void> signOut() => _auth.signOut();

  Stream<User?> authChanges() => _auth.authStateChanges();
}
