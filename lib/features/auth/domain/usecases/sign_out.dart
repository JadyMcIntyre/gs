import 'package:godsufficient/features/auth/domain/repositories/auth_repo.dart';

class SignOut {
  final AuthRepo repo;
  SignOut(this.repo);

  Future<void> call() => repo.signOut();
}
