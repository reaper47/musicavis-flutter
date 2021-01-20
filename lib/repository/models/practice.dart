import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/constants.dart';

part 'practice.g.dart';

@HiveType(typeId: 2)
class Practice extends HiveObject {
  @HiveField(0)
  String instrument;

  @HiveField(1)
  List<String> goals;

  @HiveField(2)
  HiveList<Exercise> exercises;

  @HiveField(3)
  List<String> positives;

  @HiveField(4)
  List<String> improvements;

  @HiveField(5)
  String notes;

  @HiveField(6)
  DateTime datetime;

  Practice({
    this.instrument,
    this.goals,
    this.exercises,
    this.positives,
    this.improvements,
    this.notes,
    this.datetime,
  });

  Practice.create(String instrument) {
    this.instrument = instrument;
    goals = [''];

    final settingsBox = Hive.box(SETTINGS_BOX);
    exercises = HiveList(Hive.box<Exercise>(EXERCISES_BOX), objects: [
      addExercise(
        '',
        settingsBox.get(SETTINGS_BPM_MIN_KEY),
        settingsBox.get(SETTINGS_BPM_MIN_KEY),
        settingsBox.get(SETTINGS_MINUTES_MAX_KEY),
      )
    ]);

    positives = [''];
    improvements = [''];
    datetime = DateTime.now();
  }

  String get title => '$instrument - ${DateFormat('yMMMd').format(datetime)}';

  void update(TabType type, int index, String value) {
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

  void add(String item, TabType type) {
    switch (type) {
      case TabType.goal:
        _addItem(item, goals);
        break;
      case TabType.exercise:
        print('add exercise');
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

  void _addItem(String item, List<String> items) {
    if (!items.contains('')) {
      List<String> original = List.from(items);
      items
        ..clear()
        ..addAll(original.toSet().toList() + ['']);
    }
  }

  Exercise addExercise(String name, int bpmStart, int bpmEnd, int minutes) {
    final box = Hive.box<Exercise>(EXERCISES_BOX);
    final exercise = Exercise(name, bpmStart, bpmEnd, minutes);
    final exerciseInBox = box.values.where((el) => el == exercise);

    if (exerciseInBox.isEmpty) {
      box.add(exercise);
      exercise.save();
      return exercise;
    }
    return exerciseInBox.first;
  }

  void deleteItem(int index, TabType type) {
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

  void _deleteItem(int index, List<dynamic> items) {
    if (items.length == 1) {
      (items[0] is String) ? items[0] = '' : items[0].name = '';
    } else {
      items.removeAt(index);
    }
  }

  @override
  String toString() =>
      'Practice { $instrument, goals: $goals, exercises: $exercises, positives: $positives, '
      'improvements: $improvements, notes: $notes, datetime: $datetime }';
}
