import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:musicavis/providers/repository.dart';
import 'package:musicavis/ui/widgets/dialogs.dart';

class InstrumentListRoute extends HookWidget {
  const InstrumentListRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final instruments = useProvider(instrumentStateNotifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Instruments'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showAlertDialogWithTextField(
              context,
              {
                'title': 'Instrument not listed?',
                'hint': 'Enter instrument name...',
                'ok_button': 'Add Instrument',
              },
              TextEditingController(),
              null,
            ),
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
            Text(
              instrument.name,
              style: TextStyle(
                color: instrument.isSelected ? Colors.red : Colors.white,
              ),
            )
        ],
      ),
    );
  }
}
