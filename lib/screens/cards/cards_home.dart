import 'package:flutter/material.dart';
import 'package:pokehub/screens/cards/card_database.dart';
import 'package:pokehub/screens/cards/my_cards.dart';
import 'package:pokehub/size_config.dart';

class CardTab extends StatefulWidget {
  const CardTab({Key? key}) : super(key: key);

  @override
  _CardTabState createState() => _CardTabState();
}

class _CardTabState extends State<CardTab> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize:
                  Size(double.infinity, SizeConfig.blockSizeVertical * 100),
              child: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                labelStyle: TextStyle(
                  fontFamily: "Blinker",
                  fontSize: SizeConfig.blockSizeHorizontal * 5,
                  color: Colors.white,
                ),
                tabs: [
                  Tab(
                    text: "Card Database",
                  ),
                  Tab(
                    text: "My Cards",
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.red,
            body: SafeArea(
              child: Container(
                color: Colors.grey[900],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
