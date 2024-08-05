import 'package:flutter/material.dart';

class MenuCountry extends StatefulWidget {
  const MenuCountry({super.key});

  @override
  _MenuCountryState createState() => _MenuCountryState();
}

class _MenuCountryState extends State<MenuCountry> {
  // 현재 펼쳐진 버튼을 관리할 상태 변수
  String? _selectedCountry;

  // 버튼 클릭 시 보여줄 하위 버튼 리스트
  Map<String, List<String>> _subMenuItems = {
    '일본': ['스시', '라멘', '우동', '텐푸라', '돈부리', '교자', '타코야끼', '온센 타마고'],
    '한국': ['비빔밥', '불고기', '김치찌개', '떡볶이', '삼겹살', '된장찌개', '김밥', '해물파전'],
    '중국': ['짜장면', '짬뽕', '탕수육', '마파두부', '춘권', '군만두', '사천탕면', '딤섬'],
    '이탈리아': ['피자', '파스타', '리조또', '라자냐', '카프레제', '티라미수', '브루스케타', '미네스트로네'],
    '프랑스': ['크로와상', '프랑스식 오믈렛', '부이야베스', '라따뚜이', '마카롱', '프렌치 토스트', '카레', '에스카르고'],
    '미국': ['햄버거', '핫도그', '스테이크', '프라이드 치킨', '클럽 샌드위치', '맥앤치즈', '블루베리 팬케이크', 'BBQ'],
    '중동': ['훔무스', '팔라펠', '타불레', '케밥', '바바 가누쉬', '샤와르마', '자타르', '피타 브레드'],
    '동남아': ['파드 타이', '쏨땀', '반미', '느억맘', '소고기 볶음밥', '피시 소스', '그린 커리', '토마얌'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나라별 메뉴 추천받기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // 2열로 정사각형 그리드 배치
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: _selectedCountry == null
              ? _buildMainMenuButtons()
              : _buildSubMenuButtons(),
        ),
      ),
    );
  }

  // 상위 버튼들
  List<Widget> _buildMainMenuButtons() {
    return _subMenuItems.keys.map((country) {
      return _buildMenuButton(country, Icons.public, () {
        setState(() {
          _selectedCountry = country;
        });
      });
    }).toList();
  }

  // 하위 버튼들
  List<Widget> _buildSubMenuButtons() {
    final items = _subMenuItems[_selectedCountry];
    return items?.map((item) {
      return _buildMenuButton(item, Icons.food_bank, () {
        setState(() {
          _selectedCountry = item;
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
