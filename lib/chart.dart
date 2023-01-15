import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});
  final double currentSum = 75;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      height: 115,
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Text('Current sum: XXX'),
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
