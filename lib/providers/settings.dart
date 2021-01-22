import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/utils/constants.dart';
import 'package:musicavis/utils/practice.dart';

final settingsStateNotifier = StateNotifierProvider((_) => SettingsState());

class SettingsState extends StateNotifier<Box<dynamic>> {
  SettingsState() : super(Hive.box(SETTINGS_BOX));

  int get minutesMax => state.get(SETTINGS_MINUTES_MAX_KEY);

  set minutesMax(int num) => state.put(SETTINGS_MINUTES_MAX_KEY, num);

  Values get bpmRange => Values(
      state.get(SETTINGS_BPM_MIN_KEY), -1, state.get(SETTINGS_BPM_MAX_KEY));
}
