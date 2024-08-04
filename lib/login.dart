import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // 가로 방향으로 중앙 정렬
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              // Username TextField with fixed width
              Container(
                width: 300.0, // 너비를 300.0으로 설정합니다.
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Password TextField with fixed width
              Container(
                width: 300.0, // 너비를 300.0으로 설정합니다.
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 로그인 버튼 클릭 시 동작 정의
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logging in...')),
                  );
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
