import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static void launchURL(String url) {
    launchUrl(Uri.parse(url));
  }


}