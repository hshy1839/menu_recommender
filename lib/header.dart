import 'package:flutter/material.dart';
import 'login.dart'; // 로그인 페이지를 import 합니다.

class Header extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onMenuPressed;

  Header({
    required this.onLoginPressed,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0, // 헤더의 높이를 설정합니다.
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.blueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 로고 이름
          Text(
            '메추리알',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              // 로그인 버튼
              IconButton(
                icon: Icon(Icons.account_circle, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
              SizedBox(width: 16.0), // 버튼 간의 간격
              // 메뉴 버튼
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white, size: 30),
                onPressed: onMenuPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
