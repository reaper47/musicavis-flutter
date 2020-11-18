import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/utils/constants.dart';

final themeStateNotifier = StateNotifierProvider((ref) => ThemeState());

class ThemeState extends StateNotifier<String> {
  ThemeState() : super(Hive.box(SETTINGS_BOX).get(SETTINGS_THEME_KEY));

  void setTheme(String name) => state = name;
}
