import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:musicavis/providers/practice.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/colors.dart';

class ListTab extends StatelessWidget {
  final TabType type;
  final StateNotifierProvider<PracticeProvider> provider;

  ListTab(this.type, this.provider);

  @override
  Widget build(BuildContext context) {
    final practice = context.read(provider);
    final items = _getItems(practice);

    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: rainbow[index % rainbow.length],
                  child: Text((index + 1).toString()),
                  foregroundColor: Colors.white,
                ),
                title: TextField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: items[index],
                      selection: TextSelection.collapsed(
                        offset: items[index].length,
                      ),
                    ),
                  ),
                  decoration: InputDecoration(
                    hintText: captionTabType(type),
                  ),
                  onChanged: (value) =>
                      practice.crud.update(type, index, value),
                  onEditingComplete: () => practice.crud.add(type),
                  focusNode: practice.nodes[type][index],
                ),
              ),
            ),
            secondaryActions: items.length == 1
                ? []
                : [
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => practice.crud.delete(type, index),
                    )
                  ],
          ),
        ),
      ),
    );
  }

  List<dynamic> _getItems(PracticeProvider practice) {
    switch (type) {
      case TabType.goal:
        return practice.goals;
      case TabType.improvement:
        return practice.improvements;
      case TabType.positive:
        return practice.positives;
      default:
        return [];
    }
  }
}
