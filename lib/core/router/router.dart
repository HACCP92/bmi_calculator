import 'package:dog_ibw_calulator/presentation/main/loading_screen.dart';
import 'package:dog_ibw_calulator/presentation/main/main_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

Future<InitializationStatus> _initGoogleMobileAds() {
  // TODO: Initialize Google Mobile Ads SDK
  return MobileAds.instance.initialize();
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
        path: '/main/result',
        builder: (context, state) {
          double weight = double.parse(state.queryParameters['weight']!);
          double bcs = double.parse(state.queryParameters['bcs']!);
          return LoadingScreen(
            weight: weight,
            bcs: bcs,
          );
        })
  ],
);
