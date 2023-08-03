import 'dart:async';
import 'package:bmi_calculator/presentation/result/result_screen.dart';
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
  @override
  void initState() {
    super.initState();
    // 5초 뒤에 결과 화면으로 이동
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoadingScreen(
            weight: 0,
            bcs: 0,
          ), // ResultScreen으로 이동할 때 필요에 따라 맞게 수정
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
        ), // Lottie 애니메이션 파일 경로에 맞게 수정
      ),
    );
  }
}
