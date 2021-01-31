import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musicavis/providers/settings.dart';
import 'package:musicavis/repository/models/practice.dart';
import 'package:musicavis/repository/practice/index.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/widgets.dart';

class PracticeProvider extends StateNotifier<Practice> {
  DataHolder dataHolder;
  Map<TabType, List<FocusNode>> nodes;

  PracticeProvider(Practice practice, bool isFromPractice) : super(practice) {
    dataHolder = DataHolder.from(practice, isFromPractice);
    nodes = {
      TabType.goal: makeNodes(practice.goals.length),
      TabType.exercise: makeNodes(practice.exercises.length),
      TabType.positive: makeNodes(practice.positives.length),
      TabType.improvement: makeNodes(practice.improvements.length),
    };
  }

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
    dataHolder = DataHolder.from(practice, true);
    nodes = {
      TabType.goal: [FocusNode()],
      TabType.exercise: [FocusNode()],
      TabType.positive: [FocusNode()],
      TabType.improvement: [FocusNode()],
    };
    state = practice;
  }

  void save() {
    state.refreshExercises(dataHolder);
    state.savePractice(dataHolder);
  }

  void delete() {
    state.deletePractice();
  }

  void update(TabType type, int index, String value) =>
      state.update(type, index, value);

  // Crud operations on items
  void addItem(TabType type) {
    if (dataHolder.isEligibleForNewItem(type)) {
      state.updateAll(type, dataHolder);
      dataHolder.addEntry(type);
      nodes[type].add(FocusNode()..requestFocus());
      state = state..add('', type);
    }
  }

  void updateItem(TabType type, int index, String value) {
    switch (type) {
      case TabType.goal:
        dataHolder.goals[index] = value;
        break;
      case TabType.exercise:
        dataHolder.exercises.exercises[index].name = value;
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

  void deleteItem(TabType type, int index) {
    dataHolder.deleteItem(type, index);
    state = state..deleteItem(index, type);
  }
}
