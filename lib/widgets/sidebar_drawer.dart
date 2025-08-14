import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy user info; replace with real user data
    const String userName = '이유식천재';
    const String userEmail = 'aiva123@gmail.com';

    // Chat summary items; replace with dynamic data
    final List<String> summaries = [
      '분리불안 여부 확인',
      '벌레에게 물린 상처 심각성',
      '이유식 거부 반응',
      '황달 재발 가능성',
    ];

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with user info
            UserAccountsDrawerHeader(
              accountName: const Text(userName),
              accountEmail: const Text(userEmail),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
              ),
            ),
            // New Chat
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('새로운 채팅'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/newChat');
              },
            ),
            // Chat Search
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('채팅 검색'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/searchChat');
              },
            ),
            const Divider(),
            // Chat Summary Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '채팅 기록 요약',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: summaries.length,
                itemBuilder: (context, index) {
                  final title = summaries[index];
                  return ListTile(
                    title: Text(title),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to summary detail page
                      Navigator.pushNamed(
                        context,
                        '/chatSummaryDetail',
                        arguments: title,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
