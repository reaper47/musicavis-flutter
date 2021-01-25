import 'package:flutter/material.dart';

import 'package:musicavis/ui/routes/practice/tabs/exercise/avatar.dart';
import 'package:musicavis/ui/routes/practice/tabs/exercise/title.dart';
import 'package:musicavis/ui/widgets/simple_slider.dart';
import 'package:musicavis/utils/practice/index.dart';

class ExerciseItem extends StatefulWidget {
  final int index;
  final Exercises exercises;
  final CrudOperations crud;

  ExerciseItem(this.index, this.exercises, this.crud);

  @override
  _ExerciseItemState createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercises.exercises[widget.index];
    final bpmStartRange = widget.exercises.bpmStartRanges[widget.index];
    final bpmEndRange = widget.exercises.bpmEndRanges[widget.index];
    final minuteRange = widget.exercises.minuteRanges[widget.index];
    final isEnabled = widget.exercises.isEnabled[widget.index];

    return ListTile(
      leading: GestureDetector(
        onTapDown: (event) =>
            setState(() => widget.exercises.toggleEnabled(widget.index)),
        child: makeAvatar(widget.index, isEnabled),
      ),
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: makeTitle(
              widget.index,
              exercise.name,
              widget.crud,
              isEnabled,
            ),
          ),
          SimpleSlider('BPM Start', bpmStartRange, isEnabled),
          SimpleSlider('BPM End', bpmEndRange, isEnabled),
          SimpleSlider('Minutes', minuteRange, isEnabled),
        ],
      ),
    );
  }
}
