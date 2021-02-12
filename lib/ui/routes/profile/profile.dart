import 'package:flutter/material.dart';
import 'package:musicavis/ui/routes/profile/graphics.dart';
import 'package:musicavis/ui/routes/profile/statistics.dart';

class ProfileRoute extends StatelessWidget {
  const ProfileRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const StatisticsContainer(),
              const Divider(),
              const GraphsContainer(),
            ],
          ),
        ],
      ),
    );
  }
}
