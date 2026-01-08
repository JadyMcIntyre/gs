import 'package:flutter/material.dart';
import 'package:validateit/validateit.dart';
import 'package:godsufficient/core/widgets/app_menu_drawer.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    this.title,
    this.isScrollable = false,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.padding,
    required this.widgets,
    this.appBar,
    this.navBar,
    this.showMenu = true,
  });

  final String? title;
  final bool isScrollable;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final List<Widget> widgets;
  final AppBar? appBar;
  final Widget? navBar;
  final bool showMenu;

  @override
  Widget build(BuildContext context) {
    final showAppBar = !isNullOrEmpty(title);
    final canPop = Navigator.of(context).canPop();
    final hasMenu = showMenu && showAppBar && !canPop;

    final Widget contentColumn = Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [...widgets],
    );

    final Widget bodyContent = Padding(
      padding: padding ?? EdgeInsets.only(top: 10),
      child: isScrollable
          ? Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(child: contentColumn),
            )
          : contentColumn,
    );

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(title!),
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
            )
          : null,
      drawer: hasMenu ? const AppMenuDrawer() : null,
      drawerEnableOpenDragGesture: hasMenu,
      body: SafeArea(child: bodyContent),
      bottomNavigationBar: navBar,
    );
  }
}
