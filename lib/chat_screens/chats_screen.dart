import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'body.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          "My Chats",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
