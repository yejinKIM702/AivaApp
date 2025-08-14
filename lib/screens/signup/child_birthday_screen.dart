import 'package:flutter/material.dart';

class ChildBirthdayScreen extends StatefulWidget {
  const ChildBirthdayScreen({Key? key}) : super(key: key);

  @override
  _ChildBirthdayScreenState createState() => _ChildBirthdayScreenState();
}

class _ChildBirthdayScreenState extends State<ChildBirthdayScreen> {
  DateTime? _birthday;
  bool _unknown = false;
  final TextEditingController _dateController = TextEditingController();

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 10),
      lastDate: now,
      locale: const Locale('ko', 'KR'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.amber,
                ),
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      setState(() {
        _birthday = date;
        _dateController.text = '${date.year}년 ${date.month}월 ${date.day}일';
        _unknown = false; // 날짜가 선택되면 "아직 몰라요" 체크 해제
      });

      // 선택 완료 피드백
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('선택된 날짜: ${date.year}년 ${date.month}월 ${date.day}일'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _onNext() {
    Navigator.pushNamed(context, '/childGender');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('자녀 정보 입력')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '자녀의 생일은 언제인가요? *',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _unknown ? null : _pickDate,
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: _unknown ? '선택 불가' : '자녀의 생일을 선택해주세요',
                    hintText: _birthday == null ? '날짜를 선택해주세요' : '',
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: _unknown ? Colors.grey : Colors.amber,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: _birthday != null ? Colors.amber : Colors.grey,
                        width: _birthday != null ? 2 : 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: _birthday != null ? Colors.amber : Colors.grey,
                        width: _birthday != null ? 2 : 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.amber,
                        width: 2,
                      ),
                    ),
                    filled: _birthday != null,
                    fillColor: _birthday != null ? Colors.amber.shade50 : null,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  readOnly: true,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        _birthday != null ? FontWeight.w600 : FontWeight.normal,
                    color: _birthday != null ? Colors.black87 : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('아직 몰라요'),
              value: _unknown,
              onChanged: (v) {
                setState(() {
                  _unknown = v!;
                  if (_unknown) {
                    _birthday = null;
                    _dateController.clear();
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Spacer(),
            _StepIndicator(currentStep: 1),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: (_birthday != null || _unknown) ? _onNext : null,
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
