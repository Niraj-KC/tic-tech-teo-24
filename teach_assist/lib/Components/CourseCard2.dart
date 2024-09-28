import 'package:flutter/material.dart' ;
import '../Models/Subject.dart';
import '../Utils/ThemeData/colors.dart';

class CourseCard2 extends StatefulWidget {
  final Subject sb ;
  final VoidCallback ? onTap ;
  const CourseCard2({super.key, required this.sb, this.onTap});

  @override
  State<CourseCard2> createState() => _CourseCard2State();
}

class _CourseCard2State extends State<CourseCard2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 5),
      child: InkWell(
        onTap: widget.onTap,
        child: Material(
          elevation: 0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          child: Card(
            elevation: 0,
            color: AppColors.theme['white'],
            child: ListTile(
              tileColor: AppColors.theme['white'],
              leading: Icon(Icons.subject_rounded),
              title: Text(
                widget.sb.name ?? "",
                style: TextStyle(
                  color: AppColors.theme['black'],
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                widget.sb.courseCode ?? "",
                style: TextStyle(color: AppColors.theme['black']),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
