import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class Chart extends StatelessWidget {
  final double sum;

  Chart(this.sum);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Amount used', sum),
      ChartData('Amount to be used', 500 - sum),
    ];
    return SizedBox(
        width: 325,
        height: 115,
        child: sum < 500
            ? Column(
                children: [
                  // Text(
                  //   'Project bugdget: 500',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  Expanded(
                    child: SfCircularChart(
                        title: ChartTitle(
                            text: 'Total budget: 500 \nCurrent status: ' +
                                sum.toStringAsFixed(2) +
                                '/500',
                            textStyle: TextStyle(fontStyle: FontStyle.italic)),
                        series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              explode: true,
                              explodeIndex: 1,
                              radius: '85%')
                        ]),
                  )
                ],
              )
            : Card(
                color: Colors.amber,
                elevation: 10,
                child: Center(
                  child: Text(
                    'You are over budget!\nCurrent status: ' +
                        sum.toStringAsFixed(2) +
                        '/500',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ));
  }
}
