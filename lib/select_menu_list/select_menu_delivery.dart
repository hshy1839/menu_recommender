import 'package:flutter/material.dart';

class MenuDelivery extends StatefulWidget {
  const MenuDelivery({super.key});

  @override
  _MenuDeliveryState createState() => _MenuDeliveryState();
}

class _MenuDeliveryState extends State<MenuDelivery> {
  // 현재 펼쳐진 버튼을 관리할 상태 변수
  String? _selectedCategory;

  // 버튼 클릭 시 보여줄 하위 버튼 리스트
  Map<String, List<String>> _subMenuItems = {
    '중식': ['울면', '유린기', '짜장면', '짬뽕', '탕수육', '깐풍기', '칠리새우', '마라탕'],
    '일식': ['초밥', '돈부리', '참치회', '소바', '오코노미야끼', '우동', '라멘', '타코야끼'],
    '고기':['치킨너겟', '핫윙', '미니 핫도그', '떡볶이', '순대', '타코야끼', '오징어튀김', '튀김'],
    '패스트푸드': ['치킨', '햄버거', '피자', '감자튀김', '핫도그', '타코', '케밥', '샌드위치'],
    '기타': ['빙수', '생선구이', '케이크', '카레', '쌀국수', '파스타', '스테이크', '훈제오리'],
    '한식': ['닭볶음탕', '설렁탕', '냉면', '갈비탕', '삼계탕', '불고기 백반', '갈비찜', '김치찌개'],
    '야식': ['족발', '보쌈', '닭발', '찜닭', '해장국', '아구찜', '오돌뼈', '곱창'],
    '분식': ['떡볶이', '순대', '쫄면', '돈까스', '김밥', '닭꼬치', '오뎅', '튀김']
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('배달 메뉴 추천받기'),
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
      width: 150,  // 버튼의 가로 크기 조정
      height: 150, // 버튼의 세로 크기 조정
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
