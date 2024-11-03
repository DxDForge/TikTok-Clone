import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Message Screen'),
      ),
      body: const Center(
        child:  Text('Welcome to the Message Screen!\n   \nYet need to create'),
      ),
    );
  }
}