import 'package:appstagram/page/home_page.dart';
import 'package:appstagram/page/favourite_page.dart';
import 'package:appstagram/page/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    FavouritePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
              size: 30,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
              size: 25,
            ),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person,
              size: 30,
            ),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
