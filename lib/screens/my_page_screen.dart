import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import 'profile_management_screen.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text('마이페이지'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Profile header
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 32,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '이유식천재',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'aiva123@gmail.com',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Menu list
            Expanded(
              child: ListView(
                children: [
                  _MenuButton(
                    icon: Icons.person,
                    label: '내 정보 & 자녀 정보 관리',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileManagementScreen(),
                        ),
                      );
                    },
                  ),
                  _MenuButton(
                    icon: Icons.bookmark_border,
                    label: '채팅 북마크',
                    onTap: () {
                      // TODO: Navigate to chat bookmarks
                    },
                  ),
                  _ToggleMenu(
                    icon: Icons.notifications_none,
                    label: '알림 받기',
                    initialValue: true,
                    onChanged: (val) {
                      // TODO: Handle notification toggle
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to subscription page
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        backgroundColor: const Color(0xFFFFE600),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text('유료 플랜으로 이용하기'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _MenuButton(
                    icon: Icons.logout,
                    label: '로그아웃',
                    labelColor: Colors.red,
                    onTap: () {
                      // TODO: Handle logout
                    },
                  ),
                  _MenuButton(
                    icon: Icons.person_remove_outlined,
                    label: '회원탈퇴',
                    enabled: false,
                    onTap: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(currentIndex: 2),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? labelColor;
  final bool enabled;

  const _MenuButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.labelColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      leading: Icon(icon, color: labelColor ?? Colors.black),
      title: Text(label, style: TextStyle(color: labelColor)),
      trailing: enabled ? const Icon(Icons.arrow_forward_ios, size: 16) : null,
      onTap: enabled ? onTap : null,
    );
  }
}

class _ToggleMenu extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const _ToggleMenu({
    required this.icon,
    required this.label,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _ToggleMenuState createState() => _ToggleMenuState();
}

class _ToggleMenuState extends State<_ToggleMenu> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _value,
      onChanged: (v) {
        setState(() => _value = v);
        widget.onChanged(v);
      },
      title: Text(widget.label),
      secondary: Icon(widget.icon),
      activeColor: const Color(0xFFFFE600),
    );
  }
}
