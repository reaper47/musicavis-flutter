import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart' as graphic;

class PracticeTimeChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final ThemeData themeData;

  const PracticeTimeChart(this.data, this.themeData, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final header1Color = themeData.textTheme.headline1.color;
    final bodyText1Color = themeData.textTheme.bodyText1.color;
    final x = data[0].keys.first;
    final y = data[0].keys.last;

    final xTickCount = data.length > 31 ? data.length ~/ 2 : data.length;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          key: UniqueKey(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.4,
              child: graphic.Chart(
                data: data,
                padding: const EdgeInsets.only(
                    bottom: 33, left: 35, top: 5, right: 10),
                scales: {
                  x: graphic.CatScale(
                    accessor: (map) => map[x] as String,
                    range: [0, 2.5],
                    tickCount: xTickCount,
                  ),
                  y: graphic.LinearScale(
                    accessor: (map) => map[y] as num,
                    nice: true,
                    min: 0,
                    max: data.map((e) => e[y] as int).reduce(max),
                    formatter: (num) => '${num.toInt()}m',
                  )
                },
                geoms: [
                  graphic.AreaGeom(
                    position: graphic.PositionAttr(field: '$x*$y'),
                    shape: graphic.ShapeAttr(
                      values: [graphic.BasicAreaShape(smooth: true)],
                    ),
                    color: graphic.ColorAttr(values: [
                      themeData.accentColor.withOpacity(0.33),
                    ]),
                  ),
                  graphic.LineGeom(
                    position: graphic.PositionAttr(field: '$x*$y'),
                    shape: graphic.ShapeAttr(
                      values: [graphic.BasicLineShape(smooth: true)],
                    ),
                    color: graphic.ColorAttr(
                      values: [themeData.textTheme.headline1.color],
                    ),
                    size: graphic.SizeAttr(values: [1.2]),
                  ),
                ],
                axes: {
                  x: graphic.Axis(
                    position: 0,
                    line: graphic.AxisLine(
                      style: graphic.LineStyle(
                        color: header1Color,
                      ),
                    ),
                    label: graphic.AxisLabel(
                      offset: Offset(0, 10),
                      rotation: -45,
                      style: TextStyle(
                        fontSize: 10,
                        color: bodyText1Color.withOpacity(0.9),
                      ),
                    ),
                    grid: graphic.AxisGrid(
                      style: graphic.LineStyle(
                        color: bodyText1Color.withOpacity(0.05),
                        strokeWidth: 0.8,
                      ),
                    ),
                  ),
                  y: graphic.Axis(
                    position: 0,
                    label: graphic.AxisLabel(
                      offset: Offset(-10, 0),
                      style: TextStyle(
                        fontSize: 10,
                        color: bodyText1Color.withOpacity(0.9),
                      ),
                    ),
                    grid: graphic.AxisGrid(
                      style: graphic.LineStyle(
                        color: bodyText1Color.withOpacity(0.1),
                        strokeWidth: 0.8,
                      ),
                    ),
                  ),
                },
                interactions: [
                  graphic.Defaults.xPaning,
                  graphic.Defaults.xScaling,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GraphTitle extends StatelessWidget {
  final String title;
  final Color textColor;

  const GraphTitle(this.title, this.textColor, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(title, style: TextStyle(color: textColor)),
    );
  }
}
