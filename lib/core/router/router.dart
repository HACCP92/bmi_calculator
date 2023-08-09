import 'package:Dog_IBW_Calulator/presentation/main/loading_screen.dart';
import 'package:Dog_IBW_Calulator/presentation/main/main_screen.dart';
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
          return LoadingScreen(
            weight: weight,
            bcs: bcs,
          );
        })
  ],
);
