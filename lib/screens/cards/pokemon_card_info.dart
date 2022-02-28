import 'package:flutter/material.dart';
import 'package:pokehub/size_config.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

class PokemonCardInfo extends StatefulWidget {
  PokemonCard card;

  PokemonCardInfo({required this.card});

  @override
  _PokemonCardInfoState createState() => _PokemonCardInfoState();
}

class _PokemonCardInfoState extends State<PokemonCardInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(
            "Card Profile",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Blinker',
                fontSize: SizeConfig.blockSizeVertical * 3),
          ),
          backgroundColor: Colors.red,
          elevation: 0.0,
        ),
        body: Align(
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Center(
                child: Text(
                  "Set: " +
                      widget.card.set.name +
                      "  //  Number: " +
                      widget.card.number,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Blinker',
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Hero(
                tag: 'card' + widget.card.id,
                child: Image.network(
                  widget.card.images.large,
                  height: SizeConfig.blockSizeVertical * 30,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Center(
                child: Text(
                  widget.card.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Blinker',
                    fontSize: SizeConfig.blockSizeVertical * 5,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: SizeConfig.blockSizeVertical * 4,
                crossAxisSpacing: SizeConfig.blockSizeHorizontal * 4,
                crossAxisCount: 3,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeHorizontal * 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Subtypes",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Blinker',
                                fontSize: SizeConfig.blockSizeVertical * 3,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.card.subtypes.map((e) => e.type).join(", "),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Blinker',
                              fontSize: SizeConfig.blockSizeVertical * 2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeHorizontal * 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "HP",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Blinker',
                                fontSize: SizeConfig.blockSizeVertical * 3,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.card.hp!,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Blinker',
                              fontSize: SizeConfig.blockSizeVertical * 2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeHorizontal * 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Type",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Blinker',
                                fontSize: SizeConfig.blockSizeVertical * 3,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.card.types.map((e) => e.type).join(", "),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Blinker',
                              fontSize: SizeConfig.blockSizeVertical * 2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeHorizontal * 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Weakness",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Blinker',
                                fontSize: SizeConfig.blockSizeVertical * 3,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.card.weaknesses.isEmpty
                                ? "None"
                                : widget.card.weaknesses
                                    .map((e) => e.type + e.value)
                                    .join(", "),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Blinker',
                              fontSize: SizeConfig.blockSizeVertical * 2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeHorizontal * 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Resistance",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Blinker',
                                fontSize: SizeConfig.blockSizeVertical * 3,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.card.resistances.isEmpty
                                ? "None"
                                : widget.card.resistances
                                    .map((e) => e.type == ""
                                        ? "None"
                                        : e.type + e.value)
                                    .join(", "),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Blinker',
                              fontSize: SizeConfig.blockSizeVertical * 2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeHorizontal * 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Retreat Cost",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Blinker',
                                fontSize: SizeConfig.blockSizeVertical * 3,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.card.convertedRetreatCost == 0
                                ? "None"
                                : widget.card.convertedRetreatCost.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Blinker',
                              fontSize: SizeConfig.blockSizeVertical * 2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
