import 'package:godsufficient/features/auth/domain/entities/app_user.dart';
import 'package:godsufficient/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchAuth {
  final AuthRepo repo;
  WatchAuth(this.repo);

  Stream<AppUser?> call() => repo.authState();
}
