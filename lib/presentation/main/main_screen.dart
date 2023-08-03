import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bmi_calculator/presentation/result/result_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _bcsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    load();
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

    if (weight != null && bcs != null) {
      _weightController.text = '$weight';
      _bcsController.text = '$bcs';
    }
  }

  String? _bcsErrorText;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('강아지 표준 체중 계산'),
        backgroundColor: Colors.amber.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
                return null;
              },
            ),
            const SizedBox(height: 10),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('BCS 점수 측정법'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == false) {
                      setState(() {
                        _bcsErrorText = 'BCS 점수를 입력하세요'; // 유효성 검사 에러 메시지 수동 추가
                      });
                      return;
                    }
                    save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          weight: double.parse(_weightController.text),
                          bcs: double.parse(_bcsController.text),
                        ),
                      ),
                    );
                  },
                  child: const Hero(
                    tag: 'result_button_tag', // 히어로 애니메이션을 위한 고유 태그를 제공합니다.
                    child: Text('결과'),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
