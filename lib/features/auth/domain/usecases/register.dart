import 'package:godsufficient/features/auth/domain/entities/app_user.dart';
import 'package:godsufficient/features/auth/domain/repositories/auth_repo.dart';

class Register {
  final AuthRepo repo;
  Register(this.repo);

  Future<AppUser?> call({required String email, required String password}) {
    return repo.register(email, password);
  }
}
