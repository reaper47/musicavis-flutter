import 'package:flutter/material.dart';
import 'package:musicavis/utils/enums.dart';

import 'goals_container.dart';

class GoalsRoute extends StatelessWidget {
  const GoalsRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                const GoalsContainer(GoalType.weekly),
                const GoalsContainer(GoalType.monthly),
                const GoalsContainer(GoalType.yearly),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
