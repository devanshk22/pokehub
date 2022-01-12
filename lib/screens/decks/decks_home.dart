import 'package:flutter/material.dart';

class DeckTab extends StatefulWidget {
  const DeckTab({Key? key}) : super(key: key);

  @override
  _DeckTabState createState() => _DeckTabState();
}

class _DeckTabState extends State<DeckTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Decks"),
    );
  }
}
