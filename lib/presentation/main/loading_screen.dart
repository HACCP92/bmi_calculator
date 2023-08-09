import 'dart:async';
import 'package:Dog_IBW_Calulator/presentation/result/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  final double weight;
  final double bcs;

  const LoadingScreen({
    Key? key,
    required this.weight,
    required this.bcs,
  }) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _calcIbw() {
    return widget.weight * 100 / (100 + (widget.bcs - 5) * 10);
  }

  @override
  void initState() {
    super.initState();
    // 2초 뒤에 결과 화면으로 이동합니다.
    Timer(const Duration(seconds: 2), () {
      final double ibw = _calcIbw();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            weight: widget.weight,
            bcs: widget.bcs,
            ibw: ibw,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lottie/animation_lkuuqz8b.json',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
