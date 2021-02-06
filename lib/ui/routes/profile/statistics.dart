import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  final List<List<String>> statistics;

  Statistics(this.statistics, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        for (var stat in statistics)
          ListTile(
            leading: Icon(Icons.arrow_right_outlined),
            title: Text(stat[0]),
            trailing: Text(stat[1]),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          )
      ],
    );
  }
}
