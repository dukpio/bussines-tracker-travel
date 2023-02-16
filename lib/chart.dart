import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import './main.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class Chart extends StatelessWidget {
  final double sum;
  final double maxAmount;

  Chart(this.sum, this.maxAmount);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Amount used', sum),
      ChartData('Amount to be used', maxAmount - sum),
    ];
    return SizedBox(
        width: 325,
        height: 115,
        child: sum < maxAmount
            ? Container(
                alignment: Alignment.center,
                child: Expanded(
                  child: SfCircularChart(
                      title: ChartTitle(
                          text: 'Total budget:' +
                              maxAmount.toString() +
                              '\nCurrent status: ' +
                              sum.toStringAsFixed(2) +
                              '/' +
                              maxAmount.toStringAsFixed(2),
                          textStyle: TextStyle(fontStyle: FontStyle.italic)),
                      series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                            onPointTap: (ChartPointDetails details) {},
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            explode: true,
                            explodeIndex: 1,
                            radius: '85%')
                      ]),
                ),
              )
            : Card(
                color: Colors.amber,
                elevation: 10,
                child: Center(
                  child: Text(
                    'You are over budget!\nCurrent status: ' +
                        sum.toStringAsFixed(2) +
                        '/' +
                        maxAmount.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ));
  }
}
