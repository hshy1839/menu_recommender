import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart'; // 로그인 페이지를 import 합니다.
import 'main.dart';  // MyHomePage를 import 합니다.

class Header extends StatefulWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onMenuPressed;

  Header({
    required this.onLoginPressed,
    required this.onMenuPressed,
  });

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.blueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 로고 이름 클릭 시 메인 페이지로 돌아가는 기능 추가
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')),
                    (Route<dynamic> route) => false,
              );
            },
            child: Text(
              '메추리알',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              // 로그인 버튼
              if (!_isLoggedIn)
                IconButton(
                  icon: Icon(Icons.account_circle, color: Colors.white, size: 30),
                  onPressed: widget.onLoginPressed,
                ),
              SizedBox(width: 16.0), // 버튼 간의 간격
              // 메뉴 버튼
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white, size: 30),
                onPressed: widget.onMenuPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
