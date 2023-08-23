import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const _MyAppState(),
    );
  }
}

class _MyAppState extends StatefulWidget {
  const _MyAppState({Key? key}) : super(key: key);

  @override
  State<_MyAppState> createState() => _MyAppStateState();
}

class _MyAppStateState extends State<_MyAppState> {
  bool _isLoading = true;
  late BannerAd _bannerAd;
  bool _adLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_adLoaded) {
      _loadAd();
      _adLoaded = true;
    }
  }

  Map<String, String> UNIT_ID = kReleaseMode
      ? {
          'ios': '[YOUR iOS AD UNIT ID]',
          'android': '[YOUR ANDROID AD UNIT ID]',
        }
      : {
          'ios': 'ca-app-pub-3940256099942544/2934735716',
          'android': 'ca-app-pub-3940256099942544/6300978111',
        };

  void _loadAd() {
    TargetPlatform os = Theme.of(context).platform;

    _bannerAd = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
        },
        onAdLoaded: (Ad ad) {
          print('Ad loaded: $ad');
        },
      ),
      size: AdSize.banner,
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      request: const AdRequest(),
    );

    _bannerAd.load();
  }

  void _loadData() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return _isLoading
        ? Scaffold(
            body: Center(
              child: Lottie.asset(
                'assets/lottie/animation_lkuuqz8b.json',
                width: 200,
                height: 200,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Admob'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: const MainScreen(),
                  ),
                  Container(
                    height: 50,
                    child: AdWidget(ad: _bannerAd),
                  ),
                ],
              ),
            ),
          );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Main Screen Content"),
    );
  }
}
