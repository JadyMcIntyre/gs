import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/widgets/icon_button.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:godsufficient/core/widgets/text_field.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.action,
    this.isSigningIn = true,
  });
  final TextEditingController emailController, passwordController;
  final VoidCallback action;
  final bool isSigningIn;

  @override
  Widget build(BuildContext context) {
    final title = isSigningIn ? 'Sign In' : 'Sign Up';
    final redirectPath = isSigningIn ? '/sign-up' : '/sign-in';
    final redirectText = isSigningIn ? 'Don’t have an account? Register here' : 'Already have an account? Log in here';

    return AppPage(
      padding: const EdgeInsets.all(24),
      customCrossAxis: CrossAxisAlignment.center,
      widgets: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        const SizedBox(height: 20),
        CustomTextField(controller: emailController, label: 'Email', hint: 'john@gmail.com'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: CustomTextField(controller: passwordController, obscureText: true, label: 'Password'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FilledButton(onPressed: action, child: Text(title)),
        ),
        // Third Party Auth
        CustomIconButton(onPressed: () {}, iconData: Icons.apple),
        // Redirect
        TextButton(onPressed: () => context.go(redirectPath), child: Text(redirectText)),
      ],
    );
  }
}
