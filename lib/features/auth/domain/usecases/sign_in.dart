import 'package:godsufficient/features/auth/domain/entities/app_user.dart';
import 'package:godsufficient/features/auth/domain/repo/auth_repo.dart';

class SignIn {
  final AuthRepo repo;
  SignIn(this.repo);

  Future<AppUser?> call({required String email, required String password}) {
    return repo.signIn(email, password);
  }
}
