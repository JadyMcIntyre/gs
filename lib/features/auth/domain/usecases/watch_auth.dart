import 'package:godsufficient/features/auth/domain/entities/app_user.dart';
import 'package:godsufficient/features/auth/domain/repositories/auth_repo.dart';

class WatchAuth {
  final AuthRepo repo;
  WatchAuth(this.repo);

  Stream<AppUser?> call() => repo.authState();
}
