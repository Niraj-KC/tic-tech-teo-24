import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../ThemeData/colors.dart';

class HelperFunction {

  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.theme["black"].withOpacity(0.7),
        textColor: AppColors.theme["offWhite"],
      fontSize: 16.0,
    );
  }


}