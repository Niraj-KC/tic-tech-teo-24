import 'package:flutter/material.dart';

hexStringToColors(String hexColor){
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}


class  AppColors {
  static Map theme = themes["lightTheme"]!;

  static Map themes = {
    "lightTheme": {
      "offWhite": hexStringToColors("#F8F9FA"),
      "white": hexStringToColors("#ffffff"),
      "black" : hexStringToColors("#000000"),
      "green": hexStringToColors("#0a4527"),
      "warning": hexStringToColors("#f9cf58"),
      "error": hexStringToColors("#ff5963"),
      "disable": Colors.blueGrey.shade300
    },
  };
}