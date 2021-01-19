import 'package:flutter/material.dart';

import 'package:musicavis/utils/colors.dart';

class AvatarEnabled extends StatelessWidget {
  final int number;

  AvatarEnabled(this.number);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: rainbow[number % rainbow.length],
      foregroundColor: Colors.white,
      child: Text((number + 1).toString()),
    );
  }
}

class AvatarDisabled extends StatelessWidget {
  const AvatarDisabled();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.green[700],
      child: Icon(Icons.check),
      foregroundColor: Colors.white,
    );
  }
}
