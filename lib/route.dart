import 'package:go_router/go_router.dart';

import 'main/main_screen.dart';
import 'result/result_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
        path: '/main/result',
        builder: (context, state) {
          double height = double.parse(state.queryParameters['height']!);
          double weight = double.parse(state.queryParameters['weight']!);
          return ResultScreen(height: height, weight: weight);
        })
  ],
);
