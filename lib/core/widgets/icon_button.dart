import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, this.onPressed, required this.iconData});
  final VoidCallback? onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        side: BorderSide(color: Theme.of(context).colorScheme.secondary),
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        minimumSize: const Size(50, 50),
        padding: EdgeInsets.zero,
      ),
      child: Icon(iconData, size: 25),
    );
  }
}
