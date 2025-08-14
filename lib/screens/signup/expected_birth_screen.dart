import 'package:flutter/material.dart';

class ExpectedBirthScreen extends StatefulWidget {
  const ExpectedBirthScreen({Key? key}) : super(key: key);

  @override
  _ExpectedBirthScreenState createState() => _ExpectedBirthScreenState();
}

class _ExpectedBirthScreenState extends State<ExpectedBirthScreen> {
  DateTime? _dueDate;
  bool _unknown = false;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date != null) setState(() => _dueDate = date);
  }

  void _onNext() {
    Navigator.pushNamed(context, '/childGender');
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
              '출생 예정일을 선택해주세요 *',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _unknown ? null : _pickDate,
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: _unknown ? '선택 불가' : '출생 예정일을 선택해주세요',
                    hintText: _dueDate == null
                        ? ''
                        : '${_dueDate!.year}-${_dueDate!.month.toString().padLeft(2, '0')}-${_dueDate!.day.toString().padLeft(2, '0')}',
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('아직 몰라요'),
              value: _unknown,
              onChanged: (v) => setState(() => _unknown = v!),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Spacer(),
            _StepIndicator(currentStep: 1),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: (_dueDate != null || _unknown) ? _onNext : null,
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
