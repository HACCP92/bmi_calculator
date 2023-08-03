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

  double _calcIbw() {
    double weight = double.parse(_weightController.text);
    double bcs = double.parse(_bcsController.text);
    return weight * 100 / (100 + (bcs - 5) * 10);
  }

  Icon _buildIcon(double ibw) {
    if (ibw >= 23) {
      return const Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.cyanAccent,
        size: 100,
      );
    } else if (ibw >= 18.5) {
      return const Icon(
        Icons.sentiment_satisfied,
        color: Colors.cyanAccent,
        size: 100,
      );
    } else {
      return const Icon(
        Icons.sentiment_satisfied_rounded,
        color: Colors.cyanAccent,
        size: 100,
      );
    }
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'BCS 점수를 입력하세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == false) {
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
                child: const Text('결과'),
              ),
              Text(
                '현재 체중: ${_weightController.text} kg',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                '이상 체중: ${_calcIbw().toStringAsFixed(2)} kg',
                style: const TextStyle(fontSize: 20),
              ),
              _buildIcon(_calcIbw()),
            ],
          ),
        ),
      ),
    );
  }
}
