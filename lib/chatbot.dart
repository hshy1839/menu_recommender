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
  String _question = '';
  String _previousQuestion = ''; // 이전 질문을 저장할 변수 추가
  bool _showInputField = false; // 입력 필드와 버튼을 보여줄지 여부를 나타내는 변수
  int _questionCount = 0; // 질문 횟수를 카운트

  // 사용자 답변을 서버에 전송
  Future<void> _sendPrompt() async {
    final headers = {
      'Content-Type': 'application/json',
    };

    // 프롬프트에 이전 질문과 사용자의 입력을 포함시킵니다.
    final body = json.encode({
      'contents': [
        {
          'parts': [
            {
              'text': _questionCount < 4
                  ? '너는 지금 내 식사 메뉴를 추천해주는 ai야 질문들을 통해서 나의 답변을 기반으로 나에게 가장 알맞은 메뉴를 추천해줘. 질문은 다섯가지만 하고, 아래는 너가 지켜야 할 주의사항들이야1. 질문은 한번에 하나씩 한다.2. 질문에 대한 내 답변으로 추천할 메뉴의 경우의 수를 줄여나간다.3. 질문들에는 항상 1번부터 5번까지 보기가 있어야해  4. 한국 식당에서 먹을 수 있는 메뉴여야한다(한식만 해당하는 것은 아님) 5. 마지막 질문 후 너가 메뉴를 추천하기 전까지 질문과 관계없는 답변에는 다시 답변해달라고 부탁한다. 6. 중복된 내용의 질문은 하지 말아. '
                  '${_previousQuestion}\n'
                  '${_controller.text}'
                  : '사용자가 한 답변들을 바탕으로 적절한 메뉴를 추천해줘 안내멘트는 추천해드릴 메뉴는 ~입니다. 라는 형식을 따르도록해 : ${_previousQuestion}\n${_controller.text}' // 5번째는 메뉴를 추천
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

          // 응답에서 질문을 추출하여 업데이트
          if (texts.isNotEmpty) {
            if (_questionCount < 4) {
              _previousQuestion += '\n$_question\n${_controller.text}'; // 현재 질문과 답변을 이전 질문에 추가
              _question = texts; // 새 질문으로 업데이트
              _showInputField = true; // 입력 필드와 버튼을 보여주도록 설정
              _questionCount++;
            } else {
              _showInputField = false; // 5번째에는 입력 필드를 숨기고
              _question = '추천 메뉴: $texts'; // 추천 메뉴를 보여줍니다.
            }
          } else {
            _question = '질문을 받지 못했습니다.';
          }
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
            onLogoutPressed: () {
              // 메뉴 버튼 클릭 시의 동작
              print('Menu button pressed');
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  // 화면에 질문을 표시합니다.
                  Text(
                    _question.isEmpty ? '전송 버튼을 눌러 질문을 받아보세요.' : _question,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  if (_showInputField) ...[
                    // 사용자 입력 텍스트 필드
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: '답변 입력',
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
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
