import 'package:bmi_calculator/presentation/main/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _bcsController = TextEditingController();
  String? _bcsErrorText;

  @override
  void initState() {
    super.initState();
    load();
    _resetFields(); // 앱이 시작될 때마다 값 초기화
  }

  @override
  void dispose() {
    _weightController.dispose();
    _bcsController.dispose();
    super.dispose();
  }

  Future save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('weight', double.parse(_weightController.text));
    await prefs.setDouble('bcs', double.parse(_bcsController.text));
  }

  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    final double? weight = prefs.getDouble('weight');
    final double? bcs = prefs.getDouble('bcs');

    setState(() {
      _weightController.text = weight?.toStringAsFixed(0) ?? ''; // 정수 형식으로 초기화
      _bcsController.text = bcs?.toStringAsFixed(0) ?? ''; // 정수 형식으로 초기화
      _bcsErrorText = null; // 에러 메시지 초기화
    });
  }

  String? _validateBcs(String? value) {
    if (value == null || value.isEmpty) {
      return 'BCS 점수를 입력하세요';
    }

    final bcs = int.tryParse(value);
    if (bcs == null || bcs < 1 || bcs > 9) {
      return 'BCS 점수는 1부터 9까지 입력 가능합니다';
    }

    return null; // 유효성 검사 통과
  }

  Future<void> _resetFields() async {
    setState(() {
      _weightController.text = ''; // 현재 체중 입력 초기화
      _bcsController.text = ''; // BCS 점수 입력 초기화
      _bcsErrorText = null; // 에러 메시지 초기화
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('weight'); // 기존에 저장된 체중 데이터 삭제
    await prefs.remove('bcs'); // 기존에 저장된 BCS 점수 데이터 삭제

    final double? weight = prefs.getDouble('weight');
    final double? bcs = prefs.getDouble('bcs');

    setState(() {
      _weightController.text = weight?.toStringAsFixed(0) ?? ''; // 정수 형식으로 초기화
      _bcsController.text = bcs?.toStringAsFixed(0) ?? ''; // 정수 형식으로 초기화
      _bcsErrorText = null; // 에러 메시지 초기화
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: 380.0,
              child: Image.asset(
                'assets/dog_head.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 60),
                  TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '현재 체중 kg',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '현재 체중을 입력하세요';
                      }
                      final weight = int.tryParse(value);
                      if (weight == null || weight < 1 || weight > 99) {
                        return '현재 체중은 1부터 99까지 입력 가능합니다';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _bcsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'BCS 점수',
                    ),
                    keyboardType: TextInputType.number,
                    validator: _validateBcs,
                    autovalidateMode:
                        _bcsErrorText != null // 에러 메시지가 있을 때만 자동 유효성 검사 활성화
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                    onChanged: (value) {
                      setState(() {
                        _bcsErrorText = null; // 입력이 변경되면 에러 메시지 초기화
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  width: 800, // 원하는 넓이로 변경
                                  height: 600, // 원하는 높이로 변경
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'BCS 점수 측정법',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'bcs 점수 사진과 텍스트를 넣을 예정입니ㅇㅇㅇㅇㅇ다.',
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('닫기'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('BCS 점수 측정법'),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed:
                                _resetFields, // _resetFields() 메서드를 호출하도록 변경
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.restore),
                                onPressed: _resetFields,
                                iconSize: 24,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() == false) {
                                setState(() {
                                  _bcsErrorText = 'BCS 점수를 입력하세요';
                                });
                                return;
                              }
                              save();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoadingScreen(
                                    weight:
                                        double.parse(_weightController.text),
                                    bcs: double.parse(_bcsController.text),
                                  ),
                                ),
                              );
                            },
                            child: const Hero(
                              tag: 'result_button_tag',
                              child: Text('결과'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
