import 'package:bmi_calculator/presentation/main/main_screen.dart';
import 'package:bmi_calculator/presentation/result/result_screen.dart';
import 'package:go_router/go_router.dart';

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
          return ResultScreen(weight: weight, bcs: bcs);
        })
  ],
);