import 'package:flutter/material.dart';
import 'package:teach_assist/Models/Submission.dart';

import '../../Components/SubmissionCard.dart';
import '../../Utils/ThemeData/colors.dart';

class UpcomingSubmissionScreen extends StatefulWidget {
  const UpcomingSubmissionScreen({super.key});

  @override
  State<UpcomingSubmissionScreen> createState() =>
      _UpcomingSubmissionScreenState();
}

class _UpcomingSubmissionScreenState extends State<UpcomingSubmissionScreen> {
  Submission sb1 = Submission(
  submissionId: "sub_12345",
  studentId: "stu_67890",
  courseId: "course_001",
  courseName: "Data Structures and Algorithms",
  submissionName: "Assignment 1",
  submissionCloseDate: "1414721505539",
  pdfDriveLink: ""
  );

  Submission sb2 = Submission(
      submissionId: "sub_12345",
      studentId: "stu_67890",
      courseId: "course_001",
      courseName: "Ethical Hacking",
      submissionName: "Practical 5",
      submissionCloseDate: "1727529198337",
      pdfDriveLink: ""
  );
  Submission sb3 = Submission(
      submissionId: "sub_12345",
      studentId: "stu_67890",
      courseId: "course_001",
      courseName: "Ethical Hacking",
      submissionName: "Practical 3",
      submissionCloseDate: "1732294873907",
      pdfDriveLink: ""
  );

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Submissions",
                    style: TextStyle(
                        color: AppColors.theme['black'],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  SubmissionCard(sb: sb1,),
                  SubmissionCard(sb: sb2,),
                  SubmissionCard(sb: sb3,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
