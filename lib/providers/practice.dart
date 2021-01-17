import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/practice.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';

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

  void addItem(TabType type) => state.add('', type);

  void updateItem(TabType type, int index, String value) =>
      state.update(type, index, value);

  void deleteItem(TabType type, int index) => state.deleteItem(index, type);

  List<String> getItems(TabType type) {
    switch (type) {
      case TabType.goal:
        return state.goals;
      case TabType.improvement:
        return state.improvements;
      case TabType.positive:
        return state.positives;
      default:
        return [];
    }
  }
}
