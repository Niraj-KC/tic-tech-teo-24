import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Transitions/LeftToRight.dart';
import '../../Utils/ThemeData/colors.dart';
import '../../main.dart';
import '../AuthScreens/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 900), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));

      Navigator.pushReplacement(context, LeftToRight(LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: AppColors.theme['backgroundColor'],
          body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   "assets/images/SL (1).png",
                  //   height: 200,
                  //   width: 200,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.2),
                    child: Text(
                      "ClassOrbit",
                      style: TextStyle(
                          color: AppColors.theme['black'],
                          fontSize:25,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.2),
                    child: Text(
                      "Learning your way!",
                      style: TextStyle(
                          color: AppColors.theme['black'],
                          fontSize: 25,fontWeight:FontWeight.bold),
                    ),
                  )
                ]),
          )),
    );
  }
}