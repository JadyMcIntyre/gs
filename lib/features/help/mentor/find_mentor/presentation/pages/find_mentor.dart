import 'package:flutter/material.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/presentation/widgets/mentor_preview.dart';

class FindMentor extends StatelessWidget {
  const FindMentor({super.key});

  @override
  Widget build(BuildContext context) {
    /// TODO: create a mentor listing widget
    /// TODO: create a mentor profile widget
    /// TODO: find best way to build "catalog/list" of mentors
    return AppPage(
      mainAxisAlignment: MainAxisAlignment.start,
      padding: const EdgeInsets.all(24),
      title: 'Find Mentor',
      widgets: [
        MentorPreview(
          name: 'John Doe',
          expertise: 'Health Coach',
          description:
              'John is your go to man for anything and everything. He is a seasoned expert in all things health and wellness.',
        ),
      ],
    );
  }
}
