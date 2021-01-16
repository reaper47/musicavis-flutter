import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/utils/constants.dart';

final settingsStateNotifier = StateNotifierProvider((_) => SettingsState());

class SettingsState extends StateNotifier<Box<dynamic>> {
  SettingsState() : super(Hive.box(SETTINGS_BOX));

  String getMinutesMax() => state.get(SETTINGS_MINUTES_MAX_KEY).toString();

  void updateMinutesMax(int num) => state.put(SETTINGS_MINUTES_MAX_KEY, num);
}
