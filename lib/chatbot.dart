// lib/chatbot.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart'; // 로그인 페이지를 import 합니다.
import 'header.dart';



class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final String apiKey = 'AIzaSyDw5Bgvczfi1WDnQB1kbWcetqiXABNCLNs';  // 실제 API 키로 대체
  final String apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent'; // 실제 엔드포인트로 대체
  String _response = '';

  Future<void> _sendPrompt() async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = json.encode({
      'contents': [
        {
          'parts': [
            {
              'text': _controller.text
            }
          ]
        }
      ]
    });

    try {
      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'), // API 키를 쿼리 파라미터로 추가
        headers: headers,
        body: body,
      );

      // 응답 상태 코드와 본문 로그 출력
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        // candidates의 content의 parts의 text만 추출
        final content = responseBody['candidates']?.first['content'];
        final parts = content?['parts'] as List<dynamic>? ?? [];
        final texts = parts.map((part) => part['text'] as String).join('\n');

        setState(() {
          _response = texts.isEmpty ? '응답 없음' : texts;
        });
      } else {
        setState(() {
          _response = '오류: ${response.statusCode} ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _response = '오류: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Header 위젯을 상단에 배치합니다.
          Header(
            onLoginPressed: () {
              // 로그인 버튼 클릭 시의 동작
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            onMenuPressed: () {
              // 메뉴 버튼 클릭 시의 동작
              print('Menu button pressed');
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: '프롬프트 입력',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _sendPrompt,
                    child: Text('전송'),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        _response,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
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
