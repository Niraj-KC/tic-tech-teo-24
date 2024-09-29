import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/Models/Homework.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';

import '../../Components/SubmissionCard.dart';
import '../../Utils/ThemeData/colors.dart';

class UpcomingSubmissionScreen extends StatefulWidget {
  const UpcomingSubmissionScreen({super.key});

  @override
  State<UpcomingSubmissionScreen> createState() =>
      _UpcomingSubmissionScreenState();
}

class _UpcomingSubmissionScreenState extends State<UpcomingSubmissionScreen> {
  List<Homework> dummyHomeworkData = [
    Homework(
      title: 'Math Homework 1',
      courseId: 'MATH101',
      courseName: 'Calculus I',
      id: 'HW001',
      gDriveQuestionUrl: 'https://drive.google.com/sample-question-url-1',
      gDriveReferenceAnswerUrl: 'https://drive.google.com/sample-reference-url-1',
      timeStampCreated: '2024-09-25 10:00:00',
      timeStampDueDate: '2024-10-01 23:59:59',
    ),
    Homework(
      title: 'Physics Homework 2',
      courseId: 'PHYS201',
      courseName: 'Classical Mechanics',
      id: 'HW002',
      gDriveQuestionUrl: 'https://drive.google.com/sample-question-url-2',
      gDriveReferenceAnswerUrl: 'https://drive.google.com/sample-reference-url-2',
      timeStampCreated: '2024-09-26 12:30:00',
      timeStampDueDate: '2024-10-03 23:59:59',
    ),
    Homework(
      title: 'Chemistry Homework 3',
      courseId: 'CHEM101',
      courseName: 'Organic Chemistry',
      id: 'HW003',
      gDriveQuestionUrl: 'https://drive.google.com/sample-question-url-3',
      gDriveReferenceAnswerUrl: 'https://drive.google.com/sample-reference-url-3',
      timeStampCreated: '2024-09-27 14:15:00',
      timeStampDueDate: '2024-10-05 23:59:59',
    ),
  ];

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        body: SafeArea(
          child: Consumer<CurrentUserProvider>(builder: (context, currentUserProvider, child){
            return Padding(
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
                    SizedBox(height: 20,),

                    Column(
                      children: dummyHomeworkData.where((hw) => !hw.isSubmitted).map((e) => HomeworkCard(homework: e)).toList(),
                    )

                  ],
                ),
              ),
            );
          },),
        ),
      ),
    );
  }
}
