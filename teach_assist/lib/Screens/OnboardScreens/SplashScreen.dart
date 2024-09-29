import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/API/FireStoreAPIs/studentServices.dart';
import 'package:teach_assist/API/FireStoreAPIs/teacherServices.dart';
import 'package:teach_assist/API/FirebaseAPIs.dart';
import 'package:teach_assist/Models/Student.dart';
import 'package:teach_assist/Models/Teacher.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';
import 'package:teach_assist/Screens/StudentScreens/StudentHomeScreen.dart';
import 'package:teach_assist/Screens/TeacherScreens/TeacherHomeScreen.dart';
import '../../API/NotificationApi.dart';
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

  Future initUser() async {
    String? uid = FirebaseAPIs.auth.currentUser?.uid;
    print("#authId: $uid");
    if(uid != null){
      try{
        var user = await TeacherService().getTeacherById(uid);
        print("User: $user");
        if (user.runtimeType == Teacher) {
          Provider.of<CurrentUserProvider>(context, listen: false).user = user;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TeacherHomeScreen()));
        } else {
          throw "Not in Teacher Collection";
        }
      }
      catch (e){
        print("#error: $e");
        var user = await StudentService().getStudentById(uid);
        print("User: $user");
        if (user.runtimeType == Student) {
          Provider.of<CurrentUserProvider>(context, listen: false).user = user;
          await NotificationApi.getFirebaseMessagingToken(user!.id!);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const StudentHomeScreen()));
        }
      }

    }
    print("#initUser complete");
  }

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


         // todo  :check wether if user not log out then got to their resplective
      //  home screen if not then got the login screen

      if(FirebaseAPIs.auth.currentUser != null){
        initUser();
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen())) ;
      }




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
                      "EduFlow",
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
