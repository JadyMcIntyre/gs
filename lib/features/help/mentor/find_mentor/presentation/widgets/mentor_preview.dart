import 'package:flutter/material.dart';

class MentorPreview extends StatelessWidget {
  final String name;
  final String expertise;
  final String description;

  const MentorPreview({super.key, required this.name, required this.expertise, required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    // Pre-compute any TextStyles you reuse
    final nameStyle = tt.headlineSmall?.copyWith(color: cs.secondary);
    final expertiseStyle = tt.titleLarge?.copyWith(color: cs.onSurface, fontWeight: FontWeight.bold);
    final descStyle = tt.titleMedium?.copyWith(color: cs.onSurface);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(radius: 25, child: Icon(Icons.face, size: 30)),
              title: Text(name, style: nameStyle),
              subtitle: Text(expertise, style: expertiseStyle),
            ),
            const SizedBox(height: 12),
            Text(description, style: descStyle),
          ],
        ),
      ),
    );
  }
}
