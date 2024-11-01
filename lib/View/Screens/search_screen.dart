import 'package:flutter/material.dart';
import 'package:news_proved/constant.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        
        title: TextFormField(
          decoration: const InputDecoration(
            filled: false,
            hintText: "Search",
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.white,
             ),
            

          ),
        ),
      ),

body: const Center(
  child: Text(
    "Search Screen",
    style:  TextStyle(
      fontSize: 24, 
      color: Colors.white),  // white text color for the title
  ),
),
    );
  }
}