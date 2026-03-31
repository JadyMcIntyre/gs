// lib/shared/widgets/min_app_scaffold.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godsufficient/core/navigation/home_menu_cubit.dart';

class MinAppScaffold extends StatelessWidget {
  const MinAppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.drawer,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      onDrawerChanged: drawer == null
          ? null
          : (isOpen) => context.read<HomeMenuCubit>().setOpen(isOpen),
      appBar: AppBar(title: Text(title), centerTitle: true, actions: actions),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(16), child: body),
      ),
    );
  }
}
