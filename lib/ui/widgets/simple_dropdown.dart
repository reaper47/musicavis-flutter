import 'package:flutter/material.dart';

class SimpleDropdown extends StatelessWidget {
  final List<dynamic> items;
  final dynamic selected;
  final Function update;

  SimpleDropdown(this.items, this.selected, this.update, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<dynamic>(
      value: selected,
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: update,
      items: items
          .map<DropdownMenuItem>((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
    );
  }
}
