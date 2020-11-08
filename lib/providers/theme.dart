import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeStateNotifier = StateNotifierProvider((ref) => ThemeState());

class ThemeState extends StateNotifier<bool> {
  ThemeState() : super(false);

  void setLightTheme() => state = false;
  void setDarkTheme() => state = true;
}
