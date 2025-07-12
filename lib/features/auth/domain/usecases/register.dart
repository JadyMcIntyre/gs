import 'package:godsufficient/features/auth/domain/entities/app_user.dart';
import 'package:godsufficient/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class Register {
  final AuthRepo repo;
  Register(this.repo);

  Future<AppUser?> call({required String email, required String password}) {
    return repo.register(email, password);
  }
}
