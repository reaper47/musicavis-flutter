import 'package:flutter/material.dart';

class SimpleSlider extends StatefulWidget {
  final int min;
  final int current;
  final int max;

  SimpleSlider(this.min, this.current, this.max);

  @override
  _SimpleSliderState createState() => _SimpleSliderState();
}

class _SimpleSliderState extends State<SimpleSlider> {
  double _current;

  @override
  void initState() {
    _current = widget.current.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _current,
      min: widget.min.toDouble(),
      max: widget.max.toDouble(),
      divisions: widget.max - widget.min,
      label: _current.round().toString(),
      onChanged: (value) => setState(() => _current = value),
    );
  }
}
