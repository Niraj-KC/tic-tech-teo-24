import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/Models/ClassRoom.dart';
import 'package:teach_assist/Models/LectureHistory.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';
import '../../../Components/Attendance/SessionHistoryCard.dart';
import '../../../Utils/ThemeData/colors.dart';

class SessionHistory extends StatefulWidget {
  const SessionHistory({super.key});

  @override
  State<SessionHistory> createState() => _SessionHistoryState();
}

class _SessionHistoryState extends State<SessionHistory> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserProvider>(builder: (context, val, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.theme['offWhite'],
          appBar: AppBar(
            backgroundColor: AppColors.theme['green'],
            title: Text(
              "Session History - ${val.user.name}",
              style: TextStyle(
                  color: AppColors.theme['white'],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  SessionhistoryCard(
                    lh: LectureHistory(
                      date: "28-09-2024",
                      roomNo: Classroom(latitude: 3.44, longitude: 3.4, roomNumber: "D104"),
                      presentStudents: 45,
                      absentStudents: 5,
                    ),
                  ),
                  SessionhistoryCard(
                    lh: LectureHistory(
                      date: "27-09-2024",
                      roomNo: Classroom(latitude: 3.50, longitude: 3.5, roomNumber: "D301"),
                      presentStudents: 50,
                      absentStudents: 0,
                    ),
                  ),
                  SessionhistoryCard(
                    lh: LectureHistory(
                      date: "24-09-2024",
                      roomNo: Classroom(latitude: 3.60, longitude: 3.6, roomNumber: "N401"),
                      presentStudents: 49,
                      absentStudents: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
