import 'package:flutter/material.dart';

List<Widget> cancelSaveButtons(BuildContext context, Function onSave) {
  return [
    RaisedButton(
      child: Text('Cancel'),
      color: Colors.redAccent,
      onPressed: () => Navigator.of(context).pop(),
    ),
    RaisedButton(
      child: Text('Save'),
      color: Colors.blueAccent,
      onPressed: () => onSave(),
    ),
  ];
}
