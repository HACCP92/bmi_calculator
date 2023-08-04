import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double weight;
  final double bcs;

  const ResultScreen({
    Key? key,
    required this.weight,
    required this.bcs,
    required ibw,
  }) : super(key: key);

  double _calcIbw() {
    return weight * 100 / (100 + (bcs - 5) * 10);
  }

  Image _buildImage(double ibw) {
    if (ibw > weight) {
      return Image.asset(
        'assets/dog_image1.png', //
        width: 200,
        height: 200,
      );
    } else if (ibw == weight) {
      return Image.asset(
        'assets/dog_image2.png',
        width: 200,
        height: 200,
      );
    } else {
      return Image.asset(
        'assets/dog_image3.png',
        width: 200,
        height: 200,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ibw = _calcIbw();
    final imageWidget = _buildImage(ibw);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: 380.0,
              child: Image.asset(
                'assets/dog_head.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100), // 추가된 부분, AppBar 높이만큼 여백 추가
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '현재 체중 : $weight kg',
                      style: const TextStyle(fontSize: 25),
                    ),
                    const SizedBox(width: 16), // 현재 체중과 표준 체중 사이 간격
                    Text(
                      '표준 체중 : ${ibw.toStringAsFixed(1)} kg',
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // 이미지와 텍스트 사이 여백 조절
                imageWidget,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
