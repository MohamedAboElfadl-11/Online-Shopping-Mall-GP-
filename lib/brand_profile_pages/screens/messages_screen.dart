import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  runApp(Messages());
}

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _handleSendMessage(String text) {
    if (text.isEmpty) return;
    setState(() {
      final time = DateFormat('hh:mm a').format(DateTime.now());
      _messages.add(ChatMessage(text: text, time: time, isSent: true));
    });
    _textController.clear();
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 50,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _handleSendImage(File imageFile) {
    if (imageFile == null) return;
    setState(() {
      final time = DateFormat('hh:mm a').format(DateTime.now());
      _messages.add(ChatMessage(imageFile: imageFile, time: time, isSent: true));
    });
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 50,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer name',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF684399),
        leading: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(3.14159265),
          child: IconButton(
            color: Colors.white,
            icon: Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ChatInput(
              textController: _textController,
              onSendMessage: _handleSendMessage,
              onSendImage: _handleSendImage,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatInput extends StatelessWidget {
  final TextEditingController textController;
  final Function(String) onSendMessage;
  final Function(File) onSendImage;

  ChatInput({required this.textController, required this.onSendMessage, required this.onSendImage});

  void _handleImageSelection(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onSendImage(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            IconButton(
              color: Color(0xFF684399),
              icon: Icon(Icons.add_a_photo_outlined),
              onPressed: () {
                _handleImageSelection(context);
              },
            ),
            Expanded(
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                ),
                onSubmitted: onSendMessage,
              ),
            ),
            IconButton(
              color: Color(0xFF684399),
              icon: Icon(Icons.send),
              onPressed: () {
                onSendMessage(textController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String? text;
  final String time;
  final bool isSent;
  final File? imageFile;

  ChatMessage({this.text, required this.time, this.isSent = false, this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSent ? Color(0xFF684399) : Color(0xFFE6E6E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isSent ? 12.0 : 0.0),
                topRight: Radius.circular(isSent ? 0.0 : 12.0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
            ),
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (text != null)
                  Text(
                    text!,
                    style: TextStyle(
                      color: isSent ? Colors.white : Colors.black,
                    ),
                  ),
                if (imageFile != null)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullscreenImage(imageFile: imageFile!),
                        ),
                      );
                    },
                    child: Image.file(
                      imageFile!,
                      width: 200,
                      height: 200,
                    ),
                  ),
                SizedBox(height: 4.0),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FullscreenImage extends StatelessWidget {
  final File imageFile;

  FullscreenImage({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: FileImage(imageFile),
        ),
      ),
    );
  }
}
