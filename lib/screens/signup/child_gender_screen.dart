import 'package:flutter/material.dart';

class ChildGenderScreen extends StatefulWidget {
  const ChildGenderScreen({Key? key}) : super(key: key);

  @override
  _ChildGenderScreenState createState() => _ChildGenderScreenState();
}

class _ChildGenderScreenState extends State<ChildGenderScreen> {
  String? _gender; // 'male','female','unknown'

  void _onNext() {
    Navigator.pushNamed(context, '/childHealth');
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
              '자녀의 성별은 무엇인가요? *',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            RadioListTile<String>(
              title: const Text('남자'),
              value: 'male',
              groupValue: _gender,
              onChanged: (v) => setState(() => _gender = v),
            ),
            RadioListTile<String>(
              title: const Text('여자'),
              value: 'female',
              groupValue: _gender,
              onChanged: (v) => setState(() => _gender = v),
            ),
            RadioListTile<String>(
              title: const Text('아직 몰라요'),
              value: 'unknown',
              groupValue: _gender,
              onChanged: (v) => setState(() => _gender = v),
            ),
            const Spacer(),
            _StepIndicator(currentStep: 2),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _gender == null ? null : _onNext,
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
