import 'package:flutter/material.dart';

class SimpleSlider extends StatefulWidget {
  final Values values;

  const SimpleSlider(this.values);

  @override
  _SimpleSliderState createState() => _SimpleSliderState();
}

class _SimpleSliderState extends State<SimpleSlider> {
  double _current;

  @override
  void initState() {
    _current = widget.values.current.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _current,
      min: widget.values.min.toDouble(),
      max: widget.values.max.toDouble(),
      divisions: widget.values.max - widget.values.min,
      label: _current.round().toString(),
      onChanged: (value) => setState(() => _current = value),
    );
  }
}

class Values {
  final int min;
  final int current;
  final int max;

  const Values(this.min, this.current, this.max);
}
