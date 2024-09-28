import 'package:flutter/material.dart';
import 'package:teach_assist/Components/CustomTextField.dart';

import '../../Components/EnrolledStudentCard.dart';
import '../../Models/Student.dart';
import '../../Utils/ThemeData/colors.dart';

class Enrolledstudents extends StatefulWidget {
  const Enrolledstudents({super.key});

  @override
  State<Enrolledstudents> createState() => _EnrolledstudentsState();
}

class _EnrolledstudentsState extends State<Enrolledstudents> {
  
  Student st  =  Student(id: "12",name: "Hitesh Mori",rollNo: "22BCE197",currentSem: "4",departmentId: "CSE",allocatedSubjects: []);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: CustomTextField(
                    hintText: "Search Students",
                    isNumber: false,
                    obsecuretext: false,
                    prefixicon: Icon(Icons.search_rounded),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                          // todo: add here stream builder of students that are enrolled in specific course
                          
                       children: [
                            // example
                            // already enrolled
                            EnrolledStudentCard(st: this.st, isEnrolled: true),
                           //  not enrolled
                            EnrolledStudentCard(st: this.st, isEnrolled: false),

                       ],


                        )
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
