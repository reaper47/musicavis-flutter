import 'package:flutter/material.dart';

import 'package:musicavis/utils/constants.dart';

class InstrumentsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Instruments'),
      dense: false,
      subtitle: Text('Select the instruments you play.'),
      onTap: () =>
          Navigator.of(context).pushNamed(ROUTE_PROFILE_SETTINGS_INSTRUMENTS),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
