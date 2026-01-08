import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/navigation/min_app.dart';
import 'package:godsufficient/core/theme/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MinAppScaffold(
      title: 'Settings',
      body: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return ListView(
            children: [
              const SizedBox(height: 8),
              Text('App mode', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(value: ThemeMode.system, label: Text('System')),
                  ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
                  ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                ],
                selected: {mode},
                onSelectionChanged: (values) {
                  context.read<ThemeCubit>().setThemeMode(values.first);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
