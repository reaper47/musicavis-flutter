import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/utils/constants.dart';
import 'package:musicavis/utils/extensions.dart';

final instrumentsProvider = StateNotifierProvider((_) => InstrumentList());

class InstrumentList extends StateNotifier<List<InstrumentItem>> {
  final _instrumentsBox = Hive.box<String>(INSTRUMENTS_BOX);
  final _settingsBox = Hive.box(SETTINGS_BOX);

  InstrumentList() : super([]) {
    final _instrumentsBox = Hive.box<String>(INSTRUMENTS_BOX);
    final _selectedItems =
        Hive.box(SETTINGS_BOX).get(SETTINGS_INSTRUMENTS_SELECTED_KEY);

    state = [
      for (var x in _instrumentsBox.toMap().entries)
        InstrumentItem(
          id: x.key,
          name: x.value,
          isSelected: _selectedItems.contains(x.key),
        )
    ];
  }

  add(String name) {
    if (_instrumentsBox.get(name.toLowerCase()) == null) {
      final id = state.length + 1;
      _instrumentsBox.put(id, name.toLowerCase());
      state = [...state, InstrumentItem(id: id, name: name.toTitleCase())];
      state.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  toggle(int id) {
    List<InstrumentItem> _newState = [];
    final _instrumentsSelected =
        _settingsBox.get(SETTINGS_INSTRUMENTS_SELECTED_KEY);

    for (final item in state) {
      if (item.id == id) {
        bool _isSelected = !item.isSelected;

        _isSelected
            ? _instrumentsSelected.add(id)
            : _instrumentsSelected.remove(id);

        _newState.add(InstrumentItem(
          id: id,
          name: item.name,
          isSelected: _isSelected,
        ));
      } else {
        _newState.add(item);
      }
    }

    state = _newState;
    _settingsBox.put(SETTINGS_INSTRUMENTS_SELECTED_KEY, _instrumentsSelected);
  }
}

class InstrumentItem {
  int id;
  String name;
  bool isSelected;

  InstrumentItem({this.id, String name, this.isSelected = false}) {
    this.name = name.toTitleCase();
  }

  @override
  String toString() =>
      'InstrumentItem { id: $id, name: $name, isSelected: $isSelected }';
}
