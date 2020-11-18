import 'package:flutter/material.dart';

void showAlertDialogWithTextField(
  BuildContext context,
  Map<String, String> text,
  TextEditingController controller,
  dynamic callback,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text['title']),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: text['hint'],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: Navigator.of(context).pop,
          child: Text('Cancel'),
          color: Colors.redAccent,
        ),
        FlatButton(
          onPressed: () =>
              controller.text.trim().isNotEmpty ? callback(context) : null,
          child: Text(text['ok_button']),
          color: Colors.blueAccent,
        ),
      ],
    ),
  );
}
