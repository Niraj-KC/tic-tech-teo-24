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
                      // children: dummyHomeworkData.where((hw) => !hw.isSubmitted).map((e) => HomeworkCard(homework: e)).toList(),
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
