import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lionchat/camera.dart';
import 'package:lionchat/people.dart';
import 'package:lionchat/search2.dart';
import 'chats.dart';

class chat extends StatefulWidget {
  chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  int currentindex = 0;
  final pages = [
    chats(),
    search2(),
    camera(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 3),
          ],
        ),
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          currentIndex: currentindex,
          selectedFontSize: 14,
          selectedIconTheme: IconThemeData(size: 34),
          unselectedIconTheme: IconThemeData(size: 26),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).colorScheme.onBackground,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "chat",
                backgroundColor: Theme.of(context).scaffoldBackgroundColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "people",
                backgroundColor: Theme.of(context).scaffoldBackgroundColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: "camera",
                backgroundColor: Theme.of(context).scaffoldBackgroundColor),
          ],
        ),
      ),
      body: pages.elementAt(currentindex),
    );
  }
}
