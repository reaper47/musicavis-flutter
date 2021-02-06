import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:musicavis/providers/profile.dart';
import 'package:musicavis/ui/routes/profile/charts.dart';
import 'package:musicavis/ui/routes/profile/statistics.dart';
import 'package:musicavis/ui/widgets/simple_dropdown.dart';
import 'package:musicavis/utils/themes.dart';

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

class StatisticsContainer extends HookWidget {
  const StatisticsContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(statisticsProvider.state);
    final updateCategory = context.read(statisticsProvider).updateCategory;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Statistics',
                    style: TextStyle(fontSize: biggerFontSize),
                  ),
                  state.hasPractices
                      ? SimpleDropdown(
                          state.categories,
                          state.category,
                          updateCategory,
                        )
                      : Container(),
                ],
              ),
            ),
            state.hasPractices
                ? Statistics(state.statistics)
                : Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      child: Center(
                        child: Text('You have not practiced yet.'),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class GraphsContainer extends StatelessWidget {
  const GraphsContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Graphs',
                  style: TextStyle(fontSize: biggerFontSize),
                ),
              ],
            ),
          ),
          PracticeTimeChart(),
        ],
      ),
    );
  }
}
