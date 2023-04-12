import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
              child: SfCircularChart(
                  title: ChartTitle(
                      text: 'Total budget: ' +
                          maxAmount.toStringAsFixed(2) +
                          '\nCurrent status: ' +
                          sum.toStringAsFixed(2) +
                          '/' +
                          maxAmount.toStringAsFixed(2),
                      textStyle: const TextStyle(fontStyle: FontStyle.italic)),
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
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Center(
                  child: Text(
                    'You are over budget!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 21),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Image.asset('images/over.png'),
                ),
                Text(
                  'Current status: ${sum.toStringAsFixed(2)}/$maxAmount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
    );
  }
}
