import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/mentor_profile/presentation/cubit/mentor_profile_cubit.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/mentor_profile/presentation/widgets/mentor_profile.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/preview_mentors/domain/entities/mentor.dart';

class MentorProfilePage extends StatelessWidget {
  final Mentor mentor;
  const MentorProfilePage({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MentorProfileCubit(),
      child: BlocBuilder<MentorProfileCubit, MentorProfileState>(
        builder: (context, state) {
          return AppPage(
            isScrollable: true,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.all(24),

            /// TOFO: only use first name
            title: "${mentor.name.split(' ').first}'s Profile",
            widgets: [
              MentorProfile(
                image: mentor.imageLink,
                name: mentor.name,
                expertise: mentor.expertise,
                description: mentor.description,
              ),
            ],
          );
        },
      ),
    );
  }
}
