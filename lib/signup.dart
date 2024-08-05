import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  Future<void> _signUp(BuildContext context, String username, String password, String email, String phoneNumber, String name) async {
    final url = Uri.parse('http://localhost:8864/api/signup'); // 서버 URL
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
          'email': email,
          'phoneNumber': phoneNumber,
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['success']) {
          // 회원가입 성공
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          _showAlertDialog(context, '회원가입 성공!');
        } else {
          // 회원가입 실패: 중복된 사용자명 또는 이메일
          String message = responseBody['message'];
          if (message.contains('duplicate')) {
            _showAlertDialog(context, '중복된 사용자명 또는 이메일입니다. 다시 시도해주세요.');
          } else {
            _showAlertDialog(context, '회원가입 실패: ${responseBody['message']}');
          }
        }
      } else {
        // 서버 오류
        _showAlertDialog(context, '다시 입력하세요');
      }
    } catch (e) {
      // 예외 처리
      _showAlertDialog(context, '회원가입 통신 오류');
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
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneNumberController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Sign Up',
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
              SizedBox(height: 16.0),
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
              SizedBox(height: 16.0),
              Container(
                width: 300.0,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                width: 300.0,
                child: TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                width: 300.0,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  final email = _emailController.text;
                  final phoneNumber = _phoneNumberController.text;
                  final name = _nameController.text;

                  _signUp(context, username, password, email, phoneNumber, name);
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
