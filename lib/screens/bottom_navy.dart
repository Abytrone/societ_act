import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:societ_act/screens/home_screen.dart';
import 'package:societ_act/screens/messages_screen.dart';
import 'package:societ_act/screens/notification_screen.dart';
import 'package:societ_act/screens/search_screen.dart';

class BottomNavy extends StatefulWidget {
  const BottomNavy({Key? key}) : super(key: key);

  @override
  _BottomNavyState createState() => _BottomNavyState();
}

class _BottomNavyState extends State<BottomNavy> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: const <Widget>[
            HomeScreen(),
            SearchScreen(),
            MessagesScreen(),
            NotificationScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController!.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 15,
                  ),
            ),
            icon: const Icon(Icons.home),
            activeColor: const Color(0xFF457B9D),
            inactiveColor: const Color(0xFFB4B4B4),
          ),
          BottomNavyBarItem(
            title: Text(
              'Search',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 15,
                  ),
            ),
            icon: const Icon(Icons.search),
            activeColor: const Color(0xFF457B9D),
            inactiveColor: const Color(0xFFB4B4B4),
          ),
          BottomNavyBarItem(
            title: Text(
              'Messages',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 15,
                  ),
            ),
            icon: const Icon(Icons.mail_outline),
            activeColor: const Color(0xFF457B9D),
            inactiveColor: const Color(0xFFB4B4B4),
          ),
          BottomNavyBarItem(
            title: Text(
              'Notifications',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 12,
                  ),
            ),
            icon: const Icon(Icons.notifications_outlined),
            activeColor: const Color(0xFF457B9D),
            inactiveColor: const Color(0xFFB4B4B4),
          ),
        ],
      ),
    );
  }
}
