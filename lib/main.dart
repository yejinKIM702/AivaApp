import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/community_screen.dart';
import 'screens/my_page_screen.dart';
import 'screens/signup/birth_status_screen.dart';
import 'screens/signup/child_birthday_screen.dart';
import 'screens/signup/expected_birth_screen.dart';
import 'screens/signup/child_gender_screen.dart';
import 'screens/signup/child_health_screen.dart';

// ================= Main Entry =================
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aiva App',
      debugShowCheckedModeBanner: false, // Debug 배너 제거
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        primaryColor: const Color(0xFFFFD24C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD24C),
          primary: const Color(0xFFFFD24C),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFD24C),
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFD24C),
          foregroundColor: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFFFD24C),
        ),
      ),
      locale: const Locale('ko', 'KR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/welcome': (_) => const WelcomeScreen(),
        '/home': (_) => const HomeScreen(),
        '/community': (_) => const CommunityScreen(),
        '/mypage': (_) => const MyPageScreen(),
        '/birthStatus': (_) => const BirthStatusScreen(),
        '/childBirthday': (_) => const ChildBirthdayScreen(),
        '/expectedBirth': (_) => const ExpectedBirthScreen(),
        '/childGender': (_) => const ChildGenderScreen(),
        '/childHealth': (_) => const ChildHealthScreen(),
      },
    );
  }
}
