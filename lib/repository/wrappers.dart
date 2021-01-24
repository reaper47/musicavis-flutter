import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/utils/constants.dart';
import 'package:musicavis/utils/practice/index.dart';

class SettingsBox {
  Box box;

  SettingsBox() {
    box = Hive.box(SETTINGS_BOX);
  }

  int get minutesMax => box.get(SETTINGS_MINUTES_MAX_KEY);

  set minutesMax(int num) => box.put(SETTINGS_MINUTES_MAX_KEY, num);

  Values get bpmRange =>
      Values(box.get(SETTINGS_BPM_MIN_KEY), -1, box.get(SETTINGS_BPM_MAX_KEY));
}
