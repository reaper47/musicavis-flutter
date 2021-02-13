import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/repository/practice/index.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/constants.dart';

part 'practice.g.dart';

@HiveType(typeId: 2)
class Practice extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String instrument;

  @HiveField(2)
  List<String> goals;

  @HiveField(3)
  HiveList<Exercise> exercises;

  @HiveField(4)
  List<String> positives;

  @HiveField(5)
  List<String> improvements;

  @HiveField(6)
  String notes;

  @HiveField(7)
  DateTime datetime;

  Practice({
    this.id,
    this.instrument,
    this.goals,
    this.exercises,
    this.positives,
    this.improvements,
    this.notes,
    this.datetime,
  });

  int get practiceTime => exercises
      .sublist(0, exercises.length - 1)
      .fold(0, (prev, el) => prev + el.minutes);

  Practice.create(String instrument) {
    id = Hive.box<Practice>(PRACTICES_BOX).length;
    this.instrument = instrument;
    goals = [''];
    exercises =
        HiveList(Hive.box<Exercise>(EXERCISES_BOX), objects: [_makeExercise()]);
    positives = [''];
    improvements = [''];
    datetime = DateTime.now();
  }

  Practice.fetch(int id) {
    final practice = Hive.box<Practice>(PRACTICES_BOX).get(id);
    this.id = practice.id;
    instrument = practice.instrument;
    goals = practice.goals;
    exercises = practice.exercises;
    positives = practice.positives;
    improvements = practice.improvements;
    notes = practice.notes;
    datetime = practice.datetime;
  }

  String get title => '$instrument - ${DateFormat('yMMMd').format(datetime)}';

  savePractice(DataHolder dataHolder) {
    final filter = FilterPractice.filter(this);
    Hive.box<Practice>(PRACTICES_BOX).put(id, filter.practice);
    filter.practice.exercises.forEach((x) => x.save());
    filter.restore();
  }

  deletePractice() => Hive.box<Practice>(PRACTICES_BOX).delete(id);

  update(TabType type, int index, String value) {
    switch (type) {
      case TabType.goal:
        goals[index] = value;
        break;
      case TabType.exercise:
        exercises[index].name = value;
        break;
      case TabType.improvement:
        improvements[index] = value;
        break;
      case TabType.positive:
        positives[index] = value;
        break;
      case TabType.notes:
        notes = value;
        break;
      default:
        break;
    }
  }

  updateAll(TabType type, DataHolder data) {
    switch (type) {
      case TabType.goal:
        goals = List.from(data.listData[type]);
        break;
      case TabType.exercise:
        for (var i = 0; i < exercises.length; i++) {
          exercises[i].name = data.exercises.exercises[i].name;
          exercises[i].bpmStart = data.exercises.exercises[i].bpmStart;
          exercises[i].bpmEnd = data.exercises.exercises[i].bpmEnd;
          exercises[i].minutes = data.exercises.exercises[i].minutes;
        }
        break;
      case TabType.improvement:
        improvements = List.from(data.listData[type]);
        break;
      case TabType.positive:
        positives = List.from(data.listData[type]);
        break;
      default:
        break;
    }
  }

  add(String item, TabType type) {
    switch (type) {
      case TabType.goal:
        _addItem(item, goals);
        break;
      case TabType.exercise:
        exercises.add(_makeExercise());
        break;
      case TabType.improvement:
        _addItem(item, improvements);
        break;
      case TabType.positive:
        _addItem(item, positives);
        break;
      default:
        break;
    }
  }

  _addItem(String item, List<String> items) {
    if (!items.contains('')) {
      List<String> original = List.from(items);
      items
        ..clear()
        ..addAll(original.toSet().toList() + ['']);
    }
  }

  Exercise _makeExercise() {
    final settingsBox = Hive.box(SETTINGS_BOX);
    final exercise = Exercise(
      '',
      settingsBox.get(SETTINGS_BPM_MIN_KEY),
      settingsBox.get(SETTINGS_BPM_MAX_KEY),
      settingsBox.get(SETTINGS_MINUTES_MAX_KEY),
    );

    final box = Hive.box<Exercise>(EXERCISES_BOX);
    final exerciseInBox = box.values.where((el) => el == exercise);

    if (exerciseInBox.isEmpty) {
      box.add(exercise);
      exercise.save();
      return exercise;
    }
    return exerciseInBox.first;
  }

  refreshExercises(DataHolder dataHolder) =>
      exercises.asMap().forEach((index, x) => dataHolder.refresh(index, x));

  deleteItem(int index, TabType type) {
    switch (type) {
      case TabType.goal:
        _deleteItem(index, goals);
        break;
      case TabType.exercise:
        _deleteItem(index, exercises);
        break;
      case TabType.improvement:
        _deleteItem(index, improvements);
        break;
      case TabType.positive:
        _deleteItem(index, positives);
        break;
      default:
        break;
    }
  }

  _deleteItem(int index, List<dynamic> items) {
    if (items.length == 1) {
      (items[0] is String) ? items[0] = '' : items[0].name = '';
    } else {
      items.removeAt(index);
    }
  }

  @override
  String toString() =>
      'Practice { id: $id, $instrument, goals: $goals, exercises: $exercises, '
      'positives: $positives, improvements: $improvements, notes: $notes, '
      'datetime: $datetime }';
}
