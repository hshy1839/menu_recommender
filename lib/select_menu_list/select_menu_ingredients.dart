import 'package:flutter/material.dart';

class MenuIngredients extends StatefulWidget {
  const MenuIngredients({super.key});

  @override
  _MenuIngredientsState createState() => _MenuIngredientsState();
}

class _MenuIngredientsState extends State<MenuIngredients> {
  // 현재 펼쳐진 버튼을 관리할 상태 변수
  String? _selectedCategory;

  // 버튼 클릭 시 보여줄 하위 버튼 리스트
  Map<String, List<String>> _subMenuItems = {
    '해장': ['얼큰한 국물', '속을 따뜻하게', '매운 음식', '시원한 국물', '매운탕', '순두부찌개', '곰탕', '설렁탕'],
    '손님대접': ['한정식', '궁중떡볶이', '리조또', '스테이크', '광어회', '랍스터', '양갈비', '치킨'],
    '간식/야식': ['치킨너겟', '핫윙', '미니 핫도그', '떡볶이', '순대', '타코야끼', '오징어튀김', '튀김'],
    '영양식': ['비빔밥', '샐러드', '닭가슴살', '콩나물국', '된장국', '해조류', '그릭 요거트', '해물파전'],
    '브런치': ['오믈렛', '팬케이크', '베이컨과 달걀', '아보카도 토스트', '프렌치 토스트', '와플', '크로와상', '머핀'],
    '도시락': ['김밥', '볶음밥', '덮밥', '도시락 세트', '샐러드', '토스트', '불고기', '순대'],
    '식이조절': ['현미밥', '닭가슴살', '스팀 채소', '저칼로리 샐러드', '콩 비빔밥', '두부', '해조류', '저염식'],
    '초스피드': ['라면', '컵라면', '즉석밥', '즉석식품', '샌드위치', '핫도그', '간편식', '볶음밥']
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
