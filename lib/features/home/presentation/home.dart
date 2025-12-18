import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godsufficient/features/auth/presentation/cubit/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppPage(
      isScrollable: true,
      title: 'Home',
      widgets: [
        Text('Help Section', style: textTheme.titleLarge),
        Text('Mentor', style: textTheme.titleMedium),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/find_mentor'), child: const Text('Find Mentor')),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(onPressed: () => context.push('/become_mentor'), child: const Text('Become Mentor')),
            ),
            const SizedBox(width: 10),
          ],
        ),
        Text('Get Help', style: textTheme.titleMedium),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.push('/help/get_help/find'),
                child: const Text("Find Help 'centers'"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                onPressed: () => context.push('/help/get_help/add'),
                child: const Text("List Help 'centers'"),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
        Text('Grow Section', style: textTheme.titleLarge),
        Text('Apps', style: textTheme.titleMedium),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/find_mentor'), child: const Text('Explore Apps')),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(onPressed: () => context.push('/become_mentor'), child: const Text('Suggest an App')),
            ),
            const SizedBox(width: 10),
          ],
        ),
        Text('Learn', style: textTheme.titleMedium),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.push('/find_mentor'),
                child: const Text("Explore learning resources"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                onPressed: () => context.push('/become_mentor'),
                child: const Text("Suggest learning resources"),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
        Text('Community Section', style: textTheme.titleLarge),
        Text('Church', style: textTheme.titleMedium),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                onPressed: () => context.push('/find_mentor'),
                child: const Text('Churches near you'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.push('/become_mentor'),
                child: const Text('Suggest a Church'),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        Text('Volunteer', style: textTheme.titleMedium),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(onPressed: () => context.push('/find_mentor'), child: const Text("Get Involved")),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/become_mentor'), child: const Text("List an event")),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
        FilledButton(onPressed: () => context.read<AuthCubit>().logout(), child: const Text('Sign Out')),
      ],
    );
  }
}
