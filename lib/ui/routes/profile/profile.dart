import 'package:flutter/material.dart';

class ProfileRoute extends StatelessWidget {
  const ProfileRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Profile'),
        ],
      ),
    );
  }
}
