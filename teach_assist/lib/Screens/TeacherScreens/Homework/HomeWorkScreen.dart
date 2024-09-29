import 'package:flutter/material.dart' ;
import 'package:teach_assist/Screens/TeacherScreens/Homework/StudentList.dart';
import 'package:teach_assist/Transitions/LeftToRight.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

import '../../../Components/HomeworkComponents/HomeWorkCard.dart';
import '../../../Models/Subject.dart';
import 'AllCourseHomework.dart';

class HomeWorkScreen extends StatefulWidget {

  final Subject subject ;
  const HomeWorkScreen({super.key, required this.subject});

  @override
  State<HomeWorkScreen> createState() => _HomeWorkScreenState();
}

class _HomeWorkScreenState extends State<HomeWorkScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Navigator.push(context, LeftToRight(AllCourseHomeWork()));
          }, icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 25,)),
         backgroundColor: AppColors.theme['green'],
          title: Center(
            child: Text(
              widget.subject.name ?? "",
              style: TextStyle(
                  color: AppColors.theme['white'],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),

        ),

        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [

              //todo:fetch all homeworks  of subject like 1,2,3,4,5..etc
              //and display using below card

              HomeWorkCard(onTap: () {
                Navigator.push(context, LeftToRight(StudentList()));
              },),



            ],
          ),
        ),
      ),
    );
  }

}
