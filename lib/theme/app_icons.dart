import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract final class AppIcons {
  static bool get _useCupertino =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  static IconData get grow =>
      _useCupertino ? CupertinoIcons.chart_bar_alt_fill : Icons.trending_up;
  static IconData get help =>
      _useCupertino ? CupertinoIcons.heart_fill : Icons.volunteer_activism;
  static IconData get community =>
      _useCupertino ? CupertinoIcons.person_3_fill : Icons.groups;

  static IconData get apps =>
      _useCupertino ? CupertinoIcons.square_grid_2x2_fill : Icons.apps;
  static IconData get learn =>
      _useCupertino ? CupertinoIcons.book_fill : Icons.menu_book;
  static IconData get getHelp =>
      _useCupertino ? CupertinoIcons.question_circle_fill : Icons.support_agent;
  static IconData get mentor =>
      _useCupertino ? CupertinoIcons.person_2_fill : Icons.school;
  static IconData get church =>
      _useCupertino ? CupertinoIcons.building_2_fill : Icons.church;
  static IconData get volunteer =>
      _useCupertino ? CupertinoIcons.hand_raised_fill : Icons.handshake;
  static IconData get configuration =>
      _useCupertino ? CupertinoIcons.gear_alt_fill : Icons.settings;
  static IconData get logout =>
      _useCupertino ? CupertinoIcons.escape : Icons.logout;
  static IconData get lightMode =>
      _useCupertino ? CupertinoIcons.sun_max_fill : Icons.light_mode;
  static IconData get darkMode =>
      _useCupertino ? CupertinoIcons.moon_fill : Icons.dark_mode;

  static IconData get forward =>
      _useCupertino ? CupertinoIcons.chevron_right : Icons.chevron_right;
  // Flutter does not provide a Cupertino Apple brand icon, so this stays shared.
  static IconData get apple => Icons.apple;
  static IconData get addMentorAvatar => _useCupertino
      ? CupertinoIcons.person_crop_circle_badge_plus
      : Icons.person_add_alt_1;
  static IconData get attachFile =>
      _useCupertino ? CupertinoIcons.paperclip : Icons.attach_file;
  static IconData get imageFile =>
      _useCupertino ? CupertinoIcons.photo : Icons.image_outlined;
  static IconData get documentFile =>
      _useCupertino ? CupertinoIcons.doc : Icons.insert_drive_file_outlined;
  static IconData get close =>
      _useCupertino ? CupertinoIcons.xmark : Icons.close;
  static IconData get place =>
      _useCupertino ? CupertinoIcons.location : Icons.place_outlined;
  static IconData get person =>
      _useCupertino ? CupertinoIcons.person_fill : Icons.person;

  static IconData helpCategory(String? key) {
    switch (key?.toLowerCase().trim()) {
      case 'rehab':
      case 'rehabs':
      case 'recovery':
        return _useCupertino
            ? CupertinoIcons.bandage_fill
            : Icons.local_hospital_outlined;
      case 'counseling':
      case 'counselling':
      case 'therapy':
        return _useCupertino
            ? CupertinoIcons.chat_bubble_2_fill
            : Icons.psychology_alt_outlined;
      case 'shelter':
      case 'housing':
        return _useCupertino
            ? CupertinoIcons.house_fill
            : Icons.home_work_outlined;
      case 'food':
      case 'pantry':
        return _useCupertino
            ? CupertinoIcons.bag_fill
            : Icons.restaurant_outlined;
      case 'hotline':
      case 'crisis':
        return _useCupertino
            ? CupertinoIcons.phone_fill
            : Icons.phone_in_talk_outlined;
      default:
        return _useCupertino
            ? CupertinoIcons.question_circle_fill
            : Icons.support_agent_outlined;
    }
  }
}
