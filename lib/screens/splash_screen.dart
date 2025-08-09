import 'package:flutter/material.dart';

// ================= Splash Screen =================
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD24C),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFFD24C), // Updated to #FFD24C background
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로고 이미지
            Image.asset('assets/images/aiva_logo.png', width: 150, height: 150),
            const SizedBox(height: 16),
            // 앱 이름 이미지를 사용 (경로 폴백 포함)
            _buildNameImage(),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameImage() {
    // 1차: assets/images/
    return Image.asset(
      'assets/images/aiva_name_image.png',
      width: 200,
      height: 36,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // 2차 폴백: assets/image/
        return Image.asset(
          'assets/image/aiva_name_image.png',
          width: 200,
          height: 36,
          fit: BoxFit.contain,
        );
      },
    );
  }
}
