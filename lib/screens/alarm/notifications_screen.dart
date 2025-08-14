import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  static const String kdcaUrl =
      'https://nip.kdca.go.kr/irhp/mngm/goVcntMngm.do?menuLv=3&menuCd=313';

  void _markAllRead() {
    // TODO: mark all notifications as read in backend or state
  }

  void _close(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _openWebView(BuildContext context) async {
    // TODO: implement web view functionality
    // For now, just show a dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('웹뷰'),
        content: const Text('KDCA 웹사이트가 열립니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          title: const Text('내 알림'),
          centerTitle: true,
          elevation: 1,
          leading: TextButton(
            onPressed: () => _close(context),
            child: const Text('닫기', style: TextStyle(color: Colors.black)),
          ),
          actions: [
            TextButton(
              onPressed: _markAllRead,
              child:
                  const Text('모두 읽음', style: TextStyle(color: Colors.yellow)),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.yellow,
            tabs: [
              Tab(text: '모든 알림'),
              Tab(text: '커뮤니티 알림'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _NotificationsList(
              items: [
                NotificationItemData(
                  title: '여름철 중요 예방접종 알림이 있습니다. 🏥',
                  timeAgo: '2분 전',
                  hasAction: true,
                  actionLabel: '확인하러 가기',
                  actionCallback: _openWebView,
                ),
                NotificationItemData(
                  title: '생후 6개월 우리 아이, B형간염 예방접종이 필요해요',
                  timeAgo: '8시간 전',
                  actionLabel: '자세한 사항 확인하고 접종 예약하러 가기',
                  actionCallback: null,
                ),
                NotificationItemData(
                  title: '우리 아이 장 건강 어떻게 지키지? 🤔',
                  timeAgo: '14시간 전',
                  actionLabel: '안내문 확인하러 가기',
                  actionCallback: null,
                ),
                NotificationItemData(
                  title: '우리 아기, 백신 두 번째 라운드 시작! 💉',
                  timeAgo: '14시간 전',
                  actionLabel: '올해 2차 예방접종 시기 여기서 확인하세요!',
                  actionCallback: null,
                ),
              ],
            ),
            // For community notifications, filter items accordingly
            _NotificationsList(
              items: const [], // TODO: populate community notifications
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItemData {
  final String title;
  final String timeAgo;
  final bool hasAction;
  final String? actionLabel;
  final Future<void> Function(BuildContext)? actionCallback;

  const NotificationItemData({
    required this.title,
    required this.timeAgo,
    this.hasAction = false,
    this.actionLabel,
    this.actionCallback,
  });
}

class _NotificationsList extends StatelessWidget {
  final List<NotificationItemData> items;
  const _NotificationsList({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          color: item.hasAction
              ? const Color(0xFFFFD24C).withOpacity(0.1)
              : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text(item.timeAgo,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                if (item.hasAction && item.actionLabel != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      onPressed: item.actionCallback != null
                          ? () => item.actionCallback!(context)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD24C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      child: Text(item.actionLabel!),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
