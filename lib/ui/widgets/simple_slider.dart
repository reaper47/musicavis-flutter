import 'package:flutter/material.dart';

import 'package:musicavis/repository/practice/values.dart';
import 'package:musicavis/utils/themes.dart';

final smallGrey = greyTextStyle(smallFontSize);

class SimpleSlider extends StatefulWidget {
  final String label;
  final Values values;
  final bool isEnabled;

  const SimpleSlider(this.label, this.values, this.isEnabled);

  @override
  _SimpleSliderState createState() => _SimpleSliderState();
}

class _SimpleSliderState extends State<SimpleSlider> {
  double _current;

  @override
  initState() {
    _current = widget.values.current.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final min = widget.values.min;
    final max = widget.values.max;

    if (widget.isEnabled) {
      return Column(
        children: [
          Row(
            children: [
              Text(
                widget.label,
                style: TextStyle(fontSize: smallFontSize),
              ),
              Flexible(
                child: Slider(
                  value: widget.values.current.toDouble(),
                  min: min.toDouble(),
                  max: max.toDouble(),
                  divisions: max - min,
                  onChanged: (value) =>
                      setState(() => widget.values.current = value.toInt()),
                ),
              ),
              Text(widget.values.current.toInt().toString())
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        Text(widget.label, style: smallGrey),
        Flexible(
          child: Slider(
            value: _current,
            min: widget.values.min.toDouble(),
            max: widget.values.max.toDouble(),
            onChanged: null,
          ),
        ),
        Text('${_current.toInt()}', style: smallGrey),
      ],
    );
  }
}
