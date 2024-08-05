import 'package:flutter/material.dart';

class MenuTotal extends StatefulWidget {
  const MenuTotal({super.key});

  @override
  _MenuTotalState createState() => _MenuTotalState();
}

class _MenuTotalState extends State<MenuTotal> {
  // 현재 펼쳐진 버튼을 관리할 상태 변수
  String? _selectedCategory;

  // 버튼 클릭 시 보여줄 하위 버튼 리스트
  Map<String, List<String>> _subMenuItems = {
    '찌개': ['김치찌개', '된장찌개', '순두부찌개', '설렁탕', '갈비탕', '청국장', '오징어찌개', '부대찌개'],
    '특식': ['스테이크', '랍스터', '해산물 파스타', '광어회', '장어덮밥', '고급 리조또', '새우튀김', '랍스터 스테이크'],
    '밑반찬': ['계란찜', '오이무침', '김치', '시금치나물', '콩나물무침', '잡채', '무생채', '고등어조림'],
    '간식': ['떡볶이', '순대', '튀김', '핫도그', '오뎅', '나초', '미니 핫도그', '팝콘'],
    '면': ['라면', '짜장면', '짬뽕', '우동', '냉면', '국수', '비빔국수', '칼국수'],
    '덮밥/볶음밥': ['김치볶음밥', '유린기 덮밥', '오므라이스', '소고기덮밥', '돼지고기덮밥', '해산물 볶음밥', '잡채덮밥', '비빔밥'],
    '국': ['미역국', '된장국', '육개장', '소고기무국', '순두부국', '김치국', '버섯국', '감자국'],
    '야식/술안주': ['치킨', '피자', '소세지', '막걸리', '와인', '맥주', '오징어', '닭발']
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('종합 메뉴 추천받기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // 2열로 정사각형 그리드 배치
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: _selectedCategory == null
              ? _buildMainMenuButtons()
              : _buildSubMenuButtons(),
        ),
      ),
    );
  }

  // 상위 버튼들
  List<Widget> _buildMainMenuButtons() {
    return _subMenuItems.keys.map((category) {
      return _buildMenuButton(category, Icons.fastfood, () {
        setState(() {
          _selectedCategory = category;
        });
      });
    }).toList();
  }

  // 하위 버튼들
  List<Widget> _buildSubMenuButtons() {
    final items = _subMenuItems[_selectedCategory];
    return items?.map((item) {
      return _buildMenuButton(item, Icons.food_bank, () {
        setState(() {
          _selectedCategory = item;
        });
      });
    }).toList() ?? [];
  }

  Widget _buildMenuButton(String title, IconData icon, VoidCallback onPressed) {
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
        onPressed: onPressed,
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
