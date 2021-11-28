import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_first_flutter_app/page/userProfile.dart';
import 'package:my_first_flutter_app/page/body.dart';
import 'package:my_first_flutter_app/page/calendar2.dart';
import 'package:my_first_flutter_app/page/home.dart';
import 'package:my_first_flutter_app/page/wirtePost.dart';

class Next extends StatefulWidget {
  Next({Key key}) : super(key: key);
  @override
  _NextState createState() => _NextState();
}

class _NextState extends State<Next> {
  String currentLocation;
  int _currentPageIndex = 0;
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationWidget(),
      // appBar: AppBar(
      //   title: Image.asset('assets/images/appbar6.PNG'),
      //   backgroundColor: Color(0xFFCCCC99),
      //   centerTitle: true,
      //   elevation: 0.0,
      // ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/cook.PNG'),
                backgroundColor: Colors.white,
              ),
              accountName: Text('김종성'),
              accountEmail: Text('miaer789@naver.com'),
              decoration: BoxDecoration(
                color: Colors.lightGreen[300],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.money,
                  color: Colors.grey[850],
                ),
                title: Text('이번달 예산'),
                onTap: () {
                  print('쌉싸름한 레시피');
                }),
            ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey[850],
                ),
                title: Text('설정'),
                onTap: () {
                  print('쌉싸름한 레시피');
                }),
            ListTile(
                leading: Icon(
                  Icons.call,
                  color: Colors.grey[850],
                ),
                title: Text('고객센터'),
                onTap: () {
                  print('010-2248-4124');
                }),
          ],
        ),
      ),
    );
  } // 불러오는부분

  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return Home(); //home.dart
        break;
      case 1:
        return CalendarTwo(); //calendar2.dart
        break;
      case 2:
        return Board(); //writePost.dart
        break;
    }
    return Body(); //userProfile.dart
    //return Body(); //writePost.dart
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        "assets/svg/${iconName}_off.svg",
        width: 22,
      ),
      activeIcon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconName}_on.svg",
            width: 22,
          )),
      label: label,
    );
  }

  Widget _bottomNavigationWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentPageIndex,
      onTap: (index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      selectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(color: Colors.black),
      items: [
        _bottomNavigationBarItem("home", "홈"),
        _bottomNavigationBarItem("calendar", "캘린더"),
        _bottomNavigationBarItem("chat", "커뮤니티"),
        _bottomNavigationBarItem("user", "내 정보"),
      ],
    );
  }
}
