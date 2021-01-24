import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/repository/wrappers.dart';
import 'package:musicavis/utils/practice/index.dart';

class Exercises {
  List<ExerciseDao> exercises;
  List<Values> bpmStartRanges;
  List<Values> bpmEndRanges;
  List<Values> minuteRanges;

  Values initValues;
  int minutesMax;
  List<bool> isEnabled;

  Exercises.create(List<Exercise> exercises) {
    final settings = SettingsBox();

    final bpms = settings.bpmRange;
    final midBpm = (bpms.max + bpms.min) ~/ 2;
    initValues = Values(bpms.min, midBpm, bpms.max);
    bpmStartRanges = exercises.map((e) => Values.from(initValues)).toList();
    bpmEndRanges = exercises.map((e) => Values.from(initValues)).toList();
    this.exercises = exercises.map((e) => ExerciseDao.from(e)).toList();

    minutesMax = settings.minutesMax;
    minuteRanges = exercises
        .map((e) => Values(1, (minutesMax + 1) ~/ 2, minutesMax))
        .toList();

    isEnabled = exercises.map((e) => true).toList();
  }

  int get length => exercises.length;

  add() {
    final bpm = bpmStartRanges[0];
    exercises.add(ExerciseDao('', bpm.min, bpm.max, minuteRanges.first.max));
    bpmStartRanges.add(Values.from(initValues));
    bpmEndRanges.add(Values.from(initValues));
    minuteRanges.add(Values(1, (minutesMax + 1) ~/ 2, minutesMax));
    isEnabled.add(true);
  }

  refresh() {
    for (var i = 0; i < exercises.length; i++) {
      exercises[i].bpmStart = bpmStartRanges[i].current;
      exercises[i].bpmEnd = bpmEndRanges[i].current;
      exercises[i].minutes = minuteRanges[i].current;
    }
  }

  delete(int index) {
    exercises.removeAt(index);
    bpmStartRanges.removeAt(index);
    bpmEndRanges.removeAt(index);
    minuteRanges.removeAt(index);
    isEnabled.removeAt(index);
  }

  toggleEnabled(int index) {
    isEnabled[index] = !isEnabled[index];
  }
}
