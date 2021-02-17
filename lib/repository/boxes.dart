import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:musicavis/repository/models/music_goal.dart';
import 'package:musicavis/utils/constants.dart';
import 'package:musicavis/utils/files.dart';
import 'package:musicavis/utils/themes.dart';

import 'models/exercise.dart';
import 'models/practice.dart';

const MUSIC_GOALS_BOX = 'music_goals';
const PRACTICES_BOX = 'practices';
const GOALS_BOX = 'goals';
const EXERCISES_BOX = 'exercises';
const EXERCISE_NAMES_BOX = 'exercise_names';
const POSITIVES_BOX = 'positives';
const IMPROVEMENTS_BOX = 'improvements';
const SETTINGS_BOX = 'settings';
const INSTRUMENTS_BOX = 'instruments';

final boxes = [
  MUSIC_GOALS_BOX,
  PRACTICES_BOX,
  GOALS_BOX,
  EXERCISES_BOX,
  EXERCISE_NAMES_BOX,
  POSITIVES_BOX,
  IMPROVEMENTS_BOX,
  SETTINGS_BOX,
  INSTRUMENTS_BOX,
];

void registerAdapters() {
  Hive.registerAdapter(PracticeAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(MusicGoalAdapter());
}

Future openBoxes() async {
  await Hive.openBox(MUSIC_GOALS_BOX);
  await Hive.openBox<Practice>(PRACTICES_BOX);
  await Hive.openBox<String>(GOALS_BOX);
  await Hive.openBox<Exercise>(EXERCISES_BOX);
  await Hive.openBox<String>(EXERCISE_NAMES_BOX);
  await Hive.openBox<String>(POSITIVES_BOX);
  await Hive.openBox<String>(IMPROVEMENTS_BOX);

  await Hive.openBox<dynamic>(SETTINGS_BOX);
  _initSettings();

  await Hive.openBox<String>(INSTRUMENTS_BOX);
  _initInstruments();
}

void _initSettings() {
  final box = Hive.box(SETTINGS_BOX);
  if (box.isEmpty) {
    box.put(SETTINGS_THEME_KEY, BLACK_THEME_PREF);
    box.put(SETTINGS_NOTIFICATIONS_KEY, false);
    box.put(SETTINGS_BPM_MIN_KEY, 30);
    box.put(SETTINGS_BPM_MAX_KEY, 300);
    box.put(SETTINGS_MINUTES_MAX_KEY, 5);
    box.put(SETTINGS_INSTRUMENTS_SELECTED_KEY, []);
  }
}

void _initInstruments() async {
  final box = Hive.box<String>(INSTRUMENTS_BOX);
  if (box.isEmpty) {
    final asset = await loadAsset(FILE_INSTRUMENTS);
    List<String> instruments = LineSplitter().convert(asset);
    box.addAll(instruments);
  }
}
