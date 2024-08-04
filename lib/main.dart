// lib/main.dart
import 'package:flutter/material.dart';
import 'package:menu_recommender/chatbot.dart';
import 'header.dart'; // header.dart 파일을 import 합니다.
import 'login.dart'; // login.dart 파일을 import 합니다.
import 'main_calendar.dart'; // main_calendar.dart 파일을 import 합니다.
import 'chatbot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/login': (context) => const LoginPage(),
        '/chatbot': (context) => ChatbotPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Header 위젯을 상단에 배치합니다.
          Container(
            width: double.infinity,
            child: Header(
              onLoginPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              onMenuPressed: () {
                // 메뉴 버튼 클릭 시의 동작
                print('Menu button pressed');
              },
            ),
          ),
          Expanded(
            child: MainCalendar(), // 달력 호출
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/chatbot');
                    },
                    child: Text('메뉴 추천받기'),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
