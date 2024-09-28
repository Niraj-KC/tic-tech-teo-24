import 'package:flutter/material.dart';

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
        backgroundColor: AppColors.theme['white'],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
            child: Column(
              children: [
                Text(
                  "Upcoming Submissions",
                  style: TextStyle(
                      color: AppColors.theme['black'],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SubmissionCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
