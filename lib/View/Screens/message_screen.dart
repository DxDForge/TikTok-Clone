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
        child:  Text('WorKing!!!',style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold ,fontSize: 30 ),),
      ),
    );
  }
}