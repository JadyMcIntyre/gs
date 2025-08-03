import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/preview_mentors/domain/entities/mentor.dart';

part 'find_mentor_state.dart';

class FindMentorCubit extends Cubit<FindMentorState> {
  FindMentorCubit() : super(FindMentorInitial());
  /// TODO: for preview mentor widget, to get consistency I think that we should take the full description and cut them and add ellipsis
  void getMentors() {
    emit(FindMentorLoaded(placeHolderMentors()));
  }

  List<Mentor> placeHolderMentors() {
    return <Mentor>[
      Mentor(
        name: 'John Doe',
        expertise: 'Addiction Recovery Mentor',
        description:
            'John fought a decade-long battle with alcohol dependency before finding lasting freedom through faith. He now walks alongside others, sharing biblical tools and personal insights to overcome addiction.',
        imageLink: 'https://randomuser.me/api/portraits/men/1.jpg',
      ),
      Mentor(
        name: 'Bruce Lee',
        expertise: 'Abuse & Trauma Recovery Mentor',
        description:
            'Bruce survived childhood abuse and post-traumatic stress by leaning into God’s healing promises. He provides compassionate support grounded in Scripture for those rebuilding after trauma.',
        imageLink: 'https://randomuser.me/api/portraits/men/2.jpg',
      ),
      Mentor(
        name: 'Alice Smith',
        expertise: 'Grief & Loss Mentor',
        description:
            'After losing her husband to cancer, Alice navigated deep sorrow through prayer and community. She guides others through grief with empathy, hope-filled devotions, and practical next steps.',
        imageLink: 'https://randomuser.me/api/portraits/women/3.jpg',
      ),
      Mentor(
        name: 'Carlos Sanchez',
        expertise: 'Financial Stewardship Mentor',
        description:
            'Carlos overcame crippling debt by applying biblical principles of stewardship and generosity. He now teaches budgeting, debt freedom, and joyful giving from a Christian perspective.',
        imageLink: 'https://randomuser.me/api/portraits/men/4.jpg',
      ),
      Mentor(
        name: 'Priya Patel',
        expertise: 'Eating Disorder Recovery Mentor',
        description:
            'Priya battled an eating disorder in college and found her worth in Christ’s unconditional love. She supports others in finding healthy rhythms and identity in God rather than body image.',
        imageLink: 'https://randomuser.me/api/portraits/women/5.jpg',
      ),
      Mentor(
        name: 'Tom Brown',
        expertise: 'Relationship & Family Conflict Mentor',
        description:
            'Tom rebuilt his marriage after betrayal, relying on forgiveness and God’s grace. He coaches couples and families toward healthy communication and restoration rooted in biblical values.',
        imageLink: 'https://randomuser.me/api/portraits/men/6.jpg',
      ),
      Mentor(
        name: 'Sophia Williams',
        expertise: 'Self-Worth & Identity Mentor',
        description:
            'Sophia struggled with low self-esteem and people-pleasing but discovered her true identity in Christ. She helps others replace toxic mindsets with God’s truth about their value.',
        imageLink: 'https://randomuser.me/api/portraits/women/7.jpg',
      ),
      Mentor(
        name: 'David Chen',
        expertise: 'Anxiety & Depression Mentor',
        description:
            'David faced crippling anxiety and depression but found peace through Scripture meditation and community support. He mentors others in cultivating faith-filled resilience.',
        imageLink: 'https://randomuser.me/api/portraits/men/8.jpg',
      ),
      Mentor(
        name: 'Emma Johnson',
        expertise: 'Spiritual Burnout & Purpose Mentor',
        description:
            'After years of ministry fatigue, Emma rediscovered joy in her calling through Sabbath practices and spiritual renewal. She now guides believers toward sustainable service and God-given purpose.',
        imageLink: 'https://randomuser.me/api/portraits/women/9.jpg',
      ),
      Mentor(
        name: 'Michael Davis',
        expertise: 'Life Transitions & Career Mentor',
        description:
            'Michael navigated a career pivot from corporate to nonprofit ministry, leaning on prayer and wise counsel. He coaches others through major life changes with practical steps and spiritual encouragement.',
        imageLink: 'https://randomuser.me/api/portraits/men/10.jpg',
      ),
    ];
  }
}
