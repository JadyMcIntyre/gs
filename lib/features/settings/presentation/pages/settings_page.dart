import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              const SizedBox(height: 8),
              RadioListTile<ThemeMode>(
                value: ThemeMode.system,
                groupValue: mode,
                onChanged: (value) {
                  if (value != null) {
                    context.read<ThemeCubit>().setThemeMode(value);
                  }
                },
                title: const Text('System'),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: mode,
                onChanged: (value) {
                  if (value != null) {
                    context.read<ThemeCubit>().setThemeMode(value);
                  }
                },
                title: const Text('Dark'),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.light,
                groupValue: mode,
                onChanged: (value) {
                  if (value != null) {
                    context.read<ThemeCubit>().setThemeMode(value);
                  }
                },
                title: const Text('Light'),
              ),
            ],
          );
        },
      ),
    );
  }
}
