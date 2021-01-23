import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/utils/constants.dart';
import 'package:musicavis/utils/themes.dart';

final themeStateNotifier = StateNotifierProvider((_) => ThemeState());

class ThemeState extends StateNotifier<String> {
  ThemeState() : super(Hive.box(SETTINGS_BOX).get(SETTINGS_THEME_KEY));

  setTheme(String name) => state = name;

  bool isBlackTheme() => state == BLACK_THEME_PREF;

  bool isLightTheme() => state == LIGHT_THEME_PREF;
}
