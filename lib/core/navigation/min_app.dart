// lib/shared/widgets/min_app_scaffold.dart
import 'package:flutter/material.dart';
import 'package:godsufficient/core/widgets/app_menu_drawer.dart';

class MinAppScaffold extends StatelessWidget {
  const MinAppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.showMenu = true,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final bool showMenu;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    final hasMenu = showMenu && !canPop;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        automaticallyImplyLeading: canPop,
        leading: hasMenu
            ? Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                  tooltip: 'Menu',
                ),
              )
            : null,
        actions: actions,
      ),
      drawer: hasMenu ? const AppMenuDrawer() : null,
      drawerEnableOpenDragGesture: hasMenu,
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(16), child: body),
      ),
    );
  }
}
