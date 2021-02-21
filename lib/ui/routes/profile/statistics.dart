import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicavis/providers/statistics.dart';
import 'package:musicavis/ui/widgets/simple_dropdown.dart';
import 'package:musicavis/utils/themes.dart';

class StatisticsContainer extends HookWidget {
  const StatisticsContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(statisticsProvider);
    useProvider(statisticsProvider.state);
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
                  Text('Statistics', style: bigTextStyle),
                  provider.hasPractices
                      ? SimpleDropdown(
                          provider.categories,
                          provider.category,
                          updateCategory,
                        )
                      : Container(),
                ],
              ),
            ),
            provider.hasPractices
                ? Statistics(provider.statistics)
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
            title: Text(stat.first),
            subtitle: stat.length > 2 ? Text(stat.last) : null,
            trailing: Text(stat[1]),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          )
      ],
    );
  }
}
