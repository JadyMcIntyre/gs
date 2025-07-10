import 'package:flutter/material.dart';
import 'package:godsufficient/common/widgets/page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godsufficient/features/auth/presentation/cubit/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(title: 'Home', widgets: [
      FilledButton(
        onPressed: () => context.read<AuthCubit>().logout(),
        child: const Text('Sign Out'),
      )
    ]);
  }
}
