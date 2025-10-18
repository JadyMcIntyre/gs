import 'package:equatable/equatable.dart';

class MentorApplication extends Equatable {
  const MentorApplication({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.expertise,
    required this.description,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String expertise;
  final String description;

  @override
  List<Object?> get props => [firstName, lastName, email, phone, expertise, description];
}
