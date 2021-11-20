import 'package:flutter/material.dart';
import 'package:pokehub/size_config.dart';

InputDecoration decor = InputDecoration(
  border: OutlineInputBorder(),
  fillColor: Colors.white,
  filled: true,
  hintStyle:
      input_text_style.copyWith(fontSize: SizeConfig.blockSizeHorizontal * 4),
);

TextStyle input_text_style = TextStyle(
  fontFamily: "Blinker",
  color: Colors.grey[500],
);
