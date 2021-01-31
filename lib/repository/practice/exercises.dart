import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/repository/practice/index.dart';
import 'package:musicavis/repository/practice/values.dart';
import 'package:musicavis/repository/wrappers.dart';

class Exercises {
  List<ExerciseDao> exercises;
  List<Values> bpmStartRanges;
  List<Values> bpmEndRanges;
  List<Values> minuteRanges;

  Values initValues;
  int minutesMax;
  List<bool> isEnabled;

  Exercises.create(List<Exercise> exercises, isFromCalendar) {
    final settings = SettingsBox();
    this.exercises = exercises.map((e) => ExerciseDao.from(e)).toList();

    final bpms = settings.bpmRange;
    final midBpm = (bpms.max + bpms.min) ~/ 2;
    initValues = Values(bpms.min, midBpm, bpms.max);
    minutesMax = settings.minutesMax;

    if (isFromCalendar) {
      bpmStartRanges = exercises
          .map((e) => Values.from(initValues..current = e.bpmStart))
          .toList();
      bpmEndRanges = exercises
          .map((e) => Values.from(initValues..current = e.bpmEnd))
          .toList();
      minuteRanges =
          exercises.map((e) => Values(1, e.minutes, minutesMax)).toList();
    } else {
      bpmStartRanges = exercises.map((e) => Values.from(initValues)).toList();
      bpmEndRanges = exercises.map((e) => Values.from(initValues)).toList();
      minuteRanges = exercises
          .map((e) => Values(1, (minutesMax + 1) ~/ 2, minutesMax))
          .toList();
    }

    isEnabled = exercises.map((e) => true).toList();
  }

  int get length => exercises.length;

  void add() {
    final bpm = bpmStartRanges[0];
    exercises.add(ExerciseDao('', bpm.min, bpm.max, minuteRanges.first.max));
    bpmStartRanges.add(Values.from(initValues));
    bpmEndRanges.add(Values.from(initValues));
    minuteRanges.add(Values(1, (minutesMax + 1) ~/ 2, minutesMax));
    isEnabled.add(true);
  }

  void refresh() {
    for (var i = 0; i < exercises.length; i++) {
      exercises[i].bpmStart = bpmStartRanges[i].current;
      exercises[i].bpmEnd = bpmEndRanges[i].current;
      exercises[i].minutes = minuteRanges[i].current;
    }
  }

  void delete(int index) {
    exercises.removeAt(index);
    bpmStartRanges.removeAt(index);
    bpmEndRanges.removeAt(index);
    minuteRanges.removeAt(index);
    isEnabled.removeAt(index);
  }

  void toggleEnabled(int index) {
    isEnabled[index] = !isEnabled[index];
  }

  bool isElgigibleToAdd() {
    final hasEmptyName = exercises.any((x) => x.name == '');
    final names = [for (var x in exercises) x.name];
    final hasDuplicate = names.toSet().length != names.length;
    return !hasEmptyName && !hasDuplicate;
  }
}
