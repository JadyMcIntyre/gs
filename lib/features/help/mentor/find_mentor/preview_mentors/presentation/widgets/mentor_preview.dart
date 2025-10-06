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

    final nameStyle = tt.headlineSmall?.copyWith(color: cs.secondary, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis);
    final expertiseStyle = tt.titleMedium?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w600);
    final descStyle = tt.titleMedium?.copyWith(color: cs.onSurface);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Card background
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Card(
              margin: EdgeInsets.zero,
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: nameStyle),
                              const SizedBox(height: 4),
                              Text(expertise, style: expertiseStyle),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(description, style: descStyle),
                  ],
                ),
              ),
            ),
          ),

          // Stacked avatar (slightly overlapping card)
          Positioned(
            top: 0,
            left: 10,
            child: CircleAvatar(
              radius: 52,
              backgroundColor: Colors.white,
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
