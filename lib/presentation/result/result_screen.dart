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

  Icon _buildIcon(double ibw) {
    if (ibw > weight) {
      return const Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.yellow,
        size: 100,
      );
    } else if (ibw == weight) {
      return const Icon(
        Icons.sentiment_satisfied_rounded,
        color: Colors.blue,
        size: 100,
      );
    } else {
      return const Icon(
        Icons.sentiment_dissatisfied_sharp,
        color: Colors.red,
        size: 100,
      );
    }
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
              '표준 체중: ${ibw.toStringAsFixed(2)} kg',
              style: const TextStyle(fontSize: 20),
            ),
            _buildIcon(ibw), // 아이콘 추가
          ],
        ),
      ),
    );
  }
}
