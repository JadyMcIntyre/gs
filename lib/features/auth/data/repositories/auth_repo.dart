import 'package:godsufficient/features/auth/data/models/app_user_model.dart';

abstract class AuthRepo {
  Future<AppUser?> signIn(String email, String pw);

  Future<AppUser?> register(String email, String pw);

  Future<void> signOut();

  Stream<AppUser?> authState();
}
