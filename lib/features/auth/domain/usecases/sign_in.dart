import 'package:godsufficient/features/auth/data/models/app_user_model.dart';
import 'package:godsufficient/features/auth/data/repositories/auth_repo.dart';

class SignIn {
  final AuthRepo repo;
  SignIn(this.repo);

  Future<AppUser?> call({required String email, required String password}) {
    return repo.signIn(email, password);
  }
}
