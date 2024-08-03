import 'package:flutter/material.dart';

class TextEditingTab extends StatefulWidget {
  const TextEditingTab({Key? key}) : super(key: key);

  @override
  _TextEditingTabState createState() => _TextEditingTabState();
}

class _TextEditingTabState extends State<TextEditingTab> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _textController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: const InputDecoration(
          hintText: 'Start typing...',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
