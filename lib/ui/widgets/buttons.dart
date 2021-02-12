import 'package:flutter/material.dart';

List<Widget> cancelSaveButtons(BuildContext context, Function onSave,
    [Function onCancel]) {
  return [
    RaisedButton(
      child: Text('Cancel'),
      color: Colors.redAccent,
      onPressed: () {
        if (onCancel != null) {
          onCancel();
        }
        Navigator.of(context).pop();
      },
    ),
    RaisedButton(
      child: Text('Save'),
      color: Colors.blueAccent,
      onPressed: () => onSave(),
    ),
  ];
}
