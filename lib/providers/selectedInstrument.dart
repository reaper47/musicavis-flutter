import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/providers/repository.dart';
import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/utils/constants.dart';

final selectedInstrumentsStateNotifier =
    StateNotifierProvider((_) => SelectedInstrumentsList());

class SelectedInstrumentsList extends StateNotifier<List<InstrumentItem>> {
  List<InstrumentItem> _instruments = [];
  String _selected;
  final _instrumentsBox = Hive.box<String>(INSTRUMENTS_BOX);
  final _settingsBox = Hive.box(SETTINGS_BOX);

  SelectedInstrumentsList([List<InstrumentItem> items]) : super(items ?? []);

  List<dynamic> get ids => _settingsBox.get(SETTINGS_INSTRUMENTS_SELECTED_KEY);

  List<InstrumentItem> get instruments {
    _refresh();
    return _instruments;
  }

  String get firstInstrument => _selected ?? _instruments[0].name;

  _refresh() {
    _instruments.clear();

    final selected = _settingsBox.get(SETTINGS_INSTRUMENTS_SELECTED_KEY);
    if (selected.isEmpty) {
      final ids = _instrumentsBox.keys.toList();
      final names = _instrumentsBox.values.toList();
      names.asMap().forEach((i, name) =>
          _instruments.add(InstrumentItem(id: ids[i], name: name)));
    } else {
      for (int id in selected) {
        _instruments.add(InstrumentItem(id: id, name: _instrumentsBox.get(id)));
      }
    }

    _instruments.sort((a, b) => a.name.compareTo(b.name));
  }

  setSelectedInstrument(String instrument) => _selected = instrument;
}
