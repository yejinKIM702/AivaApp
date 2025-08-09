import 'package:flutter/material.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _canUpload = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final length = _controller.text.characters.length;
      setState(() {
        _canUpload = length > 0 && length <= 1000;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  void _onUpload() {
    if (!_canUpload) return;
    // TODO: implement upload logic to back-end or state management
    Navigator.pop(context, _controller.text);
  }

  void _onAttachImage() {
    // TODO: open image picker
  }

  void _onAddContent() {
    // TODO: additional attachments (e.g. upload icon)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        centerTitle: true,
        title: const Text('아이바 (Aiva)'),
        leading: TextButton(
          onPressed: _onCancel,
          child: const Text('취소', style: TextStyle(color: Colors.black)),
        ),
        actions: [
          TextButton(
            onPressed: _canUpload ? _onUpload : null,
            child: Text(
              '업로드',
              style: TextStyle(
                color: _canUpload ? const Color(0xFFFFD24C) : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                maxLength: 1000,
                decoration: const InputDecoration(
                  hintText: '글을 작성해주세요. (최대 1,000자)',
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.image_outlined),
                    color: const Color(0xFFFFD24C),
                    onPressed: _onAttachImage,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: const Color(0xFFFFD24C),
                    onPressed: _onAddContent,
                  ),
                  const Spacer(),
                  // The keyboard 'Go' button will also submit if desired
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
