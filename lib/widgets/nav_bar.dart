import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  const NavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFFFFFFF),
      selectedItemColor: const Color(0xFFFFD24C),
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), label: '채팅'),
        BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined), label: '커뮤니티'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: '마이페이지'),
      ],
      onTap: (i) {
        // TODO: navigate to other tabs
        if (i == 0) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (i == 1) {
          Navigator.pushReplacementNamed(context, '/community');
        } else if (i == 2) {
          Navigator.pushReplacementNamed(context, '/mypage');
        }
      },
    );
  }
}
