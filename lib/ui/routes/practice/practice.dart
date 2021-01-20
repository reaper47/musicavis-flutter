import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:musicavis/providers/practice.dart';
import 'package:musicavis/providers/selectedInstrument.dart';
import 'package:musicavis/providers/settings.dart';
import 'package:musicavis/providers/theme.dart';
import 'package:musicavis/ui/routes/all.dart';
import 'package:musicavis/ui/widgets/simple_slider.dart';

class PracticeRoute extends HookWidget {
  const PracticeRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = useProvider(themeStateNotifier);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(36.0),
          child: themeProvider.isBlackTheme()
              ? ShadowContainer()
              : InstrumentSelectionCard(),
        ),
      ),
    );
  }
}

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).accentColor.withOpacity(0.36),
            blurRadius: 25.0,
            spreadRadius: 7.5,
          ),
        ],
      ),
      child: InstrumentSelectionCard(),
    );
  }
}

class InstrumentSelectionCard extends HookWidget {
  const InstrumentSelectionCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
            child: Center(
              child: Text(
                'Start a new practice sessions',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          Divider(indent: 16, endIndent: 16, thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Select instrument: ',
                style: TextStyle(fontSize: 16),
              ),
              InstrumentDropdown(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 5, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                ButtonBar(
                  buttonMinWidth: 120,
                  children: [
                    RaisedButton(
                      onPressed: () => _createPractice(context),
                      child: Text('Start'),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _createPractice(BuildContext context) {
    context
        .read(practiceStateNotifier)
        .create(context.read(selectedInstrumentsStateNotifier).firstInstrument);

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        final settings = context.read(settingsStateNotifier);
        final bpms = settings.bpmRange;
        final minutesMax = settings.minutesMax;

        return PracticeDetailsRoute(
          bpmRange: Values(bpms.min, (bpms.max + bpms.min) ~/ 2, bpms.max),
          minutesRange: Values(1, (minutesMax + 1) ~/ 2, minutesMax),
        );
      }),
    );
  }
}

class InstrumentDropdown extends StatefulHookWidget {
  InstrumentDropdown({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InstrumentDropdownState();
}

class _InstrumentDropdownState extends State<InstrumentDropdown> {
  @override
  Widget build(BuildContext context) {
    final instrumentsProvider = useProvider(selectedInstrumentsStateNotifier);

    return ValueListenableBuilder(
      valueListenable: context.read(settingsStateNotifier.state).listenable(),
      builder: (context, _, __) {
        return DropdownButton<String>(
          dropdownColor: Theme.of(context).cardColor.withOpacity(0.8),
          elevation: 16,
          icon: Icon(Icons.arrow_drop_down, size: 24),
          items: instrumentsProvider.instruments
              .map((x) => DropdownMenuItem(value: x.name, child: Text(x.name)))
              .toList(),
          onChanged: (x) =>
              setState(() => instrumentsProvider.setSelectedInstrument(x)),
          underline: Container(
            color: Theme.of(context).accentColor.withOpacity(0.8),
            height: 2,
          ),
          value: instrumentsProvider.firstInstrument,
        );
      },
    );
  }
}
