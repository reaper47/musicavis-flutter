import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:musicavis/providers/practice.dart';
import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/colors.dart';
import 'package:musicavis/utils/practice.dart';

class ListTab extends StatefulHookWidget {
  final CrudOperations crud;

  ListTab(this.crud);

  @override
  _ListTabState createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  TabType type;
  String placeholderText;

  @override
  void initState() {
    type = widget.crud.type;
    placeholderText = captionTabType(widget.crud.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items =
        context.read(practiceStateNotifier).getItems(widget.crud.type);

    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Slidable(
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
                  controller: TextEditingController(text: item),
                  decoration: InputDecoration(hintText: placeholderText),
                  onChanged: (value) => widget.crud.update(type, index, value),
                ), // Text(item),
              ),
            ),
            secondaryActions: [
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => setState(() => widget.crud.delete(type, index)),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: 'Add and entry',
        onPressed: () => setState(() => widget.crud.add(type)),
        child: Icon(Icons.add),
      ),
    );
  }
}
