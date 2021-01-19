import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/practice.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/practice.dart';

final practiceStateNotifier = StateNotifierProvider((_) => PracticeProvider());

class PracticeProvider extends StateNotifier<Practice> {
  final _practiceBox = Hive.box<Practice>(PRACTICES_BOX);

  PracticeProvider([Practice practice]) : super(practice ?? null);

  CrudOperations get crud => CrudOperations(
        add: addItem,
        delete: deleteItem,
        update: updateItem,
      );

  void create(String instrument) => state = Practice.create(instrument);

  void save() {
    //
  }

  void delete() {
    //
  }

  void addItem(TabType type) => state = state..add('', type);

  void updateItem(TabType type, int index, String value) =>
      state = state..update(type, index, value);

  void deleteItem(TabType type, int index) =>
      state = state..deleteItem(index, type);
}
