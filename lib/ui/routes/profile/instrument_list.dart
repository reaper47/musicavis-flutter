import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:musicavis/providers/repository.dart';
import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/ui/widgets/dialogs.dart';
import 'package:musicavis/utils/constants.dart';
import 'package:musicavis/utils/themes.dart';

class InstrumentListRoute extends HookWidget {
  const InstrumentListRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _instruments = useProvider(instrumentStateNotifier.state);

    final _selectedInstruments =
        Hive.box(SETTINGS_BOX).get(SETTINGS_INSTRUMENTS_SELECTED_KEY);

    final _isLightTheme =
        Hive.box(SETTINGS_BOX).get(SETTINGS_THEME_KEY) == LIGHT_THEME_PREF;

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Instruments'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                final _controller = TextEditingController();
                return showAlertDialogWithTextField(
                  context,
                  {
                    'title': 'Instrument not listed?',
                    'hint': 'Enter instrument name...',
                    'ok_button': 'Add Instrument',
                  },
                  _controller,
                  (context) => _addInstrument(context, _controller.text),
                );
              })
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
        childAspectRatio: 2.4,
        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 43),
        children: [
          for (var instrument in _instruments)
            GestureDetector(
              child: _buildTile(
                context,
                instrument.name,
                _selectedInstruments.contains(instrument.id),
                _isLightTheme,
              ),
              onTap: () =>
                  context.read(instrumentStateNotifier).toggle(instrument.id),
            )
        ],
      ),
    );
  }

  void _addInstrument(BuildContext context, String name) {
    context.read(instrumentStateNotifier).add(name);
    Navigator.of(context).pop();
  }

  Widget _buildTile(BuildContext context, String instrumentName,
      bool isSelected, bool isLightTheme) {
    final _backgroundColor =
        isLightTheme ? Colors.grey[200] : Theme.of(context).primaryColor;

    final _lightBorder = isSelected ? Colors.red[600] : Colors.grey[300];
    final _darkBorder = isSelected
        ? Theme.of(context).accentColor.withOpacity(0.6)
        : Colors.grey[700];

    final _lightText = isSelected ? Colors.red[900] : null;
    final _darkText = isSelected ? Colors.blue[200] : null;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: isLightTheme ? _lightBorder : _darkBorder),
        color: _backgroundColor,
      ),
      child: Text(
        instrumentName,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: isLightTheme ? _lightText : _darkText,
        ),
      ),
    );
  }
}
