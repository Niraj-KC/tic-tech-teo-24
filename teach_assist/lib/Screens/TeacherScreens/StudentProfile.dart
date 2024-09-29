import 'package:flutter/material.dart' ;
import 'package:teach_assist/Utils/ThemeData/colors.dart';


class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        appBar: AppBar(
          title: Text("Student Profile",style: TextStyle(color: AppColors.theme['black'],fontWeight: FontWeight.bold,fontSize: 18),),
          backgroundColor: AppColors.theme['green'],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:   10.0,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enrolled Subject : ")

              //todo : fatch here all students subjects


            ],
          ),
        ),
      ),
    );
  }
}
