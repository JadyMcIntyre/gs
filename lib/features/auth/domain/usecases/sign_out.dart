import 'package:godsufficient/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignOut {
  final AuthRepo repo;
  SignOut(this.repo);

  Future<void> call() => repo.signOut();
}
