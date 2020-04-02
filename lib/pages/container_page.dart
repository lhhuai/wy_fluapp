import 'package:flutter/material.dart';
import 'package:wy_fluapp/pages/home/home_page.dart';
import 'package:wy_fluapp/pages/movie/movie_page.dart';
import 'package:wy_fluapp/pages/group/group_page.dart';
import 'package:wy_fluapp/pages/shop/shop_page.dart';
import 'package:wy_fluapp/pages/person/person_center_page.dart';

class ContainerPage extends StatefulWidget {
  ContainerPage({Key key}) : super(key: key);

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  List<Widget> pages;
  List<BottomNavigationBarItem> barItemList;

  final items = [
    _Item('首页', 'assets/images/tab_bar/ic_tab_home_active.png', 'assets/images/tab_bar/ic_tab_home_normal.png'),
    _Item('书影音', 'assets/images/tab_bar/ic_tab_subject_active.png', 'assets/images/tab_bar/ic_tab_subject_normal.png'),
    _Item('小组', 'assets/images/tab_bar/ic_tab_group_active.png', 'assets/images/tab_bar/ic_tab_group_normal.png'),
    _Item('市集', 'assets/images/tab_bar/ic_tab_shiji_active.png', 'assets/images/tab_bar/ic_tab_shiji_normal.png'),
    _Item('我的', 'assets/images/tab_bar/ic_tab_profile_active.png', 'assets/images/tab_bar/ic_tab_profile_normal.png')
  ];

  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    if (pages == null) {
      pages = [
        HomePage(),
        MoviePage(),
        GroupPage(),
        ShopPage(),
        PersonCenterPage(),
      ];
    }
    if (barItemList == null) {
      barItemList = items.map((item) => BottomNavigationBarItem(
        title: Text(item.name, style: TextStyle(fontSize: 10.0)),
        icon: Image.asset(item.normalIcon, width: 30.0, height: 30.0),
        activeIcon: Image.asset(item.activeIcon, width: 30.0, height: 30.0,),
      )).toList();
    }
  }

  @override
  void didUpdateWidget(ContainerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _getPageWidget(0),
          _getPageWidget(1),
          _getPageWidget(2),
          _getPageWidget(3),
          _getPageWidget(4),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      bottomNavigationBar: BottomNavigationBar(
        items: barItemList,
        onTap: (int index) {
          setState(() {
            _selectIndex = index;
          });
        },
        iconSize: 24,
        currentIndex: _selectIndex,
        fixedColor: Color.fromARGB(255, 0, 188, 96),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _getPageWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }
}

class _Item {
  String name, activeIcon, normalIcon;

  _Item(this.name, this.activeIcon, this.normalIcon);
}
