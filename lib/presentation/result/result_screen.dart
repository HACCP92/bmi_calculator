import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ResultScreen extends StatelessWidget {
  final double weight;
  final double bcs;

  const ResultScreen({
    Key? key,
    required this.weight,
    required this.bcs,
    required double ibw,
  }) : super(key: key);

  double _calcIbw() {
    return weight * 100 / (100 + (bcs - 5) * 10);
  }

  Image _buildImage(double ibw) {
    if (ibw > weight) {
      return Image.asset(
        'assets/dog_image1.png',
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

  String _getWeightStatus(double ibw) {
    if (weight < ibw) {
      return '저체중';
    } else if (weight == ibw) {
      return '정상체중';
    } else {
      return '과체중';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ibw = _calcIbw();
    final imageWidget = _buildImage(ibw);
    final weightStatus = _getWeightStatus(ibw);

    // 광고 로딩 및 배너 광고 객체 생성
    BannerAd _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-1136520834945848~2460543854', // 광고 단위 아이디 설정
      size: AdSize.banner,
      request: const AdRequest(), // 광고 요청 설정
      listener: const BannerAdListener(), // 광고 리스너 설정
    );

    // 광고 로드
    _bannerAd.load();

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
                const SizedBox(height: 200),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '체중 상태 : $weightStatus',
                      style: const TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '현재 체중 : $weight kg',
                      style: const TextStyle(fontSize: 25),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '표준 체중 : ${ibw.toStringAsFixed(1)} kg',
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                imageWidget,
                Container(
                  width: 100,
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.home),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: AdWidget(ad: _bannerAd),
      ),
    );
  }
}
