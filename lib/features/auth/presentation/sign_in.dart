import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/common/widgets/icon_button.dart';
import 'package:godsufficient/common/widgets/page.dart';
import 'package:godsufficient/common/widgets/text_field.dart';
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
        return AppPage(
          padding: const EdgeInsets.all(24),
          customCrossAxis: CrossAxisAlignment.center,
          widgets: [
            CustomTextField(controller: _email, label: 'Email', hint: 'john@gmail.com'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: CustomTextField(controller: _pw, obscureText: true, label: 'Password'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: FilledButton(
                onPressed: () => context.read<AuthCubit>().login(_email.text.trim(), _pw.text.trim()),
                child: const Text('Sign In'),
              ),
            ),
            CustomIconButton(onPressed: () {}, iconData: Icons.apple),
            TextButton(
              onPressed: () => context.go('/sign-up'),
              child: const Text('Dont have an account? Register here'),
            ),
          ],
        );
      },
    );
  }
}
