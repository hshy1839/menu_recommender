import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> _login(BuildContext context, String username, String password) async {
    final url = Uri.parse('http://localhost:8864/api/login'); // 서버 URL
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['success']) {
          // 로그인 성공
          print('Login successful');
          await _saveLoginState(true); // 로그인 상태를 true로 저장
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          _showAlertDialog(context, 'WELCOME !');
        } else {
          // 로그인 실패
          _showAlertDialog(context, '아이디 또는 비밀번호가 다릅니다.');
        }
      } else {
        // 서버 오류
        _showAlertDialog(context, '서버 오류');
      }
    } catch (e) {
      // 예외 처리
      _showAlertDialog(context, '로그인 통신 오류');
    }
  }

  Future<void> _saveLoginState(bool isLoggedIn) async {
    SharedPreferences.setMockInitialValues({});
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', isLoggedIn); // 로그인 상태를 저장
    } catch (e) {
      print('Error saving login state: $e');
    }
  }

  Future<bool> _getLoginState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('isLoggedIn') ?? false; // 로그인 상태를 가져오고 기본값을 false로 설정
    } catch (e) {
      print('Error retrieving login state: $e');
      return false;
    }
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Container(
                width: 300.0,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300.0,
                child: TextField(
                  controller: _passwordController,
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
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  _login(context, username, password);
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
