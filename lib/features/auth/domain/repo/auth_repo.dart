import "package:godsufficient/features/auth/domain/entities/app_user.dart";

abstract class AuthRepo {
  Future<AppUser?> signIn(String email, String pw);
  Future<AppUser?> register(String email, String pw);
  Future<void> signOut();
  Stream<AppUser?> authState();
}
