import 'package:flutter/material.dart';
import 'package:teach_assist/Components/CourseCard2.dart';
import 'package:teach_assist/Models/Subject.dart';
import 'package:teach_assist/Screens/TeacherScreens/TeacherHomeScreen.dart';
import 'package:teach_assist/Transitions/LeftToRight.dart';
import '../../../Utils/ThemeData/colors.dart';
import 'HomeWorkScreen.dart';

class AllCourseHomeWork extends StatefulWidget {
  const AllCourseHomeWork({super.key});

  @override
  State<AllCourseHomeWork> createState() => _AllCourseHomeWorkState();
}

class _AllCourseHomeWorkState extends State<AllCourseHomeWork> {

  // example subject..
  Subject subject = Subject(id: "34",name: "Ethical Hacking",courseCode: "2CS401CC24",coursePolicy: "",materials: [],studentsEnrolled: []);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        appBar: AppBar(
          backgroundColor: AppColors.theme['green'],
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, LeftToRight(TeacherHomeScreen()) );
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 25,
                color: Colors.white,
              )),
          title: Text(
            "My Courses",
            style: TextStyle(
                color: AppColors.theme['white'],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: Column(
              children: [

                // todo: fetch all course that are concent with teacher and pass course one by one in below card
                // example
                CourseCard2(sb: subject,onTap: (){
                  Navigator.push(context, LeftToRight(HomeWorkScreen(subject: subject,))) ;
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
