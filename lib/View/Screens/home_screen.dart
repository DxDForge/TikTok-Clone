import 'package:flutter/material.dart';
import 'package:news_proved/View/Widgets/custom_icon.dart';
import 'package:news_proved/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
        bottomNavigationBar: BottomNavigationBar(
         onTap: (idx) {
           setState(() {
             pageIdx = idx;
             print(pageIdx);
           });
         },
      currentIndex: pageIdx, 
      // fixedColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      backgroundColor: backgroundColor,
      selectedItemColor: buttonColor,
      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: CustomIcon(), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'person'),
      ],
    ),
    body:page[pageIdx] ,
 );

    
  }
  
}
