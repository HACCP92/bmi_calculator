import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'presentation/main/main_screen.dart';

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
    await Future.delayed(const Duration(seconds: 5)); // 2초간 로딩 시뮬레이션
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _isLoading
            ? Center(
                child: Lottie.asset(
                  'assets/lottie/animation_lkuuqz8b.json',
                  width: 200,
                  height: 200,
                ),
              )
            : Column(
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
