import 'package:flutter/material.dart';
import 'package:godsufficient/theme/app_icons.dart';

class HelpCenterPreview extends StatelessWidget {
  const HelpCenterPreview({
    super.key,
    required this.name,
    this.description,
    this.address,
    this.phone,
    this.tags = const [],
    this.imageUrl,
    this.onTap,
  });

  final String name;
  final String? description;
  final String? address;
  final String? phone;
  final List<String> tags;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final titleStyle = tt.titleLarge?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
      overflow: TextOverflow.ellipsis,
    );
    final subStyle = tt.bodySmall?.copyWith(color: cs.onSurfaceVariant);
    final descStyle = tt.bodyMedium?.copyWith(color: cs.onSurface);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avatar(imageUrl: imageUrl),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: titleStyle, maxLines: 1),
                    if ((address ?? '').trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(address!.trim(), style: subStyle),
                    ],
                    if ((phone ?? '').trim().isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(phone!.trim(), style: subStyle),
                    ],
                    if (tags.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: tags
                            .map(
                              (t) => DecoratedBox(
                                decoration: BoxDecoration(
                                  color: cs.surfaceVariant,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: cs.outlineVariant),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    t,
                                    style: tt.labelMedium?.copyWith(
                                      color: cs.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                    if ((description ?? '').trim().isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        description!.trim(),
                        style: descStyle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: 28,
      backgroundColor: cs.surfaceVariant,
      backgroundImage: (imageUrl ?? '').trim().isNotEmpty
          ? NetworkImage(imageUrl!.trim())
          : null,
      child: (imageUrl ?? '').trim().isNotEmpty
          ? null
          : Icon(AppIcons.place, color: cs.onSurfaceVariant),
    );
  }
}
