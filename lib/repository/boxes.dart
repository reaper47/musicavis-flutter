import 'package:hive/hive.dart';

import 'package:musicavis/utils/constants.dart';
import 'package:musicavis/utils/themes.dart';
import 'models/exercise.dart';
import 'models/practice.dart';

const PRACTICES_BOX = 'practices';
const GOALS_BOX = 'goals';
const EXERCISES_BOX = 'exercises';
const EXERCISE_NAMES_BOX = 'exercise_names';
const POSITIVES_BOX = 'positives';
const IMPROVEMENTS_BOX = 'improvements';
const SETTINGS_BOX = 'settingss';

final boxes = [
  PRACTICES_BOX,
  GOALS_BOX,
  EXERCISES_BOX,
  EXERCISE_NAMES_BOX,
  POSITIVES_BOX,
  IMPROVEMENTS_BOX,
  SETTINGS_BOX,
];

void registerAdapters() {
  Hive.registerAdapter(PracticeAdapter());
  Hive.registerAdapter(ExerciseAdapter());
}

Future openBoxes() async {
  await Hive.openBox<Practice>(PRACTICES_BOX);
  await Hive.openBox<String>(GOALS_BOX);
  await Hive.openBox<Exercise>(EXERCISES_BOX);
  await Hive.openBox<String>(EXERCISE_NAMES_BOX);
  await Hive.openBox<String>(POSITIVES_BOX);
  await Hive.openBox<String>(IMPROVEMENTS_BOX);

  await Hive.openBox<dynamic>(SETTINGS_BOX);
  _initSettings();
}

void _initSettings() {
  final box = Hive.box(SETTINGS_BOX);
  if (box.get(SETTINGS_INITIALIZED) == null) {
    box.put(SETTINGS_INITIALIZED, true);
    box.put(SETTINGS_THEME_KEY, BLACK_THEME_PREF);
    box.put(SETTINGS_NOTIFICATIONS_KEY, false);
    box.put(SETTINGS_BPM_MIN_KEY, 30);
    box.put(SETTINGS_BPM_MAX_KEY, 300);
    box.put(SETTINGS_MINUTES_MAX_KEY, 5);
  }
}
