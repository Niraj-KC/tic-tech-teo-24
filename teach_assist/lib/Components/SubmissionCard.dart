import 'package:flutter/material.dart' ;

import '../Utils/ThemeData/colors.dart';

class SubmissionCard extends StatefulWidget {
  const SubmissionCard({super.key});

  @override
  State<SubmissionCard> createState() => _SubmissionCardState();
}

class _SubmissionCardState extends State<SubmissionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10,
            width: 10,
            color: AppColors.theme['offWhite'],
            child: Text("17 Sept"),
          ),
          Column(
            children: [
              Text("Machine Leaning"),
              Text("2CS501")
            ],
          ),
          ElevatedButton(
            onPressed: (){},
            child: Text("Add Submission"),
          )
        ],
      ),
    );
  }
}
