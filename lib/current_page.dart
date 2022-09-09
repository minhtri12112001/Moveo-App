import 'package:flutter/material.dart';
import 'package:moveo_app/demo_page.dart';
import 'page/home_page.dart';
import 'page/news_page.dart';
import 'page/setting_page.dart';


class CurrentPage extends StatefulWidget {
  //final UserModel user;
  const CurrentPage({Key? key}) : super(key: key);
  //const CurrentPage({Key? key, required this.user}) : super(key: key);

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          //DemoPage(),
          HomePage(),
          NewsPage(),
          SettingPage()
        ],
      ),
      //body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'News'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting'),
        ],
      ),
    );
  }
}