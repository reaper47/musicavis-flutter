import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicavis/providers/graphics.dart';
import 'package:musicavis/providers/theme.dart';
import 'package:musicavis/ui/routes/profile/charts.dart';
import 'package:musicavis/ui/widgets/buttons.dart';
import 'package:musicavis/ui/widgets/simple_dropdown.dart';
import 'package:musicavis/utils/dates.dart';
import 'package:musicavis/utils/enums.dart';
import 'package:musicavis/utils/extensions.dart';
import 'package:musicavis/utils/themes.dart';

class GraphsContainer extends HookWidget {
  const GraphsContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = useProvider(themeStateNotifier.state);
    final themeData = getTheme(theme);

    final provider = useProvider(graphicsProvider.state);
    bool hasPractices = provider.hasPractices;

    return Container(
      child: Column(
        children: [
          _header(context, hasPractices),
          _graph(provider, themeData, hasPractices),
          _graphTitle(themeData, hasPractices),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, bool hasPractices) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Graphs', style: bigTextStyle),
          _optionButton(context, hasPractices),
        ],
      ),
    );
  }

  Widget _optionButton(BuildContext context, bool hasPractices) {
    return hasPractices
        ? Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: RaisedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => GraphOptionsDialog(),
              ),
              child: Text('Options'),
            ),
          )
        : Container();
  }

  Widget _graph(GraphicsData provider, ThemeData theme, bool hasPractices) {
    return hasPractices
        ? PracticeTimeChart(provider.practiceGraphData, theme)
        : Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              child: Center(
                child: Text('You have not practiced yet.'),
              ),
            ),
          );
  }

  Widget _graphTitle(ThemeData themeData, bool hasPractices) {
    return hasPractices
        ? GraphTitle(
            GraphType.practiceTime.name,
            themeData.textTheme.bodyText1.color.withOpacity(0.9),
          )
        : Container();
  }
}

class GraphOptionsDialog extends StatefulWidget {
  const GraphOptionsDialog({Key key}) : super(key: key);

  @override
  _GraphOptionsDialogState createState() => _GraphOptionsDialogState();
}

class _GraphOptionsDialogState extends State<GraphOptionsDialog> {
  GraphType _graphType = GraphType.practiceTime;
  Widget _graphOptions;

  @override
  Widget build(BuildContext context) {
    _graphOptions ?? _switchOptions(context, _graphType.name);

    final onSave = () {
      Navigator.of(context).pop();
      context.read(graphicsProvider.state).updateSelectedPracticeDates();
      context.read(graphicsProvider).refresh();
    };
    final onCancel = () {
      context.read(graphicsProvider.state).restoreSelectedPracticeDates();
    };

    return AlertDialog(
      title: Center(child: Text('Graph Options')),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Graph: '),
                SimpleDropdown(
                  GraphType.values.map((e) => e.name).toList(),
                  GraphType.practiceTime.name,
                  (name) => setState(() => _switchOptions(context, name)),
                ),
              ],
            ),
            _graphOptions,
          ],
        ),
      ),
      actions: cancelSaveButtons(context, onSave, onCancel),
    );
  }

  Widget _switchOptions(BuildContext context, String option) {
    if (option == GraphType.practiceTime.name) {
      _graphType = GraphType.practiceTime;
      _graphOptions = PracticeGraphOptions();
    }
    return Container();
  }
}

class PracticeGraphOptions extends HookWidget {
  PracticeGraphOptions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(graphicsProvider.state);
    final calendarDates = state.calendarDates;
    final selectedPracticeDates = state.selectedPracticeDates;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Start Date: '),
              TextButton(
                child: Text(
                  formatDate(selectedPracticeDates.first),
                  style: bigTextStyle,
                ),
                onPressed: () {
                  _getDate(context, calendarDates).then((x) {
                    state.startPracticeTime = x ?? selectedPracticeDates.first;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('End Date: '),
              TextButton(
                child: Text(
                  formatDate(selectedPracticeDates.last),
                  style: bigTextStyle,
                ),
                onPressed: () {
                  _getDate(context, calendarDates).then((x) {
                    state.endPracticeTime = x ?? selectedPracticeDates.last;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<DateTime> _getDate(BuildContext context, Dates dates) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: dates.first,
      lastDate: dates.last,
    );
  }
}
