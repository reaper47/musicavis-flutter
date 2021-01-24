import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:musicavis/providers/instruments.dart';
import 'package:musicavis/providers/selectedInstrument.dart';
import 'package:musicavis/providers/theme.dart';
import 'package:musicavis/ui/widgets/dialogs.dart';

class InstrumentListRoute extends HookWidget {
  const InstrumentListRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final instruments = useProvider(instrumentsProvider.state);
    final selectedInstrumentsProvider =
        useProvider(selectedInstrumentsStateNotifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Instruments'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              final controller = TextEditingController();
              return showAlertDialogWithTextField(
                context,
                {
                  'title': 'Instrument not listed?',
                  'hint': 'Enter instrument name...',
                  'ok_button': 'Add Instrument',
                },
                controller,
                (context) => _addInstrument(context, controller.text),
              );
            },
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
        childAspectRatio: 2.4,
        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 43),
        children: [
          for (var instrument in instruments)
            GestureDetector(
              child: Tile(
                instrument.name,
                selectedInstrumentsProvider.ids.contains(instrument.id),
              ),
              onTap: () {
                context.read(instrumentsProvider).toggle(instrument.id);
                selectedInstrumentsProvider.setSelectedInstrument(null);
              },
            )
        ],
      ),
    );
  }

  _addInstrument(BuildContext context, String name) {
    context.read(instrumentsProvider).add(name);
    Navigator.of(context).pop();
  }
}

class Tile extends HookWidget {
  final String _name;
  final bool _isSelected;

  const Tile(this._name, this._isSelected, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = useProvider(themeStateNotifier);

    final isLightTheme = themeProvider.isLightTheme();
    final backgroundColor =
        isLightTheme ? Colors.grey[200] : Theme.of(context).primaryColor;

    final lightBorder = _isSelected ? Colors.red[600] : Colors.grey[300];
    final darkBorder = _isSelected
        ? Theme.of(context).accentColor.withOpacity(0.6)
        : Colors.grey[700];

    final lightText = _isSelected ? Colors.red[900] : null;
    final darkText = _isSelected ? Colors.blue[200] : null;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: isLightTheme ? lightBorder : darkBorder),
        color: backgroundColor,
      ),
      child: Text(
        _name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: isLightTheme ? lightText : darkText,
        ),
      ),
    );
  }
}
