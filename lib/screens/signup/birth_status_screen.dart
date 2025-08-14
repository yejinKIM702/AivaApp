import 'package:flutter/material.dart';

class BirthStatusScreen extends StatefulWidget {
  const BirthStatusScreen({Key? key}) : super(key: key);

  @override
  _BirthStatusScreenState createState() => _BirthStatusScreenState();
}

class _BirthStatusScreenState extends State<BirthStatusScreen> {
  String? _status; // 'born' or 'pregnant'

  void _onNext() {
    if (_status == 'born') {
      Navigator.pushNamed(context, '/childBirthday');
    } else if (_status == 'pregnant') {
      Navigator.pushNamed(context, '/expectedBirth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text('자녀 정보 입력'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '아이바가 더 똑똑한 육아 비서가 될 수 있도록\n아래의 정보를 먼저 입력해주세요',
              style: TextStyle(color: Colors.amber, fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              '자녀가 출생하였나요? *',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            RadioListTile<String>(
              title: const Text('네, 태어났어요'),
              value: 'born',
              groupValue: _status,
              onChanged: (v) => setState(() => _status = v),
            ),
            RadioListTile<String>(
              title: const Text('임신중 또는 아직 아니요'),
              value: 'pregnant',
              groupValue: _status,
              onChanged: (v) => setState(() => _status = v),
            ),
            const Spacer(),
            _StepIndicator(currentStep: 0),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _status == null ? null : _onNext,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
              ),
              child: const Text('다음'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: i == currentStep ? Colors.amber : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
