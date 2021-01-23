import 'package:hive/hive.dart';

import 'package:musicavis/providers/settings.dart';
import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/repository/models/practice.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';

class CrudOperations {
  final Function add;
  final Function delete;
  final Function update;

  CrudOperations({
    this.add,
    this.delete,
    this.update,
  });
}

class DataHolder {
  List<String> goals;
  Exercises exercises;
  List<String> positives;
  List<String> improvements;

  DataHolder.init({Exercises exercises}) {
    goals = [''];
    this.exercises = exercises;
    positives = [''];
    improvements = [''];
  }

  addEntry(TabType type) {
    switch (type) {
      case TabType.goal:
        goals.add('');
        break;
      case TabType.exercise:
        exercises.add();
        break;
      case TabType.positive:
        positives.add('');
        break;
      case TabType.improvement:
        improvements.add('');
        break;
      default:
    }
  }

  deleteItem(TabType type, int index) {
    switch (type) {
      case TabType.goal:
        goals.removeAt(index);
        break;
      case TabType.exercise:
        exercises.delete(index);
        break;
      case TabType.positive:
        positives.removeAt(index);
        break;
      case TabType.improvement:
        improvements.removeAt(index);
        break;
      default:
    }
  }

  refresh(int index, Exercise exercise) {
    exercise.bpmStart = exercises.bpmStartRanges[index].current;
    exercise.bpmEnd = exercises.bpmEndRanges[index].current;
    exercise.minutes = exercises.minuteRanges[index].current;
  }
}

class Exercises {
  final SettingsState settings;

  List<ExerciseDao> exercises;
  List<Values> bpmStartRanges;
  List<Values> bpmEndRanges;
  List<Values> minuteRanges;

  Values initValues;
  int minutesMax;
  List<bool> isEnabled;

  Exercises.create(List<Exercise> exercises, this.settings) {
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

class ExerciseDao {
  String name;
  int bpmStart;
  int bpmEnd;
  int minutes;

  ExerciseDao(this.name, this.bpmStart, this.bpmEnd, this.minutes);

  ExerciseDao.from(Exercise exercise) {
    name = exercise.name;
    bpmStart = exercise.bpmStart;
    bpmEnd = exercise.bpmEnd;
    minutes = exercise.minutes;
  }

  Exercise toExercise(ExerciseDao dao) =>
      Exercise(dao.name, dao.bpmStart, dao.bpmEnd, dao.minutes);
}

class Values {
  int min;
  int current;
  int max;

  Values(this.min, this.current, this.max);

  Values.from(Values values) {
    min = values.min;
    current = values.current;
    max = values.max;
  }

  set currentValue(int value) => current = value;
}

class FilterPractice {
  final Practice practice;

  List<String> goalsOriginal;
  List<Exercise> exercisesOriginal;
  List<String> positivesOriginal;
  List<String> improvementsOriginal;

  FilterPractice.filter(this.practice) {
    _store();

    final goals = practice.goals.where((x) => x != '').toList();
    final exercises = practice.exercises.where((x) => x.name != '').toList();
    final positives = practice.positives.where((x) => x != '').toList();
    final improvements = practice.improvements.where((x) => x != '').toList();

    practice.goals = goals;
    practice.exercises =
        HiveList(Hive.box<Exercise>(EXERCISES_BOX), objects: exercises);
    practice.positives = positives;
    practice.improvements = improvements;
  }

  _store() {
    goalsOriginal = List.from(practice.goals);
    exercisesOriginal = [for (var x in practice.exercises) x];
    positivesOriginal = List.from(practice.positives);
    improvementsOriginal = List.from(practice.improvements);
  }

  restore() {
    practice.goals = goalsOriginal;
    practice.exercises =
        HiveList(Hive.box<Exercise>(EXERCISES_BOX), objects: exercisesOriginal);
    practice.positives = positivesOriginal;
    practice.improvements = improvementsOriginal;
  }
}
