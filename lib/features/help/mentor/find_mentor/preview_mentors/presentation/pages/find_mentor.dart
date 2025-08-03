import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/preview_mentors/presentation/cubit/find_mentor_cubit.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/preview_mentors/presentation/widgets/mentor_preview.dart';

class FindMentor extends StatelessWidget {
  const FindMentor({super.key});

  @override
  Widget build(BuildContext context) {
    /// TODO: create a mentor profile widget
    /// TODO: create firestore table to store mentor's data
    /// TODO: find where to store images
    /// TODO: find how to fetch and pass and interact with data throughout preview and profile mentor
    return BlocProvider(
      create: (_) => FindMentorCubit()..getMentors(),
      child: BlocBuilder<FindMentorCubit, FindMentorState>(
        builder: (context, state) {
          if (state is FindMentorLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FindMentorError) {
            return Center(child: Text(state.message));
          }

          if (state is FindMentorLoaded) {
            return AppPage(
              isScrollable: true,
              mainAxisAlignment: MainAxisAlignment.start,
              padding: const EdgeInsets.all(24),
              title: 'Find Mentor',
              // map each Mentor to a MentorPreview, then toList()
              widgets: state.mentors
                  .map(
                    (mentor) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: MentorPreview(
                        onTap: () {
                          // you can pass the mentor along if you like:
                          context.push('/mentor_profile', extra: mentor);
                        },
                        name: mentor.name,
                        expertise: mentor.expertise,
                        description: mentor.description,
                        imageLink: mentor.imageLink,
                      ),
                    ),
                  )
                  .toList(),
            );
          }

          // fallback if state is something else
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
