import 'package:flutter/material.dart';
import 'package:menu_recommender/chatbot.dart';
import 'package:menu_recommender/signup.dart';
import 'header.dart'; // header.dart 파일을 import 합니다.
import 'login.dart'; // login.dart 파일을 import 합니다.
import 'main_calendar.dart'; // main_calendar.dart 파일을 import 합니다.
import 'chatbot.dart';
import 'signup.dart';
import 'select_menu.dart'; // 선택형 메뉴 추천 페이지를 import 합니다.
import 'select_menu_list/select_menu_total.dart';
import 'select_menu_list/select_menu_country.dart';
import 'select_menu_list/select_menu_situation.dart';

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
        '/signup': (context) => const SignUpPage(),
        '/select_menu': (context) => const SelectMenuPage(),
        '/select_menu_total': (context) => const MenuTotal(),
        '/select_menu_situation': (context) => const MenuSituation(),
        '/select_menu_country': (context) => const MenuCountry(),
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
              onLogoutPressed: () {
                // 메뉴 버튼 클릭 시의 동작
                print('Logout button pressed');
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
                    child: Text('AI 메뉴 추천받기'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/select_menu');
                    },
                    child: Text('선택형 메뉴 추천받기'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
