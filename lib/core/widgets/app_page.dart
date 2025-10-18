import 'package:flutter/material.dart';
import 'package:validateit/validateit.dart';

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
    this.useNavBar = true,
  });

  final String? title;
  final bool isScrollable;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final List<Widget> widgets;
  final AppBar? appBar;
  final Widget? navBar;
  final bool useNavBar;

  @override
  Widget build(BuildContext context) {
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
      appBar: isNullOrEmpty(title) ? null : AppBar(title: Text(title!)),
      body: SafeArea(child: bodyContent),
      bottomNavigationBar: useNavBar
          ? navBar ??
                BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: IconButton(onPressed: () {}, icon: Icon(Icons.trending_up)),
                      label: 'Grow',
                    ),
                    BottomNavigationBarItem(
                      icon: IconButton(onPressed: () {}, icon: Icon(Icons.help)),
                      label: 'Help',
                    ),
                    BottomNavigationBarItem(
                      icon: IconButton(onPressed: () {}, icon: Icon(Icons.church)),
                      label: 'Community',
                    ),
                  ],
                )
          : null,
    );
  }
}
