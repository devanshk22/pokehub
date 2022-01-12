import 'package:flutter/material.dart';
import 'package:pokehub/screens/cards/cards_home.dart';
import 'package:pokehub/screens/decks/decks_home.dart';
import 'package:pokehub/screens/home/home.dart';
import 'package:pokehub/screens/my_account/my_account.dart';
import 'package:pokehub/size_config.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  final tabs = [Home(), DeckTab(), CardTab(), MyAccount()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.red,
        currentIndex: _currentIndex,
        iconSize: SizeConfig.blockSizeHorizontal * 7,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: TextStyle(
          fontFamily: "Blinker",
          fontSize: SizeConfig.blockSizeHorizontal * 5,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: "Blinker",
          fontSize: SizeConfig.blockSizeHorizontal * 5,
          color: Colors.grey,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers_rounded),
            label: "Decks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.copy_rounded),
            label: "Cards",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "My Account",
          ),
        ],
      ),
    );
  }
}
