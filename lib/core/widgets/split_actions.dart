// lib/shared/ui/split_actions.dart
import 'package:flutter/material.dart';

class SplitActions extends StatelessWidget {
  const SplitActions({
    super.key,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.onPrimary,
    required this.onSecondary,
  });

  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback onPrimary;
  final VoidCallback onSecondary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
          onPressed: onPrimary,
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          child: Text(primaryLabel),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: onSecondary,
          style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          child: Text(secondaryLabel),
        ),
      ],
    );
  }
}
