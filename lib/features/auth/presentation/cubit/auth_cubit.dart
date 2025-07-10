import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:godsufficient/features/auth/domain/entities/app_user.dart';
import 'package:godsufficient/features/auth/domain/usecases/sign_in.dart';
import 'package:godsufficient/features/auth/domain/usecases/register.dart';
import 'package:godsufficient/features/auth/domain/usecases/sign_out.dart';
import 'package:godsufficient/features/auth/domain/usecases/watch_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignIn _signIn;
  final Register _register;
  final SignOut _signOut;
  final WatchAuth _watchAuth;

  late final StreamSubscription _sub;

  AuthCubit({
    required SignIn signIn,
    required Register register,
    required SignOut signOut,
    required WatchAuth watchAuth,
  })  : _signIn = signIn,
        _register = register,
        _signOut = signOut,
        _watchAuth = watchAuth,
        super(AuthInitial()) {
    _sub = _watchAuth().listen((user) {
      emit(user == null ? Unauthenticated() : Authenticated(user));
    });
  }

  Future<void> login(String email, String pw) async {
    emit(AuthLoading());
    final user =
        await _signIn(email: email, password: pw).catchError((e) => emit(AuthFailure(e.toString())));
    if (user != null) emit(Authenticated(user));
  }

  Future<void> signup(String email, String pw) async {
    emit(AuthLoading());
    final user =
        await _register(email: email, password: pw).catchError((e) => emit(AuthFailure(e.toString())));
    if (user != null) emit(Authenticated(user));
  }

  Future<void> logout() async => _signOut();

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}

