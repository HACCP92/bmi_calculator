import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double weight;
  final double bcs;

  const ResultScreen({
    Key? key,
    required this.weight,
    required this.bcs,
  }) : super(key: key);

  double _calcIbw() {
    return weight * 100 / (100 + (bcs - 5) * 10);
  }

  @override
  Widget build(BuildContext context) {
    final ibw = _calcIbw();

    return Scaffold(
      appBar: AppBar(
        title: const Text('결과'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '현재 체중: $weight kg',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '이상 체중: ${ibw.toStringAsFixed(2)} kg',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
