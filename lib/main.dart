import 'package:dog_ibw_calulator/presentation/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData(); //
  }

  void _loadData() async {
    await Future.delayed(const Duration(seconds: 5)); //
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: _isLoading
          ? Scaffold(
              body: Center(
                child: Lottie.asset(
                  'assets/lottie/animation_lkuuqz8b.json',
                  width: 200,
                  height: 200,
                ),
              ),
            )
          : const MainScreen(),
    );
  }
}
