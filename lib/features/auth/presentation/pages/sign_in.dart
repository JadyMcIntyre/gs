import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/features/auth/presentation/widgets/auth_screen.dart';
import 'package:godsufficient/features/auth/presentation/cubit/auth_cubit.dart';

class SignInPage extends StatelessWidget {
  final _email = TextEditingController();
  final _pw = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) context.go('/home');
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return AuthScreen(
          emailController: _email,
          passwordController: _pw,
          action: () async => context.read<AuthCubit>().login(_email.text.trim(), _pw.text.trim()),
        );
      },
    );
  }
}
