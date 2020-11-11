import 'package:hive/hive.dart';

import 'models/exercise.dart';
import 'models/practice.dart';

const PRACTICES_BOX = 'practices';
const GOALS_BOX = 'goals';
const EXERCISES_BOX = 'exercises';
const EXERCISE_NAMES_BOX = 'exercise_names';
const POSITIVES_BOX = 'positives';
const IMPROVEMENTS_BOX = 'improvements';

void registerAdapters() {
  Hive.registerAdapter(PracticeAdapter());
  Hive.registerAdapter(ExerciseAdapter());
}

Future<void> openBoxes() async {
  await Hive.openBox<Practice>(PRACTICES_BOX);
  await Hive.openBox<String>(GOALS_BOX);
  await Hive.openBox<Exercise>(EXERCISES_BOX);
  await Hive.openBox<String>(EXERCISE_NAMES_BOX);
  await Hive.openBox<String>(POSITIVES_BOX);
  await Hive.openBox<String>(IMPROVEMENTS_BOX);
}
