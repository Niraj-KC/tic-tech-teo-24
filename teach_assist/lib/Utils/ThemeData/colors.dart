import 'package:flutter/material.dart';

hexStringToColors(String hexColor){
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}


class  AppColors {
  static Map<String, Color> theme = themes["lightTheme"]!;

  static Map<String, Map<String, Color>> themes = {
    "lightTheme": {
      "primaryBg": hexStringToColors("#f1f4f8"),
      "secondaryBg": hexStringToColors("#ffffff"),
      "success": hexStringToColors("#52DE97"),
      "warning": hexStringToColors("#f9cf58"),
      "error": hexStringToColors("#ff5963"),
      "disable": Colors.blueGrey.shade300
    },

  };


}