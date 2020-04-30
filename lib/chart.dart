import 'package:coronavirus/reportModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  final Report report;
  PieChartSample2(this.report);
  @override
  State<StatefulWidget> createState() => PieChart2State(report);
}

class PieChart2State extends State {
  int touchedIndex;
  Report _report;
  PercentageCalc perc;
  PieChart2State(this._report);

  @override
  void initState() {
    super.initState();
    perc = new PercentageCalc(_report);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 0.0,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: PieChart(
                    PieChartData(
                        pieTouchData:
                            PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex =
                                  pieTouchResponse.touchedSectionIndex;
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 50,
                        sections: showingSections(_report)),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Indicator(
                      color: Colors.blue[900],
                      text: 'Confirmed',
                      isSquare: false,
                      percentage: perc.confirmedPerc,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.blue[400],
                      text: 'Recovered',
                      isSquare: false,
                      percentage: perc.recoveredPerc,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.red[400],
                      text: 'Death',
                      isSquare: false,
                      percentage: perc.deathPerc,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(Report report) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red[400],
            value: report.deaths + 0.0,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue[900],
            value: report.confirmed + 0.0,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue[400],
            value: report.recovered + 0.0,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}

class PercentageCalc {
  Report report;
  double deathPerc, recoveredPerc, confirmedPerc;

  PercentageCalc(Report _report) {
    this.report = _report;
    deathPerc = (report.deaths / report.totalCases) * 100;
    recoveredPerc = (report.recovered / report.totalCases) * 100;
    confirmedPerc = (report.confirmed / report.totalCases) * 100;
  }
}
