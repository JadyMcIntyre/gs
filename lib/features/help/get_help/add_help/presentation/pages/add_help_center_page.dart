import 'package:flutter/material.dart';
import 'package:godsufficient/core/widgets/app_page.dart';

class AddHelpCenterPage extends StatelessWidget {
  const AddHelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      isScrollable: true,
      mainAxisAlignment: MainAxisAlignment.start,
      padding: const EdgeInsets.all(24),
      title: 'Add help centre',
      widgets: [
        Text(
          'Coming soon.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Text(
          'For now, please ask an admin to add your organisation in Firebase (collection: help_centers).',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

