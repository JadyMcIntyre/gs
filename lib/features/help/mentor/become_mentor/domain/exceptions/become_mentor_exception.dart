class BecomeMentorException implements Exception {
  const BecomeMentorException(this.message);

  final String message;

  @override
  String toString() => message;
}
