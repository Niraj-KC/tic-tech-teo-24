import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/API/FireStoreAPIs/homeworkService.dart';
import 'package:teach_assist/Components/HomeworkComponents/HomeWorkCard.dart';
import 'package:teach_assist/Models/Homework.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';

import '../../Components/HomeworkCard.dart';
import '../../Utils/ThemeData/colors.dart';
import '../../main.dart';

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
            return Container(
              height: mq.height*.98,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40),
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

                    // Column(
                    //   // children: dummyHomeworkData.where((hw) => !hw.isSubmitted).map((e) => HomeworkCard(homework: e)).toList(),
                    // )
                    Expanded(
                      child: StreamBuilder<Map<String, Map<String, List<Homework>>>>(
                        stream: HomeworkService().getHomeworkListForStudentGroupedByCourse(currentUserProvider.user),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text("No homework available."));
                          }
                      
                          // Extract grouped homework
                          final groupedHomework = snapshot.data!;
                      
                          return ListView(
                            children: groupedHomework.entries.map((entry) {
                              final courseName = entry.key; // Course name
                              final homeworkByTitle = entry.value; // Map of homework grouped by title
                      
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: homeworkByTitle.entries.map((titleEntry) {
                                  final homeworkTitle = titleEntry.key; // Homework title
                                  final homeworkList = titleEntry.value; // List of homeworks with this title
                      
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ...homeworkList.map((homework) {
                                        return HomeworkCard(
                                          homework: homework,
                                        );
                                      }).toList(),
                                      const SizedBox(height: 10), // Add spacing between courses
                                    ],
                                  );
                                }).toList(),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),


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


class HomeworkDetailPage extends StatelessWidget {
  final Homework homework;

  const HomeworkDetailPage({Key? key, required this.homework}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homework.title ?? "Homework Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${homework.title ?? "No Title"}", style: TextStyle(fontSize: 24)),
            SizedBox(height: 16),
            Text("Question URL: ${homework.gDriveQuestionUrl ?? "No URL"}"),
            // Add more homework details as needed
          ],
        ),
      ),
    );
  }
}
