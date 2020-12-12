import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/utils/extensions.dart';

class InstrumentItem {
  int id;
  String name;
  bool isSelected;

  InstrumentItem({this.id, String name, this.isSelected = false}) {
    this.name = name.capitalize();
  }
}

class InstrumentList extends StateNotifier<List<InstrumentItem>> {
  List<String> _selectedItems = [];
  final _box = Hive.box<String>(INSTRUMENTS_BOX);

  InstrumentList(List<InstrumentItem> items) : super(items);

  void add(String name) {
    if (_box.get(name.toLowerCase()) == null) {
      _box.add(name.toLowerCase());
      state = [
        ...state,
        InstrumentItem(
          id: state.length + 1,
          name: name.capitalize(),
        )
      ];
    }
  }

  void toggle(int id) {
    state = [
      for (final item in state)
        if (item.id == id)
          InstrumentItem(
            id: item.id,
            name: item.name,
            isSelected: !item.isSelected,
          )
        else
          item,
    ];
  }
}
