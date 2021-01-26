import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/colors.dart';
import 'package:musicavis/utils/practice/index.dart';

class ListTab extends StatelessWidget {
  final TabType type;
  final List<dynamic> items;
  final CrudOperations crud;
  final List<FocusNode> nodes;
  final bool isPopAction;

  ListTab(this.type, this.items, this.crud, this.nodes, this.isPopAction) {
    if (!isPopAction && items.length > 1) {
      nodes.last = FocusNode()..requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => Slidable(
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
                onChanged: (value) => crud.update(type, index, value),
                onEditingComplete: () {
                  nodes[index]?.unfocus();
                  crud.add(type);
                },
                focusNode: nodes[index],
              ),
            ),
          ),
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
    );
  }
}
