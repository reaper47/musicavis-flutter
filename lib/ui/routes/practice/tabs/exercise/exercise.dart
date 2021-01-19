import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:musicavis/repository/models/exercise.dart';
import 'package:musicavis/ui/routes/practice/tabs/exercise/item.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/practice.dart';

class ExerciseTab extends StatelessWidget {
  final type = TabType.exercise;
  final List<Exercise> items;
  final CrudOperations crud;

  ExerciseTab(this.items, this.crud);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(child: ExerciseItem(index, items[index])),
            secondaryActions: [
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => crud.delete(type, index),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          tooltip: 'Add an entry',
          onPressed: () => crud.add(type),
          child: Icon(Icons.add),
        ));
  }
}
