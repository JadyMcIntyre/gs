import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godsufficient/features/auth/presentation/cubit/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      isScrollable: true,
      title: 'Home',
      widgets: [
        const Text('Temporary Entry Points'),
        const Text('Help Section'),
        const Text('Mentor'),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/find_mentor'), child: Text('Find Mentor')),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/become_mentor'), child: Text('Become Mentor')),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const Text('Get Help'),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/find_mentor'), child: Text("Find Help 'centers'")),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/become_mentor'), child: Text("List Help 'centers'")),
            ),
            const SizedBox(width: 10),
          ],
        ),
        Padding(padding: const EdgeInsets.all(8.0), child: const Divider()),
        const Text('Grow Section'),
        const Text('Apps'),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/find_mentor'), child: Text('Explore Apps')),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/become_mentor'), child: Text('Suggest an App')),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const Text('Learn'),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                onPressed: () => context.push('/find_mentor'),
                child: Text("Explore learning resources"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                onPressed: () => context.push('/become_mentor'),
                child: Text("Suggest learning resources"),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        Padding(padding: const EdgeInsets.all(8.0), child: const Divider()),
        const Text('Community Section'),
        const Text('Church'),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              /// future search area to find churches there
              child: FilledButton(onPressed: () => context.push('/find_mentor'), child: Text('Churches near you')),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/become_mentor'), child: Text('Suggest a Church')),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const Text('Volunteer'),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/find_mentor'), child: Text("Get Involved")),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(onPressed: () => context.push('/become_mentor'), child: Text("List an event")),
            ),
            const SizedBox(width: 10),
          ],
        ),
        Padding(padding: const EdgeInsets.all(8.0), child: const Divider()),
        FilledButton(onPressed: () => context.read<AuthCubit>().logout(), child: const Text('Sign Out')),
      ],
    );
  }
}
