import 'package:flutter/material.dart';

class MentorPreview extends StatelessWidget {
  final String name;
  final String expertise;
  final List<String> tags;
  final String description;
  final String? imageLink;
  final void Function()? onTap;

  const MentorPreview({
    super.key,
    required this.name,
    required this.expertise,
    required this.tags,
    required this.description,
    required this.onTap,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final nameStyle = tt.headlineSmall?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    );
    final expertiseStyle = tt.bodySmall?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w600);
    final descStyle = tt.titleMedium?.copyWith(color: cs.onSurface, overflow: TextOverflow.ellipsis);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Card background
          Card(
            margin: const EdgeInsets.only(top: 30),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 110), // space for avatar
                      Text(name, style: nameStyle),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 100),
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: tags
                          .map(
                            (t) => Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: cs.secondary, width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: cs.surface,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(t, style: expertiseStyle),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(description, style: descStyle, maxLines: 3),
                ],
              ),
            ),
          ),

          // Stacked avatar (slightly overlapping card)
          Positioned(
            top: 0,
            left: 10,
            child: CircleAvatar(
              radius: 52,
              backgroundColor: cs.onSurfaceVariant,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: imageLink != null ? NetworkImage(imageLink!) : null,
                child: imageLink == null ? const Icon(Icons.person, size: 35, color: Colors.grey) : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
