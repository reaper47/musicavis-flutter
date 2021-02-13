import 'package:flutter/material.dart';
import 'package:musicavis/repository/practice/exercise_dao.dart';
import 'package:musicavis/repository/practice/index.dart';
import 'package:musicavis/ui/routes/practice/tabs/exercise/avatar.dart';
import 'package:musicavis/ui/routes/practice/tabs/exercise/title.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/ui/widgets/simple_slider.dart';

class ExerciseItem extends StatefulWidget {
  final ExerciseItemComponents components;

  ExerciseItem(this.components);

  @override
  _ExerciseItemState createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  @override
  Widget build(BuildContext context) {
    final components = widget.components;
    return ListTile(
      leading: GestureDetector(
        onTapDown: (event) {
          setState(() => components.toggle(components.index));
        },
        child: makeAvatar(components.index, components.isEnabled),
      ),
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: components.isEnabled
                ? TitleEnabled(
                    components.index,
                    components.exerciseDao.name,
                    components.crud,
                    components.nodes[TabType.exercise][components.index],
                  )
                : TitleDisabled(components.exerciseDao.name),
          ),
          SimpleSlider(
              'BPM Start', components.bpmStartRange, components.isEnabled),
          SimpleSlider('BPM End', components.bpmEndRange, components.isEnabled),
          SimpleSlider('Minutes', components.minuteRange, components.isEnabled),
        ],
      ),
    );
  }
}

class ExerciseItemComponents {
  final int index;
  final ExerciseDao exerciseDao;
  final Values bpmStartRange;
  final Values bpmEndRange;
  final Values minuteRange;
  final bool isEnabled;
  final Function(int) toggle;
  final CrudOperations crud;
  final Map<TabType, List<FocusNode>> nodes;

  const ExerciseItemComponents(
    this.index, {
    this.exerciseDao,
    this.bpmStartRange,
    this.bpmEndRange,
    this.minuteRange,
    this.isEnabled,
    this.toggle,
    this.crud,
    this.nodes,
  });
}
