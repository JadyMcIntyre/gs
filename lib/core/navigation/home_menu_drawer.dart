import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:godsufficient/theme/app_icons.dart';
import 'package:godsufficient/theme/theme_mode_cubit.dart';

class HomeMenuDrawer extends StatelessWidget {
  const HomeMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Menu', style: textTheme.headlineSmall),
              ),
            ),
            ExpansionTile(
              leading: Icon(AppIcons.configuration),
              title: const Text('Configuration'),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 12),
              children: const [_ThemeModeTile()],
            ),
            const Spacer(),
            const Divider(height: 1),
            ListTile(
              leading: Icon(AppIcons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                context.read<AuthCubit>().logout();
                context.go('/sign_in');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeTile extends StatelessWidget {
  const _ThemeModeTile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;

        return SwitchListTile.adaptive(
          value: isDarkMode,
          secondary: Icon(isDarkMode ? AppIcons.darkMode : AppIcons.lightMode),
          title: const Text('Dark mode'),
          subtitle: const Text('Toggle between light and dark theme'),
          onChanged: context.read<ThemeModeCubit>().setDarkMode,
        );
      },
    );
  }
}
