import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preferences/preferences.dart';

import 'package:musicavis/utils/constants.dart';

final themeStateNotifier = StateNotifierProvider((ref) => ThemeState());

class ThemeState extends StateNotifier<String> {
  ThemeState() : super(PrefService.getString(THEME_PREF));

  void setTheme(String name) => state = name;
}
