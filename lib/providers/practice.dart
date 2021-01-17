import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/practice.dart';
import 'package:musicavis/utils/practice.dart';

final practiceStateNotifier = StateNotifierProvider((_) => PracticeProvider());

class PracticeProvider extends StateNotifier<Practice> {
  final _practiceBox = Hive.box<Practice>(PRACTICES_BOX);

  PracticeProvider([Practice practice]) : super(practice ?? null);

  void create(String instrument) {
    final practice = Practice(instrument: instrument, datetime: DateTime.now());
    practice.goals = [''];
    practice.positives = [''];
    practice.improvements = [''];
    //_practiceBox.add(practice);
    state = practice;
  }

  void save() {
    //
  }

  void delete() {
    //
  }

  void addItem(ComponentType type) => state.add('', type);

  void updateItem(ComponentType type, int index, String value) =>
      state.update(type, index, value);
  void updateNotes(String notes) => state.setNotes(notes);

  void deleteItem(ComponentType type, int index) =>
      state.deleteItem(index, type);

  List<String> getItems(ComponentType componentType) {
    switch (componentType) {
      case ComponentType.goals:
        return state.goals;
      case ComponentType.improvements:
        return state.improvements;
      case ComponentType.positives:
        return state.positives;
      default:
        return [];
    }
  }
}

String getPlaceholderText(ComponentType type) {
  switch (type) {
    case ComponentType.goals:
      return "Today's practice goal...";
    case ComponentType.positives:
      return 'What went great?';
    case ComponentType.improvements:
      return 'What is to improve?';
    default:
      return 'Additional notes on the practice...';
  }
}
