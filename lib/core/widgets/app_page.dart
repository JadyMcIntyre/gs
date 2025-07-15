import 'package:flutter/material.dart';
import 'package:validateit/validateit.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    this.title,
    this.isScrollable = false,
    this.customCrossAxis,
    this.customMainAxis,
    this.padding,
    required this.widgets,
    this.appBar,
    this.navBar,
  });

  final String? title;
  final bool isScrollable;
  final CrossAxisAlignment? customCrossAxis;
  final MainAxisAlignment? customMainAxis;
  final EdgeInsetsGeometry? padding;
  final List<Widget> widgets;
  final AppBar? appBar;
  final Widget? navBar;

  @override
  Widget build(BuildContext context) {
    final Widget contentColumn = Column(
      mainAxisAlignment: customMainAxis ?? MainAxisAlignment.center,
      crossAxisAlignment: customCrossAxis ?? CrossAxisAlignment.center,
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

    return Scaffold(appBar: isNullOrEmpty(title) ? null : AppBar(title: Text(title!)), body: bodyContent, bottomNavigationBar: navBar);
  }
}
