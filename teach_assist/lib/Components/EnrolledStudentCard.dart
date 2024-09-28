import 'package:flutter/material.dart';
import '../Models/Student.dart';
import '../Utils/ThemeData/colors.dart';

class EnrolledStudentCard extends StatefulWidget {
  final Student st;
  final bool isEnrolled;

  const EnrolledStudentCard({super.key, required this.st, required this.isEnrolled});

  @override
  State<EnrolledStudentCard> createState() => _EnrolledStudentCardState();
}

class _EnrolledStudentCardState extends State<EnrolledStudentCard> {
  late bool _isEnrolled;
  late bool _isChecked; // To track the checkbox state

  @override
  void initState() {
    super.initState();
    _isEnrolled = widget.isEnrolled;
    _isChecked = false; // Initially not checked for non-enrolled students
  }

  void toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.theme['offWhite'],
      child: ListTile(
        tileColor: AppColors.theme['offWhite'],
        leading: _isEnrolled
            ? Icon(
          Icons.verified_user,
          color: AppColors.theme['green'],
        ) // Show the verified icon for enrolled students
            : Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            toggleCheckbox(); // Toggle the checkbox on click
          },
          activeColor: AppColors.theme['green'],
        ), // Show the checkbox for non-enrolled students
        title: Text(
          widget.st.name ?? "",
          style: TextStyle(
            color: AppColors.theme['black'],
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.st.rollNo ?? "",
          style: TextStyle(color: AppColors.theme['black']),
        ),
        // No trailing icon used
      ),
    );
  }
}
