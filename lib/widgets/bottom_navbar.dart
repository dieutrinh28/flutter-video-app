import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/library_page.dart';
import '../screens/short_page.dart';
import '../screens/subscription_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (BuildContext context) {
                return SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.show_chart),
                        title: const Text('Create a Short'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.upload),
                        title: const Text('Upload a video'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.cell_tower),
                        title: const Text('Go live'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Create a post'),
                        onTap: () {},
                      ),
                    ],
                  ),
                );
          });
        },
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        child: const Icon(
          Icons.add_circle_outline,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
