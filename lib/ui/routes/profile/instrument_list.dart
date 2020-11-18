import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:musicavis/ui/widgets/dialogs.dart';

class InstrumentListRoute extends HookWidget {
  const InstrumentListRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
        child: Text('hello'),
      ),
    );
  }
}
