import 'package:godsufficient/features/auth/domain/repo/auth_repo.dart';

class SignOut {
  final AuthRepo repo;
  SignOut(this.repo);

  Future<void> call() => repo.signOut();
}
