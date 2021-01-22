import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/providers/settings.dart';
import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/practice.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/practice.dart';

final practiceStateNotifier = StateNotifierProvider((_) => PracticeProvider());

class PracticeProvider extends StateNotifier<Practice> {
  final _practiceBox = Hive.box<Practice>(PRACTICES_BOX);
  Exercises exercises;
  DataHolder dataHolder = DataHolder.init();

  PracticeProvider([Practice practice]) : super(practice ?? null);

  // Getters
  CrudOperations get crud => CrudOperations(
        add: addItem,
        delete: deleteItem,
        update: updateItem,
      );

  String get title => state.title;

  List<String> get goals => state.goals;

  List<String> get positives => state.positives;

  List<String> get improvements => state.improvements;

  String get notes => state.notes;

  // Crud operations on practice
  void create(String instrument, SettingsState settings) {
    final practice = Practice.create(instrument);
    exercises = Exercises.create(practice.exercises, settings);
    state = practice;
  }

  void save() {
    //
  }

  void delete() {
    //
  }

  void update(TabType type, int index, String value) =>
      state.update(type, index, value);

  // Crud operations on items
  void addItem(TabType type) {
    state.updateAll(type, dataHolder);
    dataHolder.addEntry(type);
    state = state..add('', type);
  }

  void updateItem(TabType type, int index, String value) {
    switch (type) {
      case TabType.goal:
        dataHolder.goals[index] = value;
        break;
      case TabType.exercise:
        dataHolder.exerciseNames[index] = value;
        break;
      case TabType.positive:
        dataHolder.positives[index] = value;
        break;
      case TabType.improvement:
        dataHolder.improvements[index] = value;
        break;
      case TabType.notes:
        state.update(TabType.notes, -1, value);
        break;
      default:
    }
  }

  void deleteItem(TabType type, int index) =>
      state = state..deleteItem(index, type);
}
