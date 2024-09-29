import 'package:flutter/material.dart';
import 'package:teach_assist/Models/LectureHistory.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

class SessionhistoryCard extends StatefulWidget {
  final LectureHistory lh;
  const SessionhistoryCard({super.key, required this.lh});

  @override
  State<SessionhistoryCard> createState() => _SessionhistoryCardState();
}

class _SessionhistoryCardState extends State<SessionhistoryCard> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Container(
        height: 100,
        width: mq.width * 1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.lh.date,
                      style: TextStyle(
                        color: AppColors.theme['black'],
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      widget.lh.roomNo.roomNumber ?? "", 
                      style: TextStyle(
                        color: AppColors.theme['black'],
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Presents: ${widget.lh.presentStudents ?? 0}",
                      style: TextStyle(
                        color: AppColors.theme['black'],
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Absents: ${widget.lh.absentStudents ?? 0}",
                      style: TextStyle(
                        color: AppColors.theme['black'],
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
