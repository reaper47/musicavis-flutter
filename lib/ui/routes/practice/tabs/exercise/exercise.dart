import 'package:flutter/material.dart';

import 'package:flutter_riverpod/all.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:musicavis/providers/practice.dart';
import 'package:musicavis/ui/routes/practice/tabs/exercise/item.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';

class ExerciseTab extends StatelessWidget {
  final StateNotifierProvider<PracticeProvider> provider;

  ExerciseTab(this.provider);

  @override
  Widget build(BuildContext context) {
    final practice = context.read(provider);
    final exercises = practice.dataHolder.exercises;
    final items = practice.dataHolder.exercises;

    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            child: ExerciseItem(ExerciseItemComponents(
              index,
              exerciseDao: exercises.exercises[index],
              bpmStartRange: exercises.bpmStartRanges[index],
              bpmEndRange: exercises.bpmEndRanges[index],
              minuteRange: exercises.minuteRanges[index],
              isEnabled: exercises.isEnabled[index],
              toggle: exercises.toggleEnabled,
              crud: practice.crud,
              nodes: practice.nodes,
            )),
          ),
          secondaryActions: items.length == 1
              ? []
              : [
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () => practice.crud.delete(TabType.exercise, index),
                  ),
                ],
        ),
      ),
    );
  }
}
