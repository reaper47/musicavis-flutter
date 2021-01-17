import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'package:musicavis/utils/practice.dart';

part 'practice.g.dart';

@HiveType(typeId: 2)
class Practice extends HiveObject {
  @HiveField(0)
  String instrument;

  @HiveField(1)
  List<String> goals;

  @HiveField(2)
  HiveList exercises;

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

  String get title => '$instrument - ${DateFormat('yMMMd').format(datetime)}';

  List<String> get goalList => goals ?? [''];
  List<String> get positiveList => positives ?? [''];
  List<String> get improvementList => improvements ?? [''];

  void update(ComponentType type, int index, String value) {
    switch (type) {
      case ComponentType.goals:
        goals[index] = value;
        break;
      case ComponentType.improvements:
        improvements[index] = value;
        break;
      case ComponentType.positives:
        positives[index] = value;
        break;
      default:
        break;
    }
  }

  void setNotes(String newNotes) => notes = newNotes;

  void add(String item, ComponentType type) {
    switch (type) {
      case ComponentType.goals:
        _addItem(item, goals);
        break;
      case ComponentType.improvements:
        _addItem(item, improvements);
        break;
      case ComponentType.positives:
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

  void deleteItem(int index, ComponentType type) {
    switch (type) {
      case ComponentType.goals:
        _deleteItem(index, goals);
        break;
      case ComponentType.improvements:
        _deleteItem(index, improvements);
        break;
      case ComponentType.positives:
        _deleteItem(index, positives);
        break;
      default:
        break;
    }
  }

  void _deleteItem(int index, List<String> items) {
    if (items.length == 1) {
      items[0] = '';
    } else {
      items.removeAt(index);
    }
  }

  @override
  String toString() =>
      'Practice { $instrument, goals: $goals, exercises: $exercises, positives: $positives, '
      'improvements: $improvements, notes: $notes, datetime: $datetime }';
}
