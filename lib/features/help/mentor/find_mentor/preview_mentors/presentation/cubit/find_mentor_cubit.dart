import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godsufficient/features/help/mentor/find_mentor/preview_mentors/domain/entities/mentor.dart';

part 'find_mentor_state.dart';

class FindMentorCubit extends Cubit<FindMentorState> {
  FindMentorCubit(this._firestore) : super(FindMentorInitial());

  final FirebaseFirestore _firestore;

  /// TODO: for preview mentor widget, to get consistency I think that we should take the full description and cut them and add ellipsis
  Future<void> getMentors() async {
    emit(FindMentorLoading());

    try {
      final snapshot = await _firestore.collection('mentors').get();

      final mentors = snapshot.docs
          .map(_mapDocToMentor)
          .whereType<Mentor>()
          .toList(growable: false)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      // Assign deterministic placeholder images based on list order.
      for (var i = 0; i < mentors.length; i++) {
        mentors[i].imageLink = 'https://randomuser.me/api/portraits/men/${i + 1}.jpg';
      }

      emit(FindMentorLoaded(mentors));
    } catch (_) {
      emit(const FindMentorError('Unable to load mentors right now.'));
    }
  }

  Mentor? _mapDocToMentor(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    final firstName =
        (data['first name'] ?? data['firstName'] ?? data['first_name'] ?? '').toString().trim();
    final lastName =
        (data['last name'] ?? data['lastName'] ?? data['last_name'] ?? '').toString().trim();
    final name = [firstName, lastName].where((part) => part.isNotEmpty).join(' ').trim();
    final expertise = (data['expertise'] ?? '').toString().trim();
    final description = (data['description'] ?? '').toString().trim();

    final rawTags = data['tags'];
    final tags = rawTags is Iterable
        ? rawTags.map((tag) => tag.toString().trim()).where((tag) => tag.isNotEmpty).toList()
        : <String>[];

    if (name.isEmpty || expertise.isEmpty || description.isEmpty) {
      return null;
    }

    return Mentor(
      name: name,
      expertise: expertise,
      description: description,
      imageLink: '',
      tags: tags,
    );
  }
}
