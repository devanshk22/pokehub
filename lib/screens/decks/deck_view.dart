import 'package:flutter/material.dart';
import 'package:pokehub/models/deck.dart';
import 'package:pokehub/models/user_account.dart';
import 'package:pokehub/screens/cards/pokemon_card_info.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class DeckView extends StatefulWidget {
  String uid;
  Deck deck;
  DeckView({required this.uid, required this.deck});

  @override
  State<DeckView> createState() => _DeckViewState();
}

class _DeckViewState extends State<DeckView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAccount>(context);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          "Deck Profile: " + widget.deck.name,
          style: TextStyle(
            fontFamily: "Blinker",
            fontSize: SizeConfig.blockSizeHorizontal * 5,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Text(
              "Format: " + widget.deck.deckFormat.toString().split('.').last,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Blinker',
                fontSize: SizeConfig.blockSizeVertical * 3,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Text(
              r"Deck Price: $" + getDeckPrice(widget.deck.deckList).toString(),
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Blinker',
                fontSize: SizeConfig.blockSizeVertical * 3,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Text(
              "Completeness: " +
                  (widget.deck.deckList.length == 60
                      ? "Yes"
                      : "Incomplete (${widget.deck.deckList.length} cards only)"),
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Blinker',
                fontSize: SizeConfig.blockSizeVertical * 3,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Expanded(
              child: GridView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.deck.deckList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      PokemonCard card = widget.deck.deckList[index];
                      if (card.supertype.type == 'Pokémon') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PokemonCardInfo(
                                      card: widget.deck.deckList[index],
                                      user: user,
                                    )));
                      } else if (card.supertype.type == 'Trainer') {
                      } else if (card.supertype.type == 'Energy') {}
                    },
                    child: Card(
                      child: Image.network(
                        widget.deck.deckList[index].images.large,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getDeckPrice(List<PokemonCard> cards) {
    double sum = 0;
    cards.forEach((element) {
      if (getMarketPrice(element) != "Market Price: Unavailable") {
        double cardPrice = double.parse(getMarketPrice(element));
        sum += cardPrice;
      }
    });
    return sum;
  }

  String getMarketPrice(PokemonCard card) {
    try {
      return card.tcgPlayer["prices"]["normal"]["market"].toString();
    } catch (e) {
      try {
        return card.tcgPlayer["prices"]["holofoil"]["market"].toString();
      } catch (e) {
        return "Market Price: Unavailable";
      }
    }
  }
}
