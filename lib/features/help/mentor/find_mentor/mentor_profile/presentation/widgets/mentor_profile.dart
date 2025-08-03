import 'package:flutter/material.dart';

class MentorProfile extends StatelessWidget {
  final String image;
  final String name;
  final String expertise;
  final String description;
  const MentorProfile({
    super.key,
    required this.image,
    required this.name,
    required this.expertise,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 80, backgroundImage: NetworkImage(image)),
        const SizedBox(width: 20),
        Text(
          name,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          expertise,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),

        /// Way of connecting
        /// maybe phone or email or what not
        const SizedBox(height: 20),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ],
    );
  }
}
