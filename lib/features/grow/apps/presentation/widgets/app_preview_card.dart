import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/gs_app.dart';

class AppPreviewCard extends StatelessWidget {
  const AppPreviewCard({
    super.key,
    required this.name,
    this.description,
    this.logoUrl,
    this.tags = const [],
    this.onTap,
  });

  final String name;
  final String? description;
  final String? logoUrl;
  final List<String> tags;
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
              _Avatar(imageUrl: logoUrl),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: titleStyle, maxLines: 1),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  child: Text(t, style: tt.labelMedium?.copyWith(color: cs.onSurfaceVariant)),
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

class AppDetailsSheet extends StatelessWidget {
  const AppDetailsSheet({super.key, required this.app});

  final GsApp app;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final hasPlay = (app.playStoreUrl ?? '').trim().isNotEmpty;
    final hasApple = (app.appStoreUrl ?? '').trim().isNotEmpty;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _Avatar(imageUrl: app.logoUrl),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      app.name,
                      style: tt.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (app.tags.isNotEmpty) ...[
                const SizedBox(height: 14),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: app.tags
                      .map(
                        (t) => DecoratedBox(
                          decoration: BoxDecoration(
                            color: cs.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: cs.outlineVariant),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            child: Text(t, style: tt.labelMedium?.copyWith(color: cs.onSurfaceVariant)),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
              if ((app.description ?? '').trim().isNotEmpty) ...[
                const SizedBox(height: 14),
                Text(app.description!.trim(), style: tt.bodyMedium?.copyWith(color: cs.onSurface)),
              ],
              if (hasPlay || hasApple) ...[
                const SizedBox(height: 18),
                Text('Links', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                if (hasPlay)
                  _LinkTile(
                    label: 'Google Play',
                    icon: Icons.android,
                    url: app.playStoreUrl!.trim(),
                  ),
                if (hasApple)
                  _LinkTile(
                    label: 'App Store',
                    icon: Icons.phone_iphone,
                    url: app.appStoreUrl!.trim(),
                  ),
              ],
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({required this.label, required this.icon, required this.url});

  final String label;
  final IconData icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(url, maxLines: 2, overflow: TextOverflow.ellipsis),
      trailing: IconButton(
        icon: const Icon(Icons.copy),
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: url));
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Copied $label link')),
          );
        },
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
      backgroundImage: (imageUrl ?? '').trim().isNotEmpty ? NetworkImage(imageUrl!.trim()) : null,
      child: (imageUrl ?? '').trim().isNotEmpty ? null : Icon(Icons.apps_outlined, color: cs.onSurfaceVariant),
    );
  }
}

