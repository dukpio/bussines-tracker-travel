import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final double sum;

  Chart(this.sum);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      height: 115,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Text('Current sum: ' + sum.toStringAsFixed(2)),
            SizedBox(
                width: 55,
                height: 55,
                child: Image.asset('images/random.png', fit: BoxFit.cover)),
          ],
        ),
      ),
    );
  }
}
