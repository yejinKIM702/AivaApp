import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../widgets/sidebar_drawer.dart';
import 'alarm/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isTyping = false;
  bool _isGenerating = false;
  bool _isRecording = false;
  bool _showFAQ = true; // 추가: FAQ 표시 여부

  void _onSend() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _inputController.clear();
      _isGenerating = true;
      _showFAQ = false; // 추가: 질문 입력 후 FAQ 숨김
    });
    // TODO: Call AI service here, stream response
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _messages
            .add(ChatMessage(text: 'AI response to "$text"', isUser: false));
        _isGenerating = false;
      });
    });
  }

  void _onStop() {
    // TODO: Stop streaming AI response
    setState(() => _isGenerating = false);
  }

  void _onVoiceRecord() {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      // TODO: Start voice recording
      _showRecordingDialog();
    } else {
      // TODO: Stop voice recording and process
      _processVoiceInput();
    }
  }

  void _showRecordingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('음성 녹음 중'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.mic,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text('마이크에 말씀해주세요...'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => _isRecording = false);
                _processVoiceInput();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('녹음 완료'),
            ),
          ],
        ),
      ),
    );
  }

  void _processVoiceInput() {
    // TODO: Process voice input and convert to text
    // For now, simulate voice input with a sample text
    const sampleVoiceText = "우리 아이가 이유식을 거부해요";
    setState(() {
      _inputController.text = sampleVoiceText;
      _isTyping = true;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('음성이 텍스트로 변환되었습니다.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text('아이바 (Aiva)'),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsScreen()),
                  );
                },
              ),
              // TODO: Show red dot if unread notifications
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Aiva Logo and Character
          if (_showFAQ) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/aiva_logo.png',
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '자주 묻는 질문',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // FAQ vertical list
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(3, (i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Insert FAQ question
                        _inputController.text = 'FAQ question #$i';
                      },
                      child: Text('FAQ 질문 $i'),
                    ),
                  );
                }),
              ),
            ),
          ],
          const Divider(height: 1),
          // Chat list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              reverse: false,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: msg.isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!msg.isUser) ...[
                        // AI 아바타 또는 프로필 이미지 (선택사항)
                        Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.smart_toy,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ],
                      Flexible(
                        child: Column(
                          crossAxisAlignment: msg.isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            // 말풍선
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: msg.isUser
                                    ? const Color(0xFFFFD24C)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Text(
                                      msg.text,
                                      style: TextStyle(
                                        color: msg.isUser
                                            ? Colors.black87
                                            : Colors.black87,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  if (!msg.isUser && msg.isBookmarked)
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.bookmark,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            // 액션 버튼들 (AI 응답에만)
                            if (!msg.isUser) ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (!msg.feedbackGiven) ...[
                                    IconButton(
                                      icon: const Icon(
                                          Icons.thumb_up_alt_outlined),
                                      color: const Color(0xFFFFD24C),
                                      onPressed: () {
                                        setState(
                                            () => msg.feedbackGiven = true);
                                        // TODO: send feedback +
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.copy),
                                      color: const Color(0xFFFFD24C),
                                      onPressed: () {
                                        // TODO: copy to clipboard
                                      },
                                    ),
                                    PopupMenuButton<String>(
                                      tooltip: '더보기',
                                      offset: const Offset(0, 8),
                                      icon: const Icon(Icons.more_vert,
                                          color: Color(0xFFFFD24C)),
                                      onSelected: (value) {
                                        if (value == 'bookmark') {
                                          setState(() {
                                            msg.isBookmarked =
                                                !msg.isBookmarked;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(msg.isBookmarked
                                                  ? '북마크에 추가되었습니다.'
                                                  : '북마크에서 제거되었습니다.'),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );
                                        } else if (value == 'edit') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    '채팅 제목 수정 기능은 준비 중입니다.')),
                                          );
                                        } else if (value == 'delete') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('채팅 삭제 기능은 준비 중입니다.')),
                                          );
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'bookmark',
                                          child: Row(
                                            children: [
                                              Icon(
                                                msg.isBookmarked
                                                    ? Icons.bookmark
                                                    : Icons.bookmark_border,
                                                color: msg.isBookmarked
                                                    ? Colors.blue
                                                    : Colors.black,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                msg.isBookmarked
                                                    ? '북마크 해제'
                                                    : '북마크',
                                                style: TextStyle(
                                                  color: msg.isBookmarked
                                                      ? Colors.blue
                                                      : Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit,
                                                  size: 20,
                                                  color: Colors.black),
                                              SizedBox(width: 12),
                                              Text('채팅 제목 수정',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete,
                                                  size: 20, color: Colors.red),
                                              SizedBox(width: 12),
                                              Text('채팅 삭제',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ] else ...[
                                    IconButton(
                                      icon: const Icon(Icons.thumb_up_alt),
                                      color: const Color(0xFFFFD24C),
                                      onPressed: () {
                                        setState(
                                            () => msg.feedbackGiven = false);
                                        // TODO: send feedback -
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.copy),
                                      color: const Color(0xFFFFD24C),
                                      onPressed: () {
                                        // TODO: copy to clipboard
                                      },
                                    ),
                                    PopupMenuButton<String>(
                                      tooltip: '더보기',
                                      offset: const Offset(0, 8),
                                      icon: const Icon(Icons.more_vert,
                                          color: Color(0xFFFFD24C)),
                                      onSelected: (value) {
                                        if (value == 'bookmark') {
                                          setState(() {
                                            msg.isBookmarked =
                                                !msg.isBookmarked;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(msg.isBookmarked
                                                  ? '북마크에 추가되었습니다.'
                                                  : '북마크에서 제거되었습니다.'),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );
                                        } else if (value == 'edit') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    '채팅 제목 수정 기능은 준비 중입니다.')),
                                          );
                                        } else if (value == 'delete') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('채팅 삭제 기능은 준비 중입니다.')),
                                          );
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'bookmark',
                                          child: Row(
                                            children: [
                                              Icon(
                                                msg.isBookmarked
                                                    ? Icons.bookmark
                                                    : Icons.bookmark_border,
                                                color: msg.isBookmarked
                                                    ? Colors.blue
                                                    : Colors.black,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                msg.isBookmarked
                                                    ? '북마크 해제'
                                                    : '북마크',
                                                style: TextStyle(
                                                  color: msg.isBookmarked
                                                      ? Colors.blue
                                                      : Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit,
                                                  size: 20,
                                                  color: Colors.black),
                                              SizedBox(width: 12),
                                              Text('채팅 제목 수정',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete,
                                                  size: 20, color: Colors.red),
                                              SizedBox(width: 12),
                                              Text('채팅 삭제',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (msg.isUser) ...[
                        // 사용자 아바타 또는 프로필 이미지 (선택사항)
                        Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD24C),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          // Input area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    decoration: const InputDecoration(hintText: '아이바에게 물어보세요!'),
                    onChanged: (v) => setState(() => _isTyping = v.isNotEmpty),
                  ),
                ),
                if (_isGenerating)
                  IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: _onStop,
                  )
                else if (_isTyping)
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _onSend,
                  )
                else
                  IconButton(
                    icon: Icon(
                      _isRecording ? Icons.stop : Icons.mic,
                      color: _isRecording ? Colors.red : null,
                    ),
                    onPressed: _onVoiceRecord,
                  ),
              ],
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      bottomNavigationBar: const NavBar(currentIndex: 0),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  bool feedbackGiven = false;
  bool isBookmarked = false;

  ChatMessage({required this.text, this.isUser = false});
}
