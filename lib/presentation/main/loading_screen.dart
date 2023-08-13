import 'dart:async';
import 'package:dog_ibw_calulator/presentation/result/result_screen.dart';
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

  bool animationStarted = false; //

  @override
  void initState() {
    super.initState();
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

    // 추가: 0.5초 뒤에 애니메이션 시작
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        animationStarted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: AnimatedOpacity(
            // 추가: 애니메이션 시작 여부에 따라 Opacity를 조정하여 나타나게 함
            opacity: animationStarted ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 1000),
            child: Lottie.asset(
              'assets/lottie/animation_lkuuqz8b.json',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
