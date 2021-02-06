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
    final items = practice.dataHolder.exercises;

    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            child: ExerciseItem(index, practice),
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
