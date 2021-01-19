import 'package:flutter/material.dart';

import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/ui/routes/practice/tabs/exercise/avatar.dart';
import 'package:musicavis/ui/routes/practice/tabs/exercise/title.dart';
import 'package:musicavis/ui/widgets/simple_slider.dart';

class ExerciseItem extends StatefulWidget {
  final int index;
  final Exercise exercise;

  ExerciseItem(this.index, this.exercise);

  @override
  _ExerciseItemState createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final name = widget.exercise.name;

    final avatar = _isEnabled ? AvatarEnabled(index) : const AvatarDisabled();
    final title = _isEnabled ? TitleEnabled(name) : TitleDisabled(name);

    return ListTile(
      leading: GestureDetector(
        onTapDown: (event) => setState(() => _isEnabled = !_isEnabled),
        child: avatar,
      ),
      title: Column(
        children: [
          title,
          SimpleSlider(const Values(0, 50, 100)),
          SimpleSlider(const Values(0, 50, 100)),
          SimpleSlider(const Values(0, 50, 100)),
        ],
      ),
    );
  }
}
