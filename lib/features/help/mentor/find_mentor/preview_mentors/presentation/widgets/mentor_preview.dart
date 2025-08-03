import 'package:flutter/material.dart';

class MentorPreview extends StatelessWidget {
  final String name;
  final String expertise;
  final String description;
  final String? imageLink;
  final void Function()? onTap;

  const MentorPreview({
    super.key,
    required this.name,
    required this.expertise,
    required this.description,
    required this.onTap,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    // Pre-compute any TextStyles you reuse
    final nameStyle = tt.headlineSmall?.copyWith(color: cs.secondary, fontWeight: FontWeight.bold);
    final expertiseStyle = tt.titleLarge?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w600);
    final descStyle = tt.titleMedium?.copyWith(color: cs.onSurface);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: imageLink != null ? NetworkImage(imageLink!) : null,
                  child: imageLink == null ? const Icon(Icons.person, size: 30, color: Colors.grey) : null,
                ),

                title: Text(name, style: nameStyle),
                subtitle: Text(expertise, style: expertiseStyle),
              ),
              const SizedBox(height: 12),
              Text(description, style: descStyle),
            ],
          ),
        ),
      ),
    );
  }
}
