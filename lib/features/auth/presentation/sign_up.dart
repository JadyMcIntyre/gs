import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/common/widgets/page.dart';
import 'package:godsufficient/features/auth/presentation/cubit/auth_cubit.dart';

class SignUpPage extends StatelessWidget {
  final _email = TextEditingController();
  final _pw = TextEditingController();

  SignUpPage({super.key});

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
        return AppPage(
          widgets: [
            TextField(controller: _email),
            TextField(controller: _pw, obscureText: true),
            ElevatedButton(
              onPressed: () => context.read<AuthCubit>().signup(_email.text.trim(), _pw.text.trim()),
              child: const Text('Sign Up'),
            ),
            TextButton(onPressed: () => context.go('/sign-in'), child: const Text('Have an account? Sign in')),
          ],
        );
      },
    );
  }
}
