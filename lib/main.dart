import 'package:flutter/material.dart';
import 'package:lionchat/camera.dart';
import 'package:lionchat/chat.dart';
import 'package:lionchat/chats.dart';
import 'package:lionchat/masseging.dart';
import 'package:lionchat/people.dart';
import 'package:lionchat/search2.dart';
import 'package:lionchat/singin.dart';
import 'package:lionchat/wellcomescrean.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 66, 139, 199),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 66, 139, 199),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 34,
              color: Color.fromARGB(255, 93, 173, 234),
              fontWeight: FontWeight.bold),
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          subtitle1: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          headline2: TextStyle(fontSize: 24, color: Colors.white),
          headline3: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          headline4: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          headline5: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        primaryColor: Color.fromARGB(255, 66, 139, 199),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.blue,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.blue,
            error: Colors.red,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Colors.blue,
            surface: Colors.white,
            onSurface: Colors.white),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blue,
        ),
      ),
      darkTheme: ThemeData(
        dialogBackgroundColor: const Color.fromARGB(255, 3, 29, 48),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 39, 119, 184),
          onPrimary: Colors.white,
          secondary: Color.fromARGB(255, 39, 119, 184),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Color.fromARGB(255, 39, 119, 184),
          onBackground: Colors.white,
          surface: Color.fromARGB(255, 39, 119, 184),
          onSurface: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 39, 119, 184),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 3, 29, 48),
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 39, 119, 184),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 34,
              color: Color.fromARGB(255, 93, 173, 234),
              fontWeight: FontWeight.bold),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          subtitle1: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          headline2: TextStyle(fontSize: 24, color: Colors.white),
          headline3: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          headline4: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          headline5: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const wellcomescrean(),
      routes: {
        "people": (context) => people(),
        "singin": (context) => singin(),
        "chats": (context) => chats(),
        "camera": (context) => camera(),
        "search2": (context) => search2(),
        "chat": (context) => chat(),
      },
    );
  }
}
