import 'package:flutter/material.dart';

import 'package:musicavis/providers/practice.dart';
import 'package:musicavis/ui/routes/practice/tabs/exercise/avatar.dart';
import 'package:musicavis/ui/routes/practice/tabs/exercise/title.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/ui/widgets/simple_slider.dart';

class ExerciseItem extends StatefulWidget {
  final int index;
  final PracticeProvider practice;

  ExerciseItem(this.index, this.practice);

  @override
  _ExerciseItemState createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  @override
  Widget build(BuildContext context) {
    final exercises = widget.practice.dataHolder.exercises;

    final exercise = exercises.exercises[widget.index];
    final bpmStartRange = exercises.bpmStartRanges[widget.index];
    final bpmEndRange = exercises.bpmEndRanges[widget.index];
    final minuteRange = exercises.minuteRanges[widget.index];
    final isEnabled = exercises.isEnabled[widget.index];

    return ListTile(
      leading: GestureDetector(
        onTapDown: (event) {
          setState(() => exercises.toggleEnabled(widget.index));
        },
        child: makeAvatar(widget.index, isEnabled),
      ),
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: isEnabled
                ? TitleEnabled(
                    widget.index,
                    exercise.name,
                    widget.practice.crud,
                    widget.practice.nodes[TabType.exercise][widget.index],
                  )
                : TitleDisabled(exercise.name),
          ),
          SimpleSlider('BPM Start', bpmStartRange, isEnabled),
          SimpleSlider('BPM End', bpmEndRange, isEnabled),
          SimpleSlider('Minutes', minuteRange, isEnabled),
        ],
      ),
    );
  }
}
