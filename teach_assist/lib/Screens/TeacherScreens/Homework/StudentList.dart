import 'package:flutter/material.dart';
import 'package:teach_assist/Screens/TeacherScreens/Homework/HomeWorkScreen.dart';
import 'package:teach_assist/Transitions/LeftToRight.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

import '../../../Components/HomeworkComponents/StudentCard.dart';

// todo : fetch all student details, including..
//submission
//marks
//name

class StudentList extends StatefulWidget {


  // final homework or submission
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        appBar:AppBar(
          backgroundColor: AppColors.theme['green'],
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios_new_rounded,size: 25,color: Colors.white,)),
          title:Text("Homework 1",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
        ),

        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              //example card

              StudentCard(),
            ],
          ),
        ),

      ),
    );
  }
}
