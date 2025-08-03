import 'package:flutter/material.dart';

class MentorPreview extends StatelessWidget {
  final String name, expertise, description;
  const MentorPreview({super.key, required this.name, required this.expertise, required this.description});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    var secondary = colorScheme.secondary;
    var onSurface = colorScheme.onSurface;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 50, child: Icon(Icons.face, size: 60)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: secondary)),
                      Text(
                        expertise,
                        style: theme.textTheme.titleLarge?.copyWith(color: onSurface, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(description, style: theme.textTheme.titleMedium?.copyWith(color: onSurface)),
          ],
        ),
      ),
    );
  }
}
