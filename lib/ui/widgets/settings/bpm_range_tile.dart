import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/utils/constants.dart';

class BpmRangeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('BPM Range'),
      dense: false,
      subtitle: Text('Set your preferred BPM range.'),
      onTap: () => showDialog(
        context: context,
        builder: (context) => BpmRangeDialog(),
      ),
      trailing: Icon(
        Icons.chevron_right,
      ),
    );
  }
}

class BpmRangeDialog extends StatefulWidget {
  BpmRangeDialog({Key key}) : super(key: key);

  @override
  _BpmRangeDialogState createState() => _BpmRangeDialogState();
}

class _BpmRangeDialogState extends State<BpmRangeDialog> {
  RangeValues _currentRangeValues;
  Box _box;

  @override
  void initState() {
    _box = Hive.box(SETTINGS_BOX);
    _currentRangeValues = RangeValues(
      _box.get(SETTINGS_BPM_MIN_KEY) + .0,
      _box.get(SETTINGS_BPM_MAX_KEY) + .0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _min = _currentRangeValues.start.round().toString();
    final _max = _currentRangeValues.end.round().toString();

    return AlertDialog(
      title: Center(
        child: Text(
          "Set BPM Range",
          textAlign: TextAlign.center,
        ),
      ),
      content: Column(
        children: [
          Text('Min: $_min'),
          RangeSlider(
            values: _currentRangeValues,
            min: 30,
            max: 300,
            divisions: 27,
            onChanged: (values) => setState(() => _currentRangeValues = values),
          ),
          Text('Max: $_max'),
        ],
      ),
      scrollable: true,
      actions: [
        RaisedButton(
          color: Colors.redAccent,
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        RaisedButton(
          onPressed: () {
            _setBpm(
              _currentRangeValues.start.round(),
              _currentRangeValues.end.round(),
            );
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  void _setBpm(int min, int max) {
    if (min.compareTo(max) == 0) {
      max += 10;
    }
    _box.put(SETTINGS_BPM_MIN_KEY, min);
    _box.put(SETTINGS_BPM_MAX_KEY, max);
  }
}
