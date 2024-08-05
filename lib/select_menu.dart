import 'package:flutter/material.dart';
import 'select_menu_list/select_menu_total.dart';
import 'select_menu_list/select_menu_situation.dart';
import 'select_menu_list/select_menu_country.dart';

class SelectMenuPage extends StatelessWidget {
  const SelectMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('선택형 메뉴 추천받기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // 2열로 정사각형 그리드 배치
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: <Widget>[
            _buildMenuButton(context, '배고픔', Icons.fastfood, null),
            _buildMenuButton(context, '나라별 메뉴', Icons.public, MenuCountry()),
            _buildMenuButton(context, '재료별 메뉴', Icons.kitchen, null),
            _buildMenuButton(context, '상황별 메뉴', Icons.event, MenuSituation()),
            _buildMenuButton(context, '종합 메뉴', Icons.menu_book, MenuTotal()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, IconData icon, Widget? nextPage) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16),
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 사각형 모양으로 설정
          ),
        ),
        onPressed: () {
          if (nextPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$title 버튼 눌림')),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
