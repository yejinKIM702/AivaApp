import 'package:flutter/material.dart';

// ================= Welcome / Login Screen =================
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO: 로고 이미지 요청
              Image.asset('assets/images/aiva_logo.png',
                  width: 120, height: 120),
              const SizedBox(height: 16),
              const Text(
                '당신의 AI 육아비서',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Text(
                '아이바 Aiva',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                icon: Image.asset('assets/icons/google.png',
                    width: 24, height: 24),
                label: const Text('구글 계정으로 사용하기'),
                onPressed: () {
                  // TODO: Google SSO 처리
                  Navigator.of(context).pushReplacementNamed('/home');
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: const Color(0xFFFFE600),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                icon: Image.asset('assets/icons/kakao.png',
                    width: 24, height: 24),
                label: const Text('카카오 계정으로 사용하기'),
                onPressed: () {
                  // TODO: Kakao SSO 처리
                  Navigator.of(context).pushReplacementNamed('/home');
                },
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/birthStatus');
                },
                child: const Text(
                  '계정이 없으신가요? 회원가입',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
