import 'package:flutter/material.dart';

import '../screens/add_page.dart';
import '../screens/home_page.dart';
import '../screens/library_page.dart';
import '../screens/short_page.dart';
import '../screens/subscription_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  List<BottomNavigationBarItem> bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      activeIcon: Icon(
        Icons.home_outlined,
        color: Colors.cyanAccent,
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.show_chart),
      label: 'Shorts',
      activeIcon: Icon(
        Icons.show_chart,
        color: Colors.cyanAccent,
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_circle_outline),
      label: 'Add',
      activeIcon: Icon(
        Icons.add_circle_outline,
        color: Colors.cyanAccent,
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.ondemand_video_outlined),
      label: 'Subscriptions',
      activeIcon: Icon(
        Icons.ondemand_video_outlined,
        color: Colors.cyanAccent,
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.video_library_outlined),
      label: 'Library',
      activeIcon: Icon(
        Icons.video_library_outlined,
        color: Colors.cyanAccent,
      ),
    ),

  ];

  List<Widget> pages = const [
    HomePage(),
    ShortPage(),
    AddPage(),
    SubscriptionPage(),
    LibraryPage(),
  ];

  void onNavBarItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavBarItems,
        currentIndex: selectedIndex,
        onTap: onNavBarItemTapped,
        selectedItemColor: Colors.cyanAccent,
        backgroundColor: Colors.black,
      ),
    );
  }
}
