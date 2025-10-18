// lib/shared/models/nav_models.dart
enum Mega { grow, help, community }

enum ActionType { find, add }

extension MegaX on Mega {
  String get path => name;
  String get label => switch (this) {
    Mega.grow => 'Grow',
    Mega.help => 'Help',
    Mega.community => 'Community',
  };
}

enum Nested {
  apps(Mega.grow, 'Apps'),
  learn(Mega.grow, 'Learn'),
  get_help(Mega.help, 'Get help'),
  mentor(Mega.help, 'Mentor'),
  church(Mega.community, 'Church'),
  volunteer(Mega.community, 'Volunteer');

  final Mega mega;
  final String label;
  const Nested(this.mega, this.label);

  String get path => name;
  String actionLabel(ActionType a) => switch ((this, a)) {
    (Nested.apps, ActionType.find) => 'Find apps',
    (Nested.apps, ActionType.add) => 'Add app',
    (Nested.learn, ActionType.find) => 'Find learning material',
    (Nested.learn, ActionType.add) => 'Add learning material',
    (Nested.get_help, ActionType.find) => 'Find / get help',
    (Nested.get_help, ActionType.add) => 'Add help centre',
    (Nested.mentor, ActionType.find) => 'Find mentors',
    (Nested.mentor, ActionType.add) => 'Become a mentor',
    (Nested.church, ActionType.find) => 'Find churches',
    (Nested.church, ActionType.add) => 'Add your church',
    (Nested.volunteer, ActionType.find) => 'Volunteer',
    (Nested.volunteer, ActionType.add) => 'Create volunteer event',
  };
}
