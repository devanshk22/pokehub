import 'package:flutter/material.dart';
import 'package:pokehub/models/deck.dart';
import 'package:pokehub/screens/authenticate/text_field_decoration.dart';
import 'package:pokehub/screens/decks/deck_card_selection.dart';

import '../../size_config.dart';

class DeckInfoForm extends StatefulWidget {
  String uid;
  DeckInfoForm({required this.uid});

  @override
  State<DeckInfoForm> createState() => _DeckInfoFormState();
}

class _DeckInfoFormState extends State<DeckInfoForm> {
  final _formkey = GlobalKey<FormState>();
  String name = "";
  format deckFormat = format.Standard;
  String error = "";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Deck"),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeVertical * 2,
                vertical: SizeConfig.blockSizeVertical * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Deck Name:",
                          style: TextStyle(
                            fontFamily: "Blinker",
                            fontSize: SizeConfig.blockSizeHorizontal * 4,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter a name' : null,
                        style: input_text_style.copyWith(color: Colors.black),
                        decoration: decor.copyWith(hintText: "Name"),
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Deck Format:",
                          style: TextStyle(
                            fontFamily: "Blinker",
                            fontSize: SizeConfig.blockSizeHorizontal * 4,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<format>(
                          value: deckFormat,
                          icon: const Icon(Icons.arrow_downward),
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.redAccent,
                          ),
                          onChanged: (format? newValue) {
                            setState(() {
                              deckFormat = newValue!;
                            });
                          },
                          items: format.values
                              .map<DropdownMenuItem<format>>((format value) {
                            String str_value = value.toString();
                            str_value = str_value.replaceAll("format.", "");
                            return DropdownMenuItem<format>(
                              value: value,
                              child: Text(str_value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DeckCardSelector(
                                            name: name,
                                            deckFormat: deckFormat,
                                            uid: widget.uid,
                                          )));
                            } else {
                              setState(() {
                                error = "Please enter valid details";
                              });
                            }
                          },
                          child: Text(
                            "Add Cards to Deck",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Blinker",
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        error,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Blinker",
                            fontSize: SizeConfig.blockSizeHorizontal * 4,
                            color: Colors.red),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
